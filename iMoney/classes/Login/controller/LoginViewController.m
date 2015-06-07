//
//  LoginViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    UIScrollView *scrollView;
    UITextField *regMobile;
    UITextField *pwd;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEvent)];
    self.view.userInteractionEnabled=YES;
    [self.view addGestureRecognizer:TapGesture];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    //手机号
    regMobile = [[UITextField alloc]initWithFrame:CGRectMake(40, 40,240, 40)];
    regMobile.backgroundColor=[UIColor groupTableViewBackgroundColor];
    regMobile.placeholder = @"手机号码";
    regMobile.keyboardType = UIKeyboardTypeNumberPad;
    regMobile.delegate = self;
    regMobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:regMobile];
    
    //密码
    pwd = [[UITextField alloc]initWithFrame:CGRectMake(40, regMobile.frame.origin.y+regMobile.frame.size.height+220,240, 40)];
    pwd.backgroundColor=[UIColor groupTableViewBackgroundColor];
    pwd.placeholder = @"密码";
    pwd.delegate = self;
    pwd.secureTextEntry=YES;
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:pwd];
    
    // 提交按钮
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(40,pwd.frame.origin.y+pwd
                              .frame.size.height+40, 240, 40);
    [submit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [submit setTitle:@"登录" forState:UIControlStateNormal];
    [submit setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submit];
    
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.frame = CGRectMake(200, submit.frame.origin.y+submit.frame.size.height+5, 80, 30);
    [getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [getCodeBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getPWDAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getCodeBtn];
    
}
-(void)getPWDAction{
    FindPasswordViewController *find=[[FindPasswordViewController alloc]init];
    [self.navigationController pushViewController:find animated:NO];
}
-(void)submitAction{
    NSMutableDictionary *param =[[NSMutableDictionary alloc]initWithCapacity:10];
    [param setObject: regMobile.text forKey:@"mobile"];
    [param setObject: pwd.text forKey:@"password"];
    [param setObject: @"4" forKey:@"device_type"];
    LoginController *controller=[[LoginController alloc]init];
    [controller getLoginValidateFromServer:param dataCallback:^(NSInteger statusCode) {
        if(statusCode != -1){
            [SVStatusHUD showWithStatus:@"登录成功"];
        }
        else{
            //[SVStatusHUD showWithStatus:@"登录失败"];
        }
    }];
    
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app showMainUI];
}
-(void)handleEvent{
    [regMobile resignFirstResponder];
    [pwd resignFirstResponder];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //    if(textField == self.loginMobile){
    //        [self.mesgLab setHidden:YES];
    //    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //    if(textField == self.loginMobile){
    //        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kMobileNumReg];
    //        BOOL match = [phoneTest evaluateWithObject:self.loginMobile.text];
    //        if(!match){
    //            [self.mesgLab setHidden:NO];
    //        }
    //    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[self hiddenKeyboard];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
