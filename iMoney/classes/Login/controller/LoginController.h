//
//  LoginController.h
//  iPregnant
//
//  Created by heyunfei on 14-8-3.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MQDataArrayModel.h"
#import "UserModel.h"
@interface LoginController : MQDataArrayModel
-(void)getLoginValidateFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
-(void)getRegisterValidateFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
-(void)getCheckCode:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
-(void)findPasswordCheckCode:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
-(void)findPasswordFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
-(void)modifyPasswordFromServer:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
@end
