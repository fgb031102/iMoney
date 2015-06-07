//
//  SqliteManager.h
//  EBook
//
//  Created by heyongfei on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "constants.h"

@interface SqliteManager : NSObject {
    sqlite3 *database;
}

- (void) updateSystemTableWithKey:(NSString*)key Value:(NSString*)value;
- (NSString*)querySystemTableWithKey:(NSString*)key;

//chat history
//- (void) addChatHistoryTable:(MessageModel*)item;
//- (BOOL) deleteChatHistoryTable:(MessageModel*)item;
- (NSMutableArray*)queryChatHistoryTableWithID:(NSString *)question_ID;

//chat list
//- (void) addChatListTable:(MessageModel*)item;
//- (BOOL) deleteChatListTable:(MessageModel*)item;
- (NSMutableArray*)queryChatListTableWithID:(NSString *)question_ID;

//system notification history
//- (void) addSystemNotificationTable:(MessageModel*)item;
//- (BOOL) deleteSystemNotificationTable:(MessageModel*)item;
- (NSMutableArray*)querySystemNotificationTableWithID:(NSString*)msg_id;

//trade notification history
- (void) addTradeNotificationTable:(NSInteger)event_id;
- (BOOL) deleteTradeNotificationTable:(NSInteger)event_id;
- (NSMutableArray*)queryTradeNotificationTableWithID:(NSInteger)event_id;

//favorite
- (void) addFav:(NSInteger)fav_id FavType:(FAV_TYPE)fav_type ServiceType:(SERVICE_TYPE)service_type;
- (void) deleteFav:(NSInteger)fav_id FavType:(FAV_TYPE)fav_type;
- (NSMutableArray*)queryFav:(NSInteger)fav_id FavType:(FAV_TYPE)fav_type ;

//chat process history
- (void) addChatProcessHistory:(NSString*)msg_id;
- (NSMutableDictionary*)queryChatProcessHistory:(NSString*)msg_id;

+(SqliteManager*) shareManager;

@end
