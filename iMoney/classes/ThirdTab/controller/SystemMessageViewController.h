//
//  SystemMessageViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-3.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"
#import "SystemMessageModel.h"

@interface SystemMessageViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    SystemMessageModel *systemMessageData;
}

@property (strong, nonatomic) UITableView *itemsTableView;

@end
