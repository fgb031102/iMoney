//
//  RecommendPersonViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-29.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "RecommendPersonViewController.h"

@interface RecommendPersonViewController ()
{
    UIScrollView *scrollView;
    UITextField *name1;
    UITextField *mobile1;
    UITextField *name2;
    UITextField *mobile2;
    UITextField *name3;
    UITextField *mobile3;
}
@end

@implementation RecommendPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"填写推荐人";
    [super barRight:@"完成"];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 60)];
    desc.text = @"信息一般需要俩个举荐人核实认证，如果举荐不足，由平台邀请相关来快速核查。";
    desc.numberOfLines=3;
    desc.textAlignment=NSTextAlignmentLeft;
    desc.backgroundColor = [UIColor clearColor];
    desc.textColor = [UIColor grayColor];
    desc.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:desc];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(20,desc.frame.origin.y+desc
                                                                .frame.size.height+20, 60, 40)];
    title1.text = @"推荐人：";
    title1.numberOfLines=1;
    title1.textAlignment=NSTextAlignmentLeft;
    title1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title1.textColor = [UIColor blackColor];
    title1.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title1];
    
    //姓
    name1 = [[UITextField alloc]initWithFrame:CGRectMake(90,desc.frame.origin.y+desc
                                                         .frame.size.height+20, 200, 40)];
    name1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    name1.placeholder = @"推荐人姓名";
    name1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:name1];
    mobile1 = [[UITextField alloc]initWithFrame:CGRectMake(90,name1.frame.origin.y+name1
                                                         .frame.size.height+10, 200, 40)];
    mobile1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    mobile1.placeholder = @"推荐人手机";
    mobile1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:mobile1];
    
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(20,mobile1.frame.origin.y+mobile1
                                                                .frame.size.height+20, 60, 40)];
    title2.text = @"推荐人：";
    title2.numberOfLines=1;
    title2.textAlignment=NSTextAlignmentLeft;
    title2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title2.textColor = [UIColor blackColor];
    title2.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title2];
    
    //姓
    name2 = [[UITextField alloc]initWithFrame:CGRectMake(90,mobile1.frame.origin.y+mobile1
                                                         .frame.size.height+20, 200, 40)];
    name2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    name2.placeholder = @"推荐人姓名";
    name2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:name2];
    mobile2 = [[UITextField alloc]initWithFrame:CGRectMake(90,name2.frame.origin.y+name2
                                                           .frame.size.height+10, 200, 40)];
    mobile2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    mobile2.placeholder = @"推荐人手机";
    mobile2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:mobile2];
    
    
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(20,mobile2.frame.origin.y+mobile2
                                                                .frame.size.height+20, 60, 40)];
    title3.text = @"推荐人：";
    title3.numberOfLines=1;
    title3.textAlignment=NSTextAlignmentLeft;
    title3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title3.textColor = [UIColor blackColor];
    title3.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title3];
    
    //姓
    name3 = [[UITextField alloc]initWithFrame:CGRectMake(90,mobile2.frame.origin.y+mobile2
                                                         .frame.size.height+20, 200, 40)];
    name3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    name3.placeholder = @"推荐人姓名";
    name3.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:name3];
    mobile3 = [[UITextField alloc]initWithFrame:CGRectMake(90,name3.frame.origin.y+name3
                                                           .frame.size.height+10, 200, 40)];
    mobile3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    mobile3.placeholder = @"推荐人手机";
    mobile3.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:mobile3];
}

-(void)rightAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
