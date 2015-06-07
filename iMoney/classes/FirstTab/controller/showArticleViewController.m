//
//  showArticleViewController.m
//  IQPlatform
//
//  Created by hulin on 15-1-2.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "showArticleViewController.h"

@interface showArticleViewController ()

@end

@implementation showArticleViewController


-(id)initWithArticle:(ArticleModel *)article
{
    self = [super init];
    if (self) {
        anArticle = [[ArticleModel alloc]init];
        anArticle = article;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
