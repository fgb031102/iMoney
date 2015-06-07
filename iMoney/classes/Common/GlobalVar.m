//
//  GlobalVar.m
//  StockSeek
//
//  Created by heyunfei on 14-1-12.
//  Copyright (c) 2014年 StockSeek. All rights reserved.
//

#import "GlobalVar.h"
#import "Reachability.h"
static GlobalVar *instance;
@implementation GlobalVar

+(GlobalVar*)share{
    if (instance==nil) {
        instance=[[GlobalVar alloc]init];
    }
    return instance;
}
-(BOOL)isIncludeSpecialCharact: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
-(BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}

@end
