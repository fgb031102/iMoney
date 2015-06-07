//
//  UserData.h
//  iPregnant
//
//  Created by heyunfei on 14-7-13.
//  Copyright (c) 2014年 iPregnant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *child_birth_date;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *device_token;
@property(nonatomic,strong)NSString *device_type;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *header_picture_url;
@property(nonatomic,strong)NSString *last_login_time;
@property(nonatomic,strong)NSString *login_token;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *register_type;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_score;
@property(nonatomic,strong)NSString *push_user_id;
@property(nonatomic,strong)NSString *push_channel_id;
@property(nonatomic,strong)NSString *loadType;
@property(nonatomic,strong)NSString *dueDate;
@property(nonatomic,strong)NSString *menstruationDate;
@property(nonatomic,strong)NSString *menstruationCycle;

@end
