//
//  IQMessageViewController.h
//  iPregnant
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IQMessageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UIView *headerView;
    UIView *footerView;
}

@end
