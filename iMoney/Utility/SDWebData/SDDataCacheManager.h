//
//  SDDataCache.h
//  SDWebData
//
//  Created by stm on 11-7-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDDataCacheManagerDelegate;
@interface SDDataCacheManager : NSObject 
{
    NSMutableDictionary *memCache;
    NSMutableArray      *memCacheKeyArray;
    unsigned long long  memCacheMaxSize;
    NSString *diskCachePath;
    NSOperationQueue *cacheInQueue, *cacheOutQueue;
}

+ (SDDataCacheManager *)sharedManager;
- (void)storeData:(NSData *)aData forKey:(NSString *)key;
- (void)storeData:(NSData *)aData forKey:(NSString *)key toDisk:(BOOL)toDisk;//存储data

- (NSData *)dataFromKey:(NSString *)key;
- (NSData *)dataFromKey:(NSString *)key fromDisk:(BOOL)fromDisk;//得到指定的data
- (void)queryDiskCacheForKey:(NSString *)key delegate:(id <SDDataCacheManagerDelegate>)delegate userInfo:(NSDictionary *)info;

- (void)removeDataForKey:(NSString *)key;//移除指点的元素
- (void)clearMemory;//清理内存
- (void)clearDisk;//清理所有的缓存
- (void)cleanDisk;//清理过期的缓存

@end


@protocol SDDataCacheManagerDelegate<NSObject>

@optional
- (void)dataCache:(SDDataCacheManager *)dataCache didFindData:(NSData *)aData forKey:(NSString *)key userInfo:(NSDictionary *)info;
- (void)dataCache:(SDDataCacheManager *)dataCache didNotFindDataForKey:(NSString *)key userInfo:(NSDictionary *)info;

@end
