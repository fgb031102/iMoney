//
//  JMASIHTTPRequest.h
//  AudioJoke
//
//  Created by Yongfei He on 6/21/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMASIHTTPRequest.h"


@interface JMFileASIHTTPRequest : JMASIHTTPRequest{
    
}
@property(nonatomic,strong)netCallBackBlock callbackBlock;
-(void)addOneRequest:(NSString*) url withPath:(NSString*)downloadPath callBack:(netCallBackBlock)callback;


+(JMFileASIHTTPRequest*) getInstance;

@end
