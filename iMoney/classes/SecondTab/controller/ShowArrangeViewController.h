//
//  ShowArrangeViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-3.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"
#import "ArrangeModel.h"

@interface ShowArrangeViewController : BaseViewController
{
    ArrangeModel *anArrange;
}

-(id)initWithArrange:(ArrangeModel *)arrange;

@end
