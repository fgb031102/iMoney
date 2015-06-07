//
//  CertificationTypeViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "CertificationTypeViewController.h"

@interface CertificationTypeViewController ()
{
    UIScrollView *scrollView;
}
@end

@implementation CertificationTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"认证方式";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 60)];
    desc.text = @"如果用户不经过认证，则无法进行发布、点评等功能操作。";
    desc.numberOfLines=3;
    desc.textAlignment=NSTextAlignmentCenter;
    desc.backgroundColor = [UIColor clearColor];
    desc.textColor = [UIColor grayColor];
    desc.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:desc];
    
    UIButton *type1 = [UIButton buttonWithType:UIButtonTypeCustom];
    type1.frame = CGRectMake(20,desc.frame.origin.y+desc
                              .frame.size.height+40, 280, 40);
    [type1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [type1 setTitle:@"推荐认证" forState:UIControlStateNormal];
    [type1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [type1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [type1 addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    type1.tag=1;
    [scrollView addSubview:type1];
    
    UIButton *type2 = [UIButton buttonWithType:UIButtonTypeCustom];
    type2.frame = CGRectMake(20,type1.frame.origin.y+type1
                              .frame.size.height+20, 280, 40);
    [type2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [type2 setTitle:@"平台认证" forState:UIControlStateNormal];
    [type2 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [type2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [type2 addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    type2.tag=2;
    [scrollView addSubview:type2];
    
    UIButton *type3 = [UIButton buttonWithType:UIButtonTypeCustom];
    type3.frame = CGRectMake(20,type2.frame.origin.y+type2
                              .frame.size.height+20, 280, 40);
    [type3.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [type3 setTitle:@"跳过认证" forState:UIControlStateNormal];
    [type3 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [type3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [type3 addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    type3.tag=3;
    [scrollView addSubview:type3];
}
-(void)submitAction:(UIButton*)btn{
    if(btn.tag==1){
        RecommendCertificationViewController *cer=[[RecommendCertificationViewController alloc]init];
        cer.cc=recommendCertification;
        [self.navigationController pushViewController: cer animated: NO];
    }
    else if(btn.tag==2){
        RecommendCertificationViewController *cer=[[RecommendCertificationViewController alloc]init];
        cer.cc=platformCertification;
        [self.navigationController pushViewController: cer animated: NO];
    }
    else{
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app showMainUI];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
