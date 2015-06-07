//
//  IQMarketViewController.h
//  iPregnant
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
#import "InstitutionModel.h"
#import "BaseViewController.h"

@interface IQMarketViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
    PersonModel *personData;
    InstitutionModel *institutionData;
}

@property (strong, nonatomic) UITableView *itemsTableView;

@end
