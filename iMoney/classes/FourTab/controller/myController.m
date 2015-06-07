//
//  myController.m
//  IQPlatform
//
//  Created by heyunfei on 15-1-7.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "myController.h"

@implementation myController
-(void)feedBackAdvice:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"users/publish_feed_back/";
    [JMAPIRequest offlineRequestWithMethod:@"GET" path:apiUrl params:param response:^(id data, NSInteger statusCode) {
        NSLog(@"%@",data);
        if (![PublicUtility handleNetworkwithNoPromptRet:data Status:statusCode]) {
            if (!data || data==[NSNull null]) {
                [SVStatusHUD showWithStatus:@"请稍后再试"];
            }
            else{
                [SVStatusHUD showWithStatus:[data objectForKey:@"errdesc"]];
            }
            callBack(-1);
        }else{
            callBack(statusCode);
        }
    }];
}
@end
