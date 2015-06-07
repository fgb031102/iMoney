//
//  JMAPIRequest.h
//  AudioJoke
//
//  Created by heyf on 3/22/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import "JMAPIRequest.h"
#import "AppDelegate.h"
#import "SVStatusHUD.h"
#import "stdlib.h"
#import "PublicUtility.h"

#define API_BASE_URL    @"http://123.56.101.10/iQ/"

@implementation JMAPIRequest

+ (NSString *)apiUrl:(NSString *)url {
    static NSString *apiBase = @"";
    if ([apiBase isEqualToString:@""]) {
        apiBase = [self getAPIUrlByVersion];
    }
    return [NSString stringWithFormat:@"%@%@", apiBase, url, nil];
}

+(NSString*)getAPIUrlByVersion{
    NSString *defaultApiUrl = [NSString stringWithFormat:@"%@", API_BASE_URL];
    return defaultApiUrl;
}

+ (void) uploadTo:(NSString *)path withForm:(NSMutableDictionary*)form response:(netCallBackBlock)callBack {
    NSString *boundary = @"168072824752491622650073"; 
    
    NSMutableString * urlBuffer =[[NSMutableString alloc] init];
    [urlBuffer appendString: [self apiUrl:path]];
    
    NSURL * url = [NSURL URLWithString:urlBuffer];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:url];
    [request setTimeoutInterval:10.0f];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // Body
    NSMutableData *bodyData = [NSMutableData data];
    
    // Prepare mutipart form-data
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for(NSString * key in form) {
        id value = [form objectForKey:key];
        if ([value isKindOfClass:[UIImage class]]) {
            UIImage * image = (UIImage *)value;
            [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            NSString *cc = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.png\" \r\n", [PublicUtility generateUID]];
            [bodyData appendData:[cc dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)]];
        }else if ([value isKindOfClass:[NSData class]]) {
            NSData *data = (NSData *)value;
            [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[@"Content-Disposition: form-data; name=\"mp3\"; filename=\"audiojoke.mp3\" \r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[@"Content-Type: audio/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:data];
        } else {
            NSString * strValue = (NSString *)value;
            [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyData appendData:[strValue dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [bodyData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // End
    [bodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Append data
    [request setHTTPBody:bodyData];
        
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:app.requestQueue completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error.code ==  -1012) {
                    NSLog(@"Error on requesting %@ %@", path, [error description]);
                }
                if (callBack)
                    callBack(nil, -1);
            });
        } else {
            NSError * jsonError;
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = [httpResponse statusCode];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(statusCode == 401) {
                    callBack(nil, -1);
                } else {
                    callBack(obj, statusCode);
                }
            });
        }
    }];
}

+ (id) requestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params canOffline:(BOOL) bCanOffline response:(netCallBackBlock)callBack {
    NSMutableString * urlBuffer =[[NSMutableString alloc] init];
    [urlBuffer appendString: [self apiUrl:path]];
    
    //get md5 key before append token, token is updated frequently by server
    NSString* key = [PublicUtility MD5StringOfString:[urlBuffer stringByAppendingString:[PublicUtility dictionary2Base64jsonString:params]]];
    
    NSString *queryBuffer = [PublicUtility dictionary2Base64jsonString:params];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:method];
    if([method isEqualToString:@"GET"]) {
        if(queryBuffer.length > 0 ) {
            [urlBuffer appendString:queryBuffer];
            NSLog(@"%@",urlBuffer);
        }
    } else {
        // method is POST
        [request setHTTPBody: [queryBuffer dataUsingEncoding:NSStringEncodingConversionAllowLossy]];
    }
    
    //offline file
    NSMutableString* downloadsPath = [[NSMutableString alloc] initWithFormat:@"%@",  NSTemporaryDirectory()];
    [downloadsPath appendString:@"Documents/json/"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:downloadsPath]) {
        //make dir
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadsPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    NSString* fileName = [[NSString alloc] initWithFormat:@"%@/%@.json", downloadsPath, key];
    
    JMJsonASIHTTPRequest *shareApplication = [JMJsonASIHTTPRequest getInstance];
    if (callBack != nil) {
        [shareApplication addOneRequest:urlBuffer withPath:fileName callBack:callBack bCanOffline:bCanOffline];
    }else
        return [shareApplication addOneSyncRequest:urlBuffer];
    
    return nil;
}

+ (void) getFileFromPath:(NSString *)path params:(NSDictionary *)params canOffline:(BOOL) bCanOffline response:(netCallBackBlock)callBack {
    if (path == nil){
        callBack(@"", 0);
        return;
    }
    
    NSMutableString * urlBuffer =[[NSMutableString alloc] init];
    [urlBuffer appendString: path];

    //before append token, token is updated by server frequently
    NSString* key = [PublicUtility MD5StringOfString:urlBuffer];
            
    NSMutableString* downloadsPath = [[NSMutableString alloc] initWithFormat:@"%@",  NSTemporaryDirectory()];
    [downloadsPath appendString:@"Documents/Files/"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:downloadsPath]) {
        //make dir
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadsPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    NSString* fileName = [[NSString alloc] initWithFormat:@"%@%@.%@", downloadsPath, key, [path pathExtension]];
    
    //exist
    if([[NSFileManager defaultManager] fileExistsAtPath:fileName] && callBack && bCanOffline){
        callBack(fileName, 0);
        return;
    }
    
    JMFileASIHTTPRequest *shareApplication = [JMFileASIHTTPRequest getInstance];
    [shareApplication addOneRequest:urlBuffer withPath:fileName callBack:callBack];        
}

+ (void) offlineRequestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)response{
    [self requestWithMethod:method path:path params:params canOffline:TRUE response:response];
}

+ (void) requestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)callBack{
    [self requestWithMethod:method path:path params:params canOffline:FALSE response:callBack];
}

+ (id) syncRequestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params{
    return [self requestWithMethod:method path:path params:params canOffline:FALSE response:nil];
}

+ (void) onlineGetFileFromPath:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)callBack{
    [self getFileFromPath:path params:params canOffline:NO response:callBack];
}

+ (void) getFileFromPath:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)callBack{
    [self getFileFromPath:path params:params canOffline:YES response:callBack];
}

@end
