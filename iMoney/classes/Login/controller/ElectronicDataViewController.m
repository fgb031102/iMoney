//
//  ElectronicDataViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-29.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "ElectronicDataViewController.h"

@interface ElectronicDataViewController ()
{
    UIScrollView *scrollView;
}
@end

@implementation ElectronicDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"填写认证信息";
    [super barRight:@"完成"];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 60)];
    desc.text = @"请上传真实的资料。";
    desc.numberOfLines=3;
    desc.textAlignment=NSTextAlignmentLeft;
    desc.backgroundColor = [UIColor clearColor];
    desc.textColor = [UIColor grayColor];
    desc.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:desc];
}
-(void)rightAction{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
