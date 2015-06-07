//
//  TypeConvert.h
//  iTravel
//
//  Created by Yongfei He on 14-5-14.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeConvert : NSObject

+(TypeConvert*) getShareInstance;

+(NSString*) id2NSString:(id)obj;
+(NSInteger) id2NSInteger:(id)obj;
+(BOOL) id2BOOL:(id)obj;
+(float) id2float:(id)obj;
+(NSDate*) id2Date:(id)obj;
+(NSDate*) id2LocalDate:(id)obj;

@end
