//
//  FirendMessageViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-3.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseMessageModel.h"

@interface FirendMessageViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    BaseMessageModel *firendMessageData;
}

@property (strong, nonatomic) UITableView *itemsTableView;

@end
