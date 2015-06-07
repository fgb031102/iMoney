//
//  MQDataArrayModel.h
//  iTravel
//
//  Created by Yongfei He on 14-5-20.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQDataArrayModel : NSObject

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSInteger lastNum;
@property (nonatomic) NSInteger lastLoadCount;

-(void)clearData;

@end
