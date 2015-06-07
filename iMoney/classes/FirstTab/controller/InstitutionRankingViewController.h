//
//  InstitutionRankingViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-1.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstitutionModel.h"

@interface InstitutionRankingViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    InstitutionModel *institutionData;
}

@property (strong, nonatomic) UITableView *itemsTableView;

@end
