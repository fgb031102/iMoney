//
//  SqliteManager.m
//  EBook
//
//  Created by heyongfei on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SqliteManager.h"

static SqliteManager * _manager = nil;

@implementation SqliteManager

-(id) init {
    self = [super init];
    if (self) {
        NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *databaseFileDir=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"db/"];
        if(![[NSFileManager defaultManager] fileExistsAtPath:databaseFileDir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:databaseFileDir withIntermediateDirectories:YES attributes:nil error:NULL];
        }

        NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"db/itravel_inner.db"];
        if (sqlite3_open([databaseFilePath UTF8String], &database) == SQLITE_OK) {
               [self createTable];
        }
        else { 
            NSLog( @"can not open sqlite db " );
            sqlite3_close(database);
        }
    }
    return self;
}

-(void) dealloc {
    sqlite3_close(database);
}

//create table   
- (void)createTable {   
    char *errorMsg;   
    const char *createSql="create table if not exists system_config (key text,value text)";   
    if (sqlite3_exec(database, createSql, NULL, NULL, &errorMsg)==SQLITE_OK)
        NSLog(@"create ok.");
    else 
        NSLog( @"can not create table: %@", [NSString stringWithCString:createSql encoding:NSUTF8StringEncoding]);

    //chat history
    const char *createChatHistorySql = "create table if not exists chat_history (msg_id text, question_id text,dst_user_id int, create_time int, command_type text, command_name text, message_content text, group_id int, src_user_id int, content_data_type int)";
    if (sqlite3_exec(database, createChatHistorySql, NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"create ok.");
    else
        NSLog( @"can not create table: %@", [NSString stringWithCString:createChatHistorySql encoding:NSUTF8StringEncoding]);

    //chat list
    const char *createChatListSql = "create table if not exists chat_msg (msg_id text,question_id text, dst_user_id int, create_time int, command_type text, command_name text, message_content text, group_id int, src_user_id int, content_data_type int)";
    if (sqlite3_exec(database, createChatListSql, NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"create ok.");
    else
        NSLog( @"can not create table: %@", [NSString stringWithCString:createChatListSql encoding:NSUTF8StringEncoding]);
    
    //system notification list
    const char *createSystemNotificationListSql = "create table if not exists system_notification (msg_id text, dst_user_id int, create_time int, command_type text, command_name text, message_content text, group_id int, src_user_id int, content_data_type int, msg_status int)";
    if (sqlite3_exec(database, createSystemNotificationListSql, NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"create ok.");
    else
        NSLog( @"can not create table: %@", [NSString stringWithCString:createSystemNotificationListSql encoding:NSUTF8StringEncoding]);
    
    //trade notification list
    const char *createTradeNotificationListSql = "create table if not exists trade_notification (event_id int)";
    if (sqlite3_exec(database, createTradeNotificationListSql, NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"create ok.");
    else
        NSLog( @"can not create table: %@", [NSString stringWithCString:createTradeNotificationListSql encoding:NSUTF8StringEncoding]);

    //fav
    const char *createFavSql="create table if not exists my_fav (fav_id int, fav_type int, service_type int)";
    if (sqlite3_exec(database, createFavSql, NULL, NULL, &errorMsg)==SQLITE_OK)
        NSLog(@"create ok.");
    else
        NSLog( @"can not create table: %@", [NSString stringWithCString:createFavSql encoding:NSUTF8StringEncoding]);
    
    //chat_process_history
    const char *createChatProcessHistorySql = "create table if not exists chat_process_history (msg_id int)";
    if (sqlite3_exec(database, createChatProcessHistorySql, NULL, NULL, &errorMsg)==SQLITE_OK)
        NSLog(@"create ok.");
    else
        NSLog( @"can not create table: %@", [NSString stringWithCString:createChatProcessHistorySql encoding:NSUTF8StringEncoding]);
}

//update table
- (void)updateSystemTableWithKey:(NSString*)key Value:(NSString*)value {   
    char *errorMsg;   
    
    NSString *sql = [[NSString alloc] initWithFormat:@"insert into system_config(key, value) values('%@', '%@')", key, value];
    
    if ([self querySystemTableWithKey:key] != nil)
        sql = [[NSString alloc] initWithFormat:@"update system_config set value='%@' where key='%@'", value, key];
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) 
        NSLog(@"update ok.");
    else
        NSLog( @"can not update table: %@", sql);
} 

//query table   
- (NSString*)querySystemTableWithKey:(NSString*)key {   
    NSString *sql = [[NSString alloc] initWithFormat:@"select value from system_config where key='%@'", key];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){ 
        while (sqlite3_step(statement) == SQLITE_ROW){
            char* value = (char *)sqlite3_column_text(statement, 0);
            NSString *result = [[NSString alloc] initWithCString:value encoding:NSUTF8StringEncoding];
            sqlite3_finalize(statement);
            return result;
        }
    }
    
    sqlite3_finalize(statement);
    return nil;
}

//-(void)inner_add_table:(NSString*)table_name withModel:(MessageModel*)item{
//    char *errorMsg;
//    NSString *sql = [[NSString alloc] initWithFormat:@"insert into %@(msg_id, question_id,dst_user_id, create_time, command_type, command_name, message_content, group_id, src_user_id, content_data_type) values('%@','%@', %ld, %ld, '%@', '%@', '%@', %ld, %ld, %ld)", table_name, item.msg_id, item.questionID, (long)item.dst_user_id, time(NULL), item.command_type, item.command_name, item.message_content, (long)item.group_id, (long)item.src_user_id, (long)item.content_data_type];
//    
//    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK)
//        NSLog(@"insert db ok.");
//    else
//        NSLog( @"can not inert db table: %@", sql);
//}

//-(void)inner_update_table:(NSString*)table_name withModel:(MessageModel*)item{
//    char *errorMsg;
//    NSString *sql = [[NSString alloc] initWithFormat:@"update %@ set create_time=%ld, command_type='%@', command_name='%@', message_content='%@', src_user_id=%ld, content_data_type=%ld where dst_user_id=%ld and group_id=%ld", table_name, time(NULL), item.command_type, item.command_name, item.message_content, (long)item.src_user_id, (long)item.content_data_type, (long)item.dst_user_id, (long)item.group_id];
//    
//    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK)
//        NSLog(@"update ok.");
//    else
//        NSLog( @"can not update table: %@", sql);
//}

//- (NSMutableArray*)inner_query_table:(NSString*)table_name withQuestionId:(NSString *)question_id descOrder:(BOOL)descOrder{
//    NSString *sql;
//    if (!([question_id isEqualToString:@""])) {
//        sql = [[NSString alloc] initWithFormat:@"select * from %@ where question_id=%@ order by create_time %@", table_name, question_id , descOrder ? @"desc":@""];
//    }else{
//        sql = [[NSString alloc] initWithFormat:@"select * from %@ order by create_time %@", table_name, descOrder ? @"desc":@""];
//    }
//    
//    sqlite3_stmt *statement;
//    NSMutableArray *resultDataSet = [[NSMutableArray alloc] init];
//    int i = 0;
//    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
//        while (sqlite3_step(statement) == SQLITE_ROW){
//            i++;
//            MessageModel *item = [[MessageModel alloc] init];
//            
//            char *value = (char *)sqlite3_column_text(statement, 0);
//            item.msg_id = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            value = (char *)sqlite3_column_text(statement, 1);
//            item.questionID = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            int nValue = sqlite3_column_int(statement, 2);
//            item.dst_user_id = nValue;
//            nValue = sqlite3_column_int(statement, 3);
//            item.create_time = [[NSDate alloc] initWithTimeIntervalSince1970:nValue];
//            value = (char *)sqlite3_column_text(statement, 4);
//            item.command_type = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            value = (char *)sqlite3_column_text(statement, 5);
//            item.command_name = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            value = (char *)sqlite3_column_text(statement, 6);
//            item.message_content = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            nValue = sqlite3_column_int(statement, 7);
//            item.group_id = nValue;
//            nValue = sqlite3_column_int(statement, 8);
//            item.src_user_id = nValue;
//            nValue = sqlite3_column_int(statement, 9);
//            item.content_data_type = nValue;
//            
//            [resultDataSet addObject:item];
//        }
//        
//        sqlite3_finalize(statement);
//        return resultDataSet;
//    }
//    
//    sqlite3_finalize(statement);
//    return nil;
//}

- (BOOL) inner_delete_table:(NSString*)table_name withDstUserId:(NSInteger)dst_user_id GroupId:(NSInteger)group_id{
    char *errorMsg;
    
    NSString *sql = [[NSString alloc] initWithFormat:@"delete from %@ where dst_user_id=%ld and group_id=%ld", table_name, (long)dst_user_id, (long)group_id];
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"delete ok.");
        return TRUE;
    }
    else{
        NSLog( @"can not delete table: %@", sql);
        return FALSE;
    }
}

//- (void) addChatHistoryTable:(MessageModel*)item{
//    [self inner_add_table:@"chat_history" withModel:item];
//    
//    //update chat list
//    [self addChatListTable:item];
//}

//- (BOOL) deleteChatHistoryTable:(MessageModel*)item{
//    return [self inner_delete_table:@"chat_history" withDstUserId:item.dst_user_id GroupId:item.group_id];
//}

//- (NSMutableArray*)queryChatHistoryTableWithID:(NSString *)question_ID{
//    return [self inner_query_table:@"chat_history" withQuestionId:question_ID descOrder:NO];
//}

//- (void) addChatListTable:(MessageModel*)item{
//    if ([self queryChatListTableWithID:item.questionID].count != 0)
//        [self inner_update_table:@"chat_msg" withModel:item];
//    else
//        [self inner_add_table:@"chat_msg" withModel:item];
//}

//- (BOOL) deleteChatListTable:(MessageModel*)item{
//    return [self inner_delete_table:@"chat_msg" withDstUserId:item.dst_user_id GroupId:item.group_id];
//}

//- (NSMutableArray*)queryChatListTableWithID:(NSString *)question_ID {
//    return [self inner_query_table:@"chat_msg" withQuestionId:question_ID descOrder:YES];
//}

//- (void) addSystemNotificationTable:(MessageModel*)item{
//    char *errorMsg;
//    NSString *sql = [[NSString alloc] initWithFormat:@"insert into system_notification(msg_id, dst_user_id, create_time, command_type, command_name, message_content, group_id, src_user_id, content_data_type, msg_status) values('%@', %ld, %ld, '%@', '%@', '%@', %ld, %ld, %ld, %d)", item.msg_id, (long)item.dst_user_id, time(NULL), item.command_type, item.command_name, item.message_content, (long)item.group_id, (long)item.src_user_id, (long)item.content_data_type, item.msg_status];
//    
//    if ([self querySystemNotificationTableWithID:item.msg_id].count != 0) {
//        sql = [[NSString alloc] initWithFormat:@"update system_notification set dst_user_id=%ld, group_id=%ld, create_time=%ld, command_type='%@', command_name='%@', message_content='%@', src_user_id=%ld, content_data_type=%ld, msg_status=%d where msg_id='%@'", (long)item.dst_user_id, (long)item.group_id, time(NULL), item.command_type, item.command_name, item.message_content, (long)item.src_user_id, (long)item.content_data_type, item.msg_status, item.msg_id];
//    }
//    
//    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK)
//        NSLog(@"insert db ok.");
//    else
//        NSLog( @"can not inert db table: %@", sql);
//
//}

//- (BOOL) deleteSystemNotificationTable:(MessageModel*)item{
//    char *errorMsg;
//    
//    NSString *sql = [[NSString alloc] initWithFormat:@"delete from system_notification where msg_id='%@'", item.msg_id];
//    
//    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
//        NSLog(@"delete ok.");
//        return TRUE;
//    }
//    else{
//        NSLog( @"can not delete table: %@", sql);
//        return FALSE;
//    }
//}

//- (NSMutableArray*)querySystemNotificationTableWithID:(NSString*)msg_id{
//    NSString *sql;
//    if (![msg_id isEqualToString:@""]) {
//        sql = [[NSString alloc] initWithFormat:@"select * from system_notification where msg_id='%@'", msg_id];
//    }else{
//        sql = [[NSString alloc] initWithFormat:@"select * from system_notification order by create_time desc"];
//    }
//    
//    sqlite3_stmt *statement;
//    NSMutableArray *resultDataSet = [[NSMutableArray alloc] init];
//    int i = 0;
//    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
//        while (sqlite3_step(statement) == SQLITE_ROW){
//            i++;
//            MessageModel *item = [[MessageModel alloc] init];
//            
//            char *value = (char *)sqlite3_column_text(statement, 0);
//            item.msg_id = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            int nValue = sqlite3_column_int(statement, 1);
//            item.dst_user_id = nValue;
//            nValue = sqlite3_column_int(statement, 2);
//            item.create_time = [[NSDate alloc] initWithTimeIntervalSince1970:nValue];
//            value = (char *)sqlite3_column_text(statement, 3);
//            item.command_type = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            value = (char *)sqlite3_column_text(statement, 4);
//            item.command_name = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            value = (char *)sqlite3_column_text(statement, 5);
//            item.message_content = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
//            nValue = sqlite3_column_int(statement, 6);
//            item.group_id = nValue;
//            nValue = sqlite3_column_int(statement, 7);
//            item.src_user_id = nValue;
//            nValue = sqlite3_column_int(statement, 8);
//            item.content_data_type = nValue;
//            nValue = sqlite3_column_int(statement, 9);
//            item.msg_status = nValue;
//            
//            [resultDataSet addObject:item];
//        }
//        
//        sqlite3_finalize(statement);
//        return resultDataSet;
//    }
//    
//    sqlite3_finalize(statement);
//    return nil;
//}

- (void) addTradeNotificationTable:(NSInteger)event_id{
    char *errorMsg;
    NSString *sql = [[NSString alloc] initWithFormat:@"insert into trade_notification(event_id) values(%ld)", (long)event_id];
    
    if ([self queryTradeNotificationTableWithID:event_id].count != 0) {
        return;
    }
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"insert db ok.");
    else
        NSLog( @"can not inert db table: %@", sql);
}

- (BOOL) deleteTradeNotificationTable:(NSInteger)event_id{
    char *errorMsg;
    
    NSString *sql = [[NSString alloc] initWithFormat:@"delete from trade_notification where event_id=%ld", (long)event_id];
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"delete ok.");
        return TRUE;
    }
    else{
        NSLog( @"can not delete table: %@", sql);
        return FALSE;
    }
}

- (NSMutableArray*)queryTradeNotificationTableWithID:(NSInteger)event_id{
    NSString *sql;
    if (event_id != -1) {
        sql = [[NSString alloc] initWithFormat:@"select * from trade_notification where event_id=%ld", (long)event_id];
    }else{
        sql = [[NSString alloc] initWithFormat:@"select * from trade_notification "];
    }
    
    sqlite3_stmt *statement;
    NSMutableArray *resultDataSet = [[NSMutableArray alloc] init];
    int i = 0;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW){
            i++;
            int nValue = sqlite3_column_int(statement, 0);
            [resultDataSet addObject:[NSString stringWithFormat:@"%ld", (long)nValue]];
        }
        
        sqlite3_finalize(statement);
        return resultDataSet;
    }
    
    sqlite3_finalize(statement);
    return nil;
}


- (void) addFav:(NSInteger)fav_id FavType:(FAV_TYPE)fav_type ServiceType:(SERVICE_TYPE)service_type{
    char *errorMsg;
    NSString *sql = [[NSString alloc] initWithFormat:@"insert into my_fav(fav_id, fav_type, service_type) values(%ld, %d, %d)", (long)fav_id, fav_type, service_type];
    
    //exist
    if ([self queryFav:fav_id FavType:fav_type].count != 0) {
        return;
    }
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"insert db ok.");
    else
        NSLog( @"can not inert db table: %@", sql);
}

- (void) deleteFav:(NSInteger)fav_id FavType:(FAV_TYPE)fav_type{
    char *errorMsg;
    
    NSString *sql = [[NSString alloc] initWithFormat:@"delete from my_fav where fav_id=%ld and fav_type=%d", (long)fav_id, fav_type];
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"delete ok.");
    }
    else{
        NSLog( @"can not delete table: %@", sql);
    }
}

//- (NSMutableArray*)queryFav:(NSInteger)fav_id FavType:(FAV_TYPE)fav_type{
//    NSString *sql;
//    if (fav_id != -1) {
//        sql = [[NSString alloc] initWithFormat:@"select * from my_fav where fav_id=%ld and fav_type=%d", (long)fav_id, fav_type];
//    }else{
//        sql = [[NSString alloc] initWithFormat:@"select * from my_fav where fav_type=%d", fav_type];
//    }
//    
//    sqlite3_stmt *statement;
//    NSMutableArray *resultDataSet = [[NSMutableArray alloc] init];
//    int i = 0;
//    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
//        while (sqlite3_step(statement) == SQLITE_ROW){
//            i++;
//            
//            MyFavModel *model = [[MyFavModel alloc] init];
//            int nValue = sqlite3_column_int(statement, 0);
//            model.fav_id = nValue;
//            nValue = sqlite3_column_int(statement, 1);
//            model.fav_type = nValue;
//            nValue = sqlite3_column_int(statement, 2);
//            model.service_type = nValue;
//            
//            [resultDataSet addObject:model];
//        }
//        
//        sqlite3_finalize(statement);
//        return i == 0 ? nil : resultDataSet;
//    }
//    
//    sqlite3_finalize(statement);
//    return nil;
//}

//chat process history
- (void) addChatProcessHistory:(NSString*)msg_id{
    char *errorMsg;
    NSString *sql = [[NSString alloc] initWithFormat:@"insert into chat_process_history(msg_id) values('%@')", msg_id];
    
    //exist
    if ([self queryChatProcessHistory:msg_id].count != 0) {
        return;
    }
    
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK)
        NSLog(@"insert db ok.");
    else
        NSLog( @"can not inert db table: %@", sql);
}

- (NSMutableDictionary*)queryChatProcessHistory:(NSString*)msg_id{
    NSString *sql;
    if (![msg_id isEqualToString:@""]) {
        sql = [[NSString alloc] initWithFormat:@"select * from chat_process_history where msg_id='%@' limit 500", msg_id];
    }else{
        sql = [[NSString alloc] initWithFormat:@"select * from chat_process_history limit 500"];
    }
    
    sqlite3_stmt *statement;
    NSMutableDictionary *resultDataSet = [[NSMutableDictionary alloc] init];
    int i = 0;
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW){
            i++;
            
            char *value = (char *)sqlite3_column_text(statement, 0);
            NSString *msg_id = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
            [resultDataSet setObject:msg_id forKey:msg_id];
        }
        
        sqlite3_finalize(statement);
        return i == 0 ? nil : resultDataSet;
    }
    
    sqlite3_finalize(statement);
    return nil;
}


+(SqliteManager*) shareManager {
    if (_manager == nil) {
        _manager = [[SqliteManager alloc] init];
    }
    
    return _manager;
}
 
@end
