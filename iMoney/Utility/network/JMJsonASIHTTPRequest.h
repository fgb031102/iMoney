//
//  JMJsonASIHTTPRequest.h
//  AudioJoke
//
//  Created by Yongfei He on 6/21/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMASIHTTPRequest.h"

@interface JMJsonASIHTTPRequest : JMASIHTTPRequest

-(void)addOneRequest:(NSString*) url withPath:(NSString*)downloadPath callBack:(netCallBackBlock)callback bCanOffline:(BOOL)bCanOffline;

-(id)addOneSyncRequest:(NSString*)url;

+(JMJsonASIHTTPRequest*) getInstance;

@end
