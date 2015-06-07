//
//  ModifyPasswordViewController.m
//  IQPlatform
//
//  Created by heyunfei on 15-1-7.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()
{
    UIScrollView *scrollView;
    UITextField *old;
    UITextField *pwd;
    UITextField *pwdReapt;
}
@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super leftBar];
    self.title=@"修改密码";
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEvent)];
    self.view.userInteractionEnabled=YES;
    [self.view addGestureRecognizer:TapGesture];
    
    //旧密码
    old = [[UITextField alloc]initWithFrame:CGRectMake(40, 40,240, 40)];
    old.backgroundColor=[UIColor groupTableViewBackgroundColor];
    old.placeholder = @"旧密码";
    old.secureTextEntry=YES;
    old.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:old];
    
    //密码
    pwd = [[UITextField alloc]initWithFrame:CGRectMake(40, old.frame.origin.y+old.frame.size.height+10,240, 40)];
    pwd.backgroundColor=[UIColor groupTableViewBackgroundColor];
    pwd.placeholder = @"新密码";
    pwd.secureTextEntry=YES;
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:pwd];
    
    //确认密码
    pwdReapt = [[UITextField alloc]initWithFrame:CGRectMake(40, pwd.frame.origin.y+pwd.frame.size.height+10,240, 40)];
    pwdReapt.backgroundColor=[UIColor groupTableViewBackgroundColor];
    pwdReapt.placeholder = @"确认密码";
    pwdReapt.secureTextEntry=YES;
    pwdReapt.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:pwdReapt];
    
    // 提交按钮
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(40,pwdReapt.frame.origin.x+pwdReapt
                              .frame.size.width+40, 240, 40);
    [submit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submit];
    
}
-(void)submitAction{
    NSMutableDictionary *param =[[NSMutableDictionary alloc]initWithCapacity:10];
    [param setObject: [GlobalVar share].user.login_token forKey:@"login_token"];
    [param setObject: old.text forKey:@"oldpassword"];
    [param setObject: pwd.text forKey:@"password"];
    LoginController *controller=[[LoginController alloc]init];
    [controller findPasswordFromServer:param dataCallback:^(NSInteger statusCode) {
        if(statusCode != -1){
            [SVStatusHUD showWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [SVStatusHUD showWithStatus:@"修改失败"];
        }
    }];
}
-(void)handleEvent{
    [pwd resignFirstResponder];
    [pwdReapt resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
