//
//  BaseViewController.m
//  iPregnant
//
//  Created by heyunfei on 14-8-11.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIButton *_backBtn;
}
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - IO7_TOP_BAR_HEIGHT);
    [PublicUtility setupNavgatorbar:self];
}
-(void)leftBar{
    UIImage* imgBackBtn = [UIImage imageNamed:@"public_ico_leftarrow.png"];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 30, 30);
    [_backBtn setImage:imgBackBtn forState:UIControlStateNormal];
    [_backBtn addTarget: self action: @selector(BackBtn) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_backBtn];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
-(void)BackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showBackBtn:(BOOL)hide{
    if(hide){
        _backBtn.hidden=YES;
    }
    else{
         _backBtn.hidden=NO;
    }
}
-(BOOL)judgeLogin{
    if (![GlobalVar share].user) {
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [app.tabBarCtrl hidesTabBar:YES animated:NO];
        //[self.navigationController pushViewController:login animated:YES];
        return YES;
    }
    else
        return NO;
}
-(void)barRight:(NSString*)title{
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeCustom];
    [edit addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:edit];
    edit.frame = CGRectMake(0, 0, 32, 22);
    [edit setTitle:title forState:UIControlStateNormal];
    [edit.titleLabel setTintColor:[UIColor whiteColor]];
    [edit.titleLabel setFont:[UIFont systemFontOfSize:16]];
    edit.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.navigationItem.rightBarButtonItem = backButtonItem;
}
-(void)rightAction{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 旋转支持接口方向回调(6.0)
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark - 是否可以旋转回调(6.0)
- (BOOL)shouldAutorotate
{
    return NO;
}
#pragma mark - 旋转支持接口方向回调(6.0以下)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
        return YES;
    return NO;
}

@end
