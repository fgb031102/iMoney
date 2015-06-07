//
//  PersonRankingViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-1.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface PersonRankingViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    PersonModel *personData;
}

@property (strong, nonatomic) UITableView *itemsTableView;

@end
