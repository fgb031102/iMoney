//
//  UserData.m
//  iPregnant
//
//  Created by heyunfei on 14-7-13.
//  Copyright (c) 2014年 iPregnant. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize address,child_birth_date,create_time,device_token,device_type,email,header_picture_url,last_login_time,login_token,mobile,password,register_type,userid,user_name,user_score,push_channel_id,push_user_id,loadType,dueDate,menstruationCycle,menstruationDate;


- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.address forKey:@"address"];
    [coder encodeObject:self.child_birth_date forKey:@"child_birth_date"];
    [coder encodeObject:self.create_time forKey:@"create_time"];
    [coder encodeObject:self.device_token forKey:@"device_token"];
    [coder encodeObject:self.device_type forKey:@"device_type"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.header_picture_url forKey:@"header_picture_url"];
    [coder encodeObject:self.last_login_time forKey:@"last_login_time"];
    [coder encodeObject:self.login_token forKey:@"login_token"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.password forKey:@"password"];
    [coder encodeObject:self.register_type forKey:@"register_type"];
    [coder encodeObject:self.userid forKey:@"userid"];
    [coder encodeObject:self.user_name forKey:@"user_name"];
    [coder encodeObject:self.user_score forKey:@"user_score"];
    [coder encodeObject:self.push_channel_id forKey:@"push_channel_id"];
    [coder encodeObject:self.push_user_id forKey:@"push_user_id"];
    [coder encodeObject:self.loadType forKey:@"loadType"];
    [coder encodeObject:self.dueDate forKey:@"dueDate"];

    [coder encodeObject:self.menstruationDate forKey:@"menstruationDate"];

    [coder encodeObject:self.menstruationCycle forKey:@"menstruationCycle"];

}

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        self.address = [decoder decodeObjectForKey:@"address"];
        self.child_birth_date = [decoder decodeObjectForKey:@"child_birth_date"];
        self.create_time = [decoder decodeObjectForKey:@"create_time"];
        self.device_token = [decoder decodeObjectForKey:@"device_token"];
        self.device_type = [decoder decodeObjectForKey:@"device_type"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.header_picture_url = [decoder decodeObjectForKey:@"header_picture_url"];
        self.last_login_time = [decoder decodeObjectForKey:@"last_login_time"];
        self.login_token = [decoder decodeObjectForKey:@"login_token"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.register_type = [decoder decodeObjectForKey:@"register_type"];
        self.userid = [decoder decodeObjectForKey:@"userid"];
        self.user_name = [decoder decodeObjectForKey:@"user_name"];
        self.user_score = [decoder decodeObjectForKey:@"user_score"];
        self.push_channel_id = [decoder decodeObjectForKey:@"push_channel_id"];
        self.push_user_id = [decoder decodeObjectForKey:@"push_user_id"];
        self.loadType = [decoder decodeObjectForKey:@"loadType"];
        
        self.dueDate = [decoder decodeObjectForKey:@"dueDate"];
        self.menstruationDate = [decoder decodeObjectForKey:@"menstruationDate"];
        self.menstruationCycle = [decoder decodeObjectForKey:@"menstruationCycle"];
    }
    return self;
}

@end
