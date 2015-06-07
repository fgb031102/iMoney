//
//  JMASIHTTPRequest.m
//  AudioJoke
//
//  Created by Yongfei He on 6/21/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import "JMFileASIHTTPRequest.h"

static JMFileASIHTTPRequest *_jmRequest = nil;

@implementation JMFileASIHTTPRequest{
}

-(id)init{
    self = [super init];
    if (self) {
        networkQueue = [[ASINetworkQueue alloc] init];
        [networkQueue reset];
        [networkQueue setRequestDidFinishSelector:@selector(dataFetchComplete:)];
        [networkQueue setRequestDidFailSelector:@selector(dataFetchFailed:)];
        [networkQueue setDelegate:self];
        [networkQueue go];
    }
    return self;
}

+(JMFileASIHTTPRequest*)getInstance{
    if (!_jmRequest) {
        _jmRequest = [[JMFileASIHTTPRequest alloc] init];
    }
    
    return _jmRequest;
}

- (void)dataFetchComplete:(ASIHTTPRequest *)request{
    //netCallBackBlock callBack = [request.userInfo objectForKey:@"callback"];

   // dispatch_async(dispatch_get_main_queue(), ^{
        if (self.callbackBlock){
            self.callbackBlock(request.downloadDestinationPath, 200);
        }
   // });
}

- (void)dataFetchFailed:(ASIHTTPRequest *)request{
    //netCallBackBlock callBack = [request.userInfo objectForKey:@"callback"];

    {
        //offline browse
        if([[NSFileManager defaultManager] fileExistsAtPath:request.downloadDestinationPath]){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.callbackBlock){
                    self.callbackBlock(request.downloadDestinationPath, 200);
                }
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.callbackBlock)
                    self.callbackBlock(nil, -1);
            });
            return;
        }
   }
}

-(void)addOneRequest:(NSString*) url withPath:(NSString*)downloadPath callBack:(netCallBackBlock)callback{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setTimeOutSeconds:30];
	[request setDownloadDestinationPath:downloadPath];
    self.callbackBlock=callback;
    [request setUserInfo:[NSDictionary dictionaryWithObject:callback forKey:@"callback"]];
	[networkQueue addOperation:request];
}




@end
