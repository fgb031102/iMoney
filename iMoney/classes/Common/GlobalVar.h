//
//  GlobalVar.h
//  StockSeek
//
//  Created by heyunfei on 14-1-12.
//  Copyright (c) 2014年 StockSeek. All rights reserved.
//
#import "UserModel.h"
#import <Foundation/Foundation.h>
@interface GlobalVar : NSObject
+(GlobalVar*)share;
@property(nonatomic,strong)UserModel *user;
@property(nonatomic,strong)NSString *dueDate;
-(BOOL)isIncludeSpecialCharact: (NSString *)str;
-(BOOL)isConnectionAvailable;
-(BOOL)isKindeOfRole:(NSString *)role;
@end
