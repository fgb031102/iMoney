//
//  JMASIHTTPRequest.h
//  AudioJoke
//
//  Created by Yongfei He on 6/21/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"

typedef void (^netCallBackBlock)(id, NSInteger);

@interface  RequestUserData:NSObject

@property  (nonatomic, strong)  netCallBackBlock callBack;
@property  (nonatomic)  BOOL bPromptNoNetWork;
@property  (nonatomic)  BOOL bCanOffline;

@end


@interface JMASIHTTPRequest : NSObject{
    ASINetworkQueue *networkQueue;
}

@end
