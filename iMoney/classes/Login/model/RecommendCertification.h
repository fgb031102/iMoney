//
//  RecommendCertification.h
//  IQPlatform
//
//  Created by heyunfei on 15-1-1.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RecommendCertification : NSManagedObject

@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * nameInfo;
@property (nonatomic, retain) NSString * schoolInfo;
@property (nonatomic, retain) NSString * workInfo;
@property (nonatomic, retain) NSString * otherInfo;

@end
