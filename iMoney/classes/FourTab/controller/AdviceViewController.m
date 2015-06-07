//
//  AdviceViewController.m
//  IQPlatform
//
//  Created by heyunfei on 15-1-7.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()
{
    UITextView *content;
    BOOL clear;
}
@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super leftBar];
    self.title=@"意见反馈";
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent)];
    self.view.userInteractionEnabled=YES;
    [self.view addGestureRecognizer:TapGesture];
    self.view.backgroundColor= [UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:236.0f/255.0f alpha:1.0];
    [self barRight:@"发送"];
    
    content=[[UITextView alloc]initWithFrame:CGRectMake(11, 15, 300, 160)];
    content.text=@"欢迎提出您的宝贵意见,并留下联系方式";
    content.textColor=[UIColor grayColor];
    content.delegate=self;
    [self.view addSubview:content];
}
#pragma textView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (!clear) {
        textView.text=@"";
        clear=YES;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [content resignFirstResponder];
    return true;
}
-(void)handleSingleFingerEvent{
    [content resignFirstResponder];
}
-(void)rightAction{
    if(content.text.length==0 || [content.text isEqualToString:@"欢迎提出您的宝贵意见,并留下联系方式"])
    {
        [SVStatusHUD showWithStatus:@"输入不能为空"];
        return;
    }
    NSMutableDictionary *param =[[NSMutableDictionary alloc]initWithCapacity:10];
    //[param setObject: [GlobalVar share].user.login_token forKey:@"login_token"];
    [param setObject: content.text forKey:@"content"];
    myController *controller=[[myController alloc]init];
    [controller feedBackAdvice:param dataCallback:^(NSInteger statusCode) {
        if(statusCode != -1){
            [SVStatusHUD showWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [SVStatusHUD showWithStatus:@"提交失败"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
