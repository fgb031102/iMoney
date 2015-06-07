//
//  IQArticleViewController.m
//  文章
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "IQArticleViewController.h"
#import "HeaderViewTableViewCell.h"
#import "ArticleRankingViewController.h"
#import "PersonRankingViewController.h"
#import "InstitutionRankingViewController.h"
#import "ArticleTableViewCell.h"
#import "PersonTableViewCell.h"
#import "InstitutionTableViewCell.h"
#import "PublishArticleViewController.h"
#import "showArticleViewController.h"

@interface IQArticleViewController ()

@end

@implementation IQArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章";
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
