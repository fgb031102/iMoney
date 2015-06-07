//
//  TypeConvert.m
//  iTravel
//
//  Created by Yongfei He on 14-5-14.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import "TypeConvert.h"

static TypeConvert *g_instance = nil;

@implementation TypeConvert


+(TypeConvert*) getShareInstance{
    if (!g_instance) {
        g_instance = [[TypeConvert alloc] init];
    }
    
    return g_instance;
}

+(NSString*) id2NSString:(id)obj{
    return obj == [NSNull null] ? @"" : obj;
}

+(NSInteger) id2NSInteger:(id)obj{
    return obj == [NSNull null] ? 0 : [obj intValue];
}

+(BOOL) id2BOOL:(id)obj{
    return obj == [NSNull null] ? YES : [obj boolValue];
}

+(NSDate*) id2Date:(id)obj{
    if (obj == [NSNull null]){
        return nil;
    }
    else{
        NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *_date = [_dateFormatter dateFromString:obj];
        
        return _date;
    }
}

+(NSDate*) id2LocalDate:(id)obj{
    if (obj == [NSNull null]){
        return nil;
    }
    else{
        NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *_date = [_dateFormatter dateFromString:obj];
        NSDate *locaDate = [PublicUtility convertUTC2Local:_date];
        return locaDate;
    }
}

+(float) id2float:(id)obj{
    return obj == [NSNull null] ? 0.0f : [obj floatValue];
}


@end
