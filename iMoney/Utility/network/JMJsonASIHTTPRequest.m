//
//  JMJsonASIHTTPRequest.m
//  AudioJoke
//
//  Created by Yongfei He on 6/21/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import "JMJsonASIHTTPRequest.h"
#import "SVStatusHUD.h"

static JMJsonASIHTTPRequest *_jmRequest = nil;

@implementation JMJsonASIHTTPRequest 

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

+(JMJsonASIHTTPRequest*)getInstance{
    if (!_jmRequest) {
        _jmRequest = [[JMJsonASIHTTPRequest alloc] init];
    }
    
    return _jmRequest;
}

static BOOL bOnline = TRUE;
- (void)dataFetchComplete:(ASIHTTPRequest *)request{
    bOnline = YES;
    
    RequestUserData *shareData = [request.userInfo objectForKey:@"shareData"];
    
    @try {
        NSData *data = [[NSData alloc] initWithContentsOfFile:request.downloadDestinationPath];
        NSError * jsonError;
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if (!obj) {
            NSLog(@"error log %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (shareData.callBack){
                shareData.callBack(obj, 200);
            }
        });
    }
    @catch (...) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (shareData.callBack){
                shareData.callBack(nil, -1);
            }
        });
    }
}

- (void)dataFetchFailed:(ASIHTTPRequest *)request{
    RequestUserData *shareData = [request.userInfo objectForKey:@"shareData"];
    
    @try {
            if (bOnline) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[SVStatusHUD showWithStatus:@"网络不给力，进入离线浏览模式。"];
                });
                bOnline = FALSE;
            }
            
            //offline browse
            if([[NSFileManager defaultManager] fileExistsAtPath:request.downloadDestinationPath] && shareData.bCanOffline){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (shareData.callBack){
                        NSData *data = [[NSData alloc] initWithContentsOfFile:request.downloadDestinationPath];
                        NSError * jsonError;
                        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (shareData.callBack){
                                shareData.callBack(obj, 200);
                            }
                        });
                    }
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (shareData.callBack)
                        shareData.callBack(nil, -1);
                });
            }
    }
    @catch (...) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (shareData.callBack){
                shareData.callBack(nil, -1);
            }
        });
    }
}

-(void)addOneRequest:(NSString*) url withPath:(NSString*)downloadPath callBack:(netCallBackBlock)callback bCanOffline:(BOOL)bCanOffline{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
	[request setDownloadDestinationPath:downloadPath];
    [request setTimeOutSeconds:15];
    RequestUserData *shareData = [[RequestUserData alloc] init];
    shareData.callBack = callback;
    shareData.bCanOffline = bCanOffline;
    [request setUserInfo:[NSDictionary dictionaryWithObject:shareData forKey:@"shareData"]];
	[networkQueue addOperation:request];
}

-(id)addOneSyncRequest:(NSString*)url{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setTimeOutSeconds:5];
    [request startSynchronous];
    
    NSData *data = [request responseData];
    if (data) {
        NSError * jsonError;
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSError *error = [request error];
        if (!error)
            return obj;
    }
    
    return nil;
}

@end
