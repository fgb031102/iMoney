//
//  LoginController.m
//  iPregnant
//
//  Created by heyunfei on 14-8-3.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "LoginController.h"
#import "JMAPIRequest.h"
@implementation LoginController
-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)getLoginValidateFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"register_user/login/";
    [JMAPIRequest offlineRequestWithMethod:@"GET" path:apiUrl params:param response:^(id data, NSInteger statusCode) {
        if (![PublicUtility handleNetworkwithNoPromptRet:data Status:statusCode]) {
            if (!data || data==[NSNull null]) {
                [SVStatusHUD showWithStatus:@"请稍后再试"];
            }
            else{
                [SVStatusHUD showWithStatus:[data objectForKey:@"errdesc"]];
            }
            callBack(-1);
        }else{
            [self parseJson:data];
            callBack(statusCode);
        }
    }];
}

-(void)parseJson:(NSDictionary*)dict{
    NSLog(@"%@",dict);
    if ([[dict objectForKey:@"errcode"] intValue] != 0) {
        NSLog(@"MyInputQuestionListModel parse error");
        return;
    }
    UserModel *user;
    if ([GlobalVar share].user) {
        user=[GlobalVar share].user;
    }
    else{
        user=[[UserModel alloc]init];
    }
    user.create_time=[[dict objectForKey:@"data"] objectForKey:@"create_time"];
    user.device_token=[[dict objectForKey:@"data"] objectForKey:@"device_token"];
    user.device_type=[[dict objectForKey:@"data"] objectForKey:@"device_type"];
    user.email=[[dict objectForKey:@"data"] objectForKey:@"email"];
    user.header_picture_url=[[dict objectForKey:@"data"] objectForKey:@"header_picture_url"];
    
    user.last_login_time=[[dict objectForKey:@"data"] objectForKey:@"last_login_time"];
    user.login_token=[[dict objectForKey:@"data"] objectForKey:@"login_token"];
    user.mobile=[[dict objectForKey:@"data"] objectForKey:@"mobile"];
    user.password=[[dict objectForKey:@"data"] objectForKey:@"password"];
    user.register_type=[[dict objectForKey:@"data"] objectForKey:@"register_type"];
    user.userid=[[dict objectForKey:@"data"] objectForKey:@"user_id"];
    user.user_name=[[dict objectForKey:@"data"] objectForKey:@"user_name"];
    user.user_score=[[dict objectForKey:@"data"] objectForKey:@"user_score"];
    
    [GlobalVar share].user=user;
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject: [NSKeyedArchiver archivedDataWithRootObject:user] forKey:@"user_data"];
    [ud synchronize];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogin" object:nil];
    
    [self submitBaiduID];   //向后台更新百度推送ID
}
-(void)getRegisterValidateFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"register_user/register_new_user/";
    [JMAPIRequest offlineRequestWithMethod:@"GET" path:apiUrl params:param response:^(id data, NSInteger statusCode) {
        if (![PublicUtility handleNetworkwithNoPromptRet:data Status:statusCode]) {
            if (!data || data==[NSNull null]) {
                [SVStatusHUD showWithStatus:@"请稍后再试"];
            }
            else{
                [SVStatusHUD showWithStatus:[data objectForKey:@"errdesc"]];
            }
            callBack(-1);
        }else{
            [self parseJson:data];
            callBack(statusCode);
        }
    }];
}
-(void)getCheckCode:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"register_user/send_sms_code/";
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
-(void)findPasswordCheckCode:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"users/forget_password_sms_code/";
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
-(void)findPasswordFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"users/reset_password_mobile/";
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
-(void)modifyPasswordFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack{
    NSString *apiUrl = @"users/reset_password/";
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
-(void)submitBaiduID
{
    if ([GlobalVar share].user.login_token == nil) {
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *apiUrl = @"users/update_device_token/";
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"BDpush"];
    NSArray *arr=[str componentsSeparatedByString:@","];
    if (arr.count<2) {
        return;
    }
    [params setValue: [GlobalVar share].user.login_token forKey:@"login_token"];
    [params setValue: @"4" forKey:@"device_type"];
    [params setValue: [arr objectAtIndex:0] forKey:@"push_user_id"];
    [params setValue: [arr objectAtIndex:1]  forKey:@"push_channel_id"];
    
    [JMAPIRequest offlineRequestWithMethod:@"GET" path:apiUrl params:params response:^(id data, NSInteger statusCode) {
        if (![PublicUtility handleNetworkwithNoPromptRet:data Status:statusCode]) {
            NSLog(@"###submit BaiduID fail!");
        }else{
            NSLog(@"###submit BaiduID success!");
        }
    }];
}

@end
