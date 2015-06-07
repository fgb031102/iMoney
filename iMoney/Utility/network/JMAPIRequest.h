//
//  JMAPIRequest.h
//  AudioJoke
//
//  Created by heyf on 3/22/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMFileASIHTTPRequest.h"
#import "JMJsonASIHTTPRequest.h"

@interface JMAPIRequest : NSObject <NSURLConnectionDelegate> {
}

+ (NSString *)apiUrl:(NSString *)url;

+ (void) uploadTo:(NSString *)path withForm:(NSMutableDictionary*)form response:(netCallBackBlock)callBack;

//json
+ (void) requestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)response;
+ (void) offlineRequestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)response;

//sync get
+ (id) syncRequestWithMethod:(NSString*)method path:(NSString *)path params:(NSDictionary *)params;

//file
+ (void) getFileFromPath:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)callBack;
+ (void) onlineGetFileFromPath:(NSString *)path params:(NSDictionary *)params response:(netCallBackBlock)callBack;

//convinence 
@end
