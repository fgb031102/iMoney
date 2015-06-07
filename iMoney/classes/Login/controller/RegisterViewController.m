//
//  RegisterViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    UIScrollView *scrollView;
    UITextField *regMobile;
    UIButton *getCodeBtn;
    UITextField *checkCode;
    UITextField *pwd;
    UITextField *pwdReapt;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册";
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEvent)];
    self.view.userInteractionEnabled=YES;
    [self.view addGestureRecognizer:TapGesture];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    //手机号
    regMobile = [[UITextField alloc]initWithFrame:CGRectMake(40, 40,150, 40)];
    regMobile.backgroundColor=[UIColor groupTableViewBackgroundColor];
    regMobile.placeholder = @"手机号";
    regMobile.keyboardType = UIKeyboardTypeNumberPad;
    regMobile.delegate = self;
    regMobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:regMobile];
    
    
    // 获取验证码按钮
    getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.frame = CGRectMake(regMobile.frame.origin.x+regMobile
                                  .frame.size.width+10, 40, 80, 40);
    [getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getCodeBtn];
    
    //输入验证码
    checkCode = [[UITextField alloc]initWithFrame:CGRectMake(40, regMobile.frame.origin.y+regMobile.frame.size.height+20,240, 40)];
    checkCode.backgroundColor=[UIColor groupTableViewBackgroundColor];
    checkCode.placeholder = @"验证码";
    checkCode.delegate = self;
    checkCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:checkCode];
    
    //密码
    pwd = [[UITextField alloc]initWithFrame:CGRectMake(40, checkCode.frame.origin.y+checkCode.frame.size.height+20,240, 40)];
    pwd.backgroundColor=[UIColor groupTableViewBackgroundColor];
    pwd.placeholder = @"密码";
    pwd.delegate = self;
    pwd.secureTextEntry=YES;
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:pwd];
    
    //确认密码
    pwdReapt = [[UITextField alloc]initWithFrame:CGRectMake(40, pwd.frame.origin.y+pwd.frame.size.height+10,240, 40)];
    pwdReapt.backgroundColor=[UIColor groupTableViewBackgroundColor];
    pwdReapt.placeholder = @"确认密码";
    pwdReapt.delegate = self;
    pwdReapt.secureTextEntry=YES;
    pwdReapt.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:pwdReapt];
    
    // 提交按钮
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(40,pwdReapt.frame.origin.x+pwdReapt
                                  .frame.size.width+40, 240, 40);
    [submit.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [submit setTitle:@"下一步" forState:UIControlStateNormal];
    [submit setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submit];

}
-(void)getCodeAction{
    NSMutableDictionary *param =[[NSMutableDictionary alloc]initWithCapacity:10];
    [param setObject: regMobile.text forKey:@"mobile"];
    LoginController *controller=[[LoginController alloc]init];
    [controller getCheckCode:param dataCallback:^(NSInteger statusCode) {
        if(statusCode != -1){
            [SVStatusHUD showWithStatus:@"获取验证码成功"];
        }
        else{
            [SVStatusHUD showWithStatus:@"获取验证码失败"];
        }
    }];
}
-(void)submitAction{
    NSMutableDictionary *param =[[NSMutableDictionary alloc]initWithCapacity:10];
    [param setObject: regMobile.text forKey:@"mobile"];
    [param setObject: pwd.text forKey:@"password"];
    [param setObject: checkCode.text forKey:@"code"];
    [param setObject: @"4" forKey:@"device_type"];
    LoginController *controller=[[LoginController alloc]init];
    [controller getRegisterValidateFromServer:param dataCallback:^(NSInteger statusCode) {
        if(statusCode != -1){
            [SVStatusHUD showWithStatus:@"注册成功"];
            //CertificationTypeViewController *cer=[[CertificationTypeViewController alloc]init];
            //[self.navigationController pushViewController: cer animated: YES];
        }
        else{
            //[SVStatusHUD showWithStatus:@"注册失败"];
        }
    }];
    CertificationTypeViewController *cer=[[CertificationTypeViewController alloc]init];
    [self.navigationController pushViewController: cer animated: YES];
}
-(void)handleEvent{
    [regMobile resignFirstResponder];
    [checkCode resignFirstResponder];
    [pwd resignFirstResponder];
    [pwdReapt resignFirstResponder];
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
