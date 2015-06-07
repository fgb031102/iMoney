//
//  ProductRankingViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-2.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductModel.h"

@interface ProductRankingViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    
    ProductModel *productData;
}

@property (strong, nonatomic) UITableView *itemsTableView;

@end
