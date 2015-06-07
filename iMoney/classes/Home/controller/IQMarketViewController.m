//
//  IQMarketViewController.m
//  市场
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "IQMarketViewController.h"
#import "HeaderViewTableViewCell.h"
#import "PersonRankingViewController.h"
#import "InstitutionRankingViewController.h"
#import "PersonTableViewCell.h"
#import "InstitutionTableViewCell.h"
//#import "showArticleViewController.h"

@interface IQMarketViewController ()

@end

@implementation IQMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"市场";
}

-(void) viewWillAppear:(BOOL)animated{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.tabBarCtrl hidesTabBar:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
