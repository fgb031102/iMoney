//
//  JMDataArrayModel.m
//  iTravel
//
//  Created by Yongfei He on 14-5-20.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import "MQDataArrayModel.h"

@implementation MQDataArrayModel

-(id)init{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.lastNum = 0;
    }
    
    return self;
}

-(void)clearData{
    self.lastNum = 0;
    self.lastLoadCount = 0;
    [self.dataArray removeAllObjects];
}

@end
