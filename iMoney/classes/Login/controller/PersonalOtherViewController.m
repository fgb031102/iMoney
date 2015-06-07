//
//  PersonalOtherViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "PersonalOtherViewController.h"

@interface PersonalOtherViewController ()
{
    UIScrollView *scrollView;
    UITextField *titles;
    UITextField *specialty;
    UITextField *specialty2;
    UITextField *specialty3;
    UITextField *field;
    UITextField *field2;
    UITextField *field3;
    UITextView *other;
}
@end

@implementation PersonalOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"其他信息";
    [super barRight:@"保存"];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    titles=[[UITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 40)];
    titles.delegate=self;
    titles.placeholder=@"职称（二级选择）";
    titles.backgroundColor=[UIColor groupTableViewBackgroundColor];
    titles.clearButtonMode=UITextFieldViewModeWhileEditing;
    titles.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:titles];
    
    specialty=[[UITextField alloc]initWithFrame:CGRectMake(20, titles.frame.origin.y+titles.frame.size.height+20, 280, 40)];
    specialty.delegate=self;
    specialty.placeholder=@"专长地区";
    specialty.backgroundColor=[UIColor groupTableViewBackgroundColor];
    specialty.clearButtonMode=UITextFieldViewModeWhileEditing;
    specialty.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:specialty];
    
    specialty2=[[UITextField alloc]initWithFrame:CGRectMake(20, specialty.frame.origin.y+specialty.frame.size.height+20, 280, 40)];
    specialty2.delegate=self;
    specialty2.placeholder=@"专长地区2";
    specialty2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    specialty2.clearButtonMode=UITextFieldViewModeWhileEditing;
    specialty2.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:specialty2];
    
    specialty3=[[UITextField alloc]initWithFrame:CGRectMake(20, specialty2.frame.origin.y+specialty2.frame.size.height+20, 280, 40)];
    specialty3.delegate=self;
    specialty3.placeholder=@"专长地区3";
    specialty3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    specialty3.clearButtonMode=UITextFieldViewModeWhileEditing;
    specialty3.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:specialty3];
    
    field=[[UITextField alloc]initWithFrame:CGRectMake(20, specialty3.frame.origin.y+specialty3.frame.size.height+20, 280, 40)];
    field.delegate=self;
    field.placeholder=@"擅长领域";
    field.backgroundColor=[UIColor groupTableViewBackgroundColor];
    field.clearButtonMode=UITextFieldViewModeWhileEditing;
    field.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:field];
    
    field2=[[UITextField alloc]initWithFrame:CGRectMake(20, field.frame.origin.y+field.frame.size.height+20, 280, 40)];
    field2.delegate=self;
    field2.placeholder=@"擅长领域2";
    field2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    field2.clearButtonMode=UITextFieldViewModeWhileEditing;
    field2.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:field2];
    
    field3=[[UITextField alloc]initWithFrame:CGRectMake(20, field2.frame.origin.y+field2.frame.size.height+20, 280, 40)];
    field3.delegate=self;
    field3.placeholder=@"擅长领域3";
    field3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    field3.clearButtonMode=UITextFieldViewModeWhileEditing;
    field3.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:field3];
    
    other=[[UITextView alloc]initWithFrame:CGRectMake(20, field3.frame.origin.y+field3.frame.size.height+20, 280, 120)];
    other.text=@"输入或粘贴研究或工作成果，行业资质；或者其他补充信息(文字)";
    other.backgroundColor=[UIColor groupTableViewBackgroundColor];
    other.keyboardType=UIKeyboardTypeDefault;
    [scrollView addSubview:other];
    
    [scrollView setContentSize:CGSizeMake(0, other.frame.origin.y+other.frame.size.height+90)];
}
-(void)rightAction{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
