//
//  const constants
//
//
//  Created by heyf on 3/22/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#ifndef constants_h
#define constants_h

typedef enum USER_TYPE{
    TRAVEL_AGENCY = 1,
    PROFESSIONAL_GUIDE,
    NO_PROFESSIONAL_GUIDE,
    TOURIST
}USER_TYPE;

typedef enum EVENT_STATUS{
    EVENT_STATUS_PENDING = 1,
    EVENT_STATUS_LOCK,
    EVENT_STATUS_CONFIRM,
    EVENT_STATUS_DELETE
}EVENT_STATUS;

typedef enum SERVICE_TYPE{
    SERVICE_TYPE_GUIDE = 1,
    SERVICE_TYPE_ROUTE,
    SERVICE_TYPE_STRATEGY,
    SERVICE_TYPE_COMPANY,
    SERVICE_TYPE_CAR,
    SERVICE_TYPE_VISA,
    SERVICE_TYPE_TICKET,
    SERVICE_TYPE_RESTAURANT,
    SERVICE_TYPE_HOTEL,
    SERVICE_TYPE_CLUB
}SERVICE_TYPE;

typedef enum CAR_TYPE{
    CAR_TYPE_BUSINESS = 1,
    CAR_TYPE_PERSONAL,
    CAR_TYPE_PLANE,
    CAR_TYPE_TAXI,
    CAR_TYPE_BUS_COMPANY,
    CAR_TYPE_CARPOOL,
    CAR_TYPE_SHORT_ROUTE,
    CAR_TYPE_FREE
}CAR_TYPE;

typedef enum FAV_TYPE{
    FAV_TYPE_EVENT,
    FAV_TYPE_SERVICE
}FAV_TYPE;

#define FRIEND_QR_LINK @"http://115.28.221.96/itravel/index.php?/scan/add_friend/"
#define GROUP_QR_LINK @"http://115.28.221.96/itravel/index.php?/scan/add_group/"

#define JM_PROTOCOL_VERSION @"1.0"
#define CUR_APP_VERSION 1

#define IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)

#define IOS6_7_DELTA(V,X,Y,W,H) if(IOS_7) {CGRect f = V.frame;f.origin.x += X;f.origin.y += Y;f.size.width +=W;f.size.height += H;V.frame=f;}

#define IOS6_7_20(V) IOS6_7_DELTA(V,0,20,0,-20)


typedef void (^dataParseCallBackBlock)(NSInteger);
typedef void (^dataParseDataCallBackBlock)(id, NSInteger);

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

#define IO7_TOP_BAR_HEIGHT          120
#define IO7_NO_TAB_TOP_BAR_HEIGHT   63

#define COMMAND_TYPE_SYSTEM     @"system"
#define COMMAND_TYPE_TRADE      @"trade"
#define COMMAND_TYPE_CHAT       @"chat"

#define COMMAND_NAME_ADD_NEW_FRIEND         @"add_new_friend"
#define COMMAND_NAME_ADD_NEW_FRIEND_ACK     @"add_new_friend_ack"
#define COMMAND_NAME_UPDATE_FRIEND_LIST     @"update_friend_list"
#define COMMAND_NAME_JOIN_GROUP             @"join_group"
#define COMMAND_NAME_JOIN_GROUP_ACK         @"join_group_ack"
#define COMMAND_NAME_UPDATE_GROUP_LIST      @"update_group_list"
#define COMMAND_NAME_UPDATE_EVENT_INFO      @"update_event_info"


#define DEFINE_APP_VAR AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

#define LOCALIZE_STRING(keyName) [SystemConfig getLocalValueByKey:keyName]

#define APP_STORE_URL   @"https://itunes.apple.com/us/app/nei-han-bo-duan-zi/id688268553?ls=1&mt=8"

#endif
