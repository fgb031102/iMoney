//
//  ArticleRankingViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-1.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface ArticleRankingViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    
    ArticleModel *articleData;
}

@property (strong, nonatomic) UITableView *itemsTableView;


@end
