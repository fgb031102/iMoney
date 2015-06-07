//
//  myController.h
//  IQPlatform
//
//  Created by heyunfei on 15-1-7.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQDataArrayModel.h"
#import "JMAPIRequest.h"
@interface myController : MQDataArrayModel
-(void)feedBackAdvice:(NSMutableDictionary*)param dataCallback:(dataParseCallBackBlock)callBack;
@end
