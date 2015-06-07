//
//  InstitutionModel.h
//  IQPlatform
//
//  Created by hulin on 15-1-1.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "MQDataArrayModel.h"

@interface InstitutionModel : MQDataArrayModel

@property  NSString * key_name;
@property  NSString * create_time;
@property  NSString * key_id;

-(id)initWithData:(NSDictionary *)dict;
-(void)getMyKeyListByToken:(NSString *) token callFunc:(dataParseCallBackBlock)callBack;

@end
