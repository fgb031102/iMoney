//
//  PersonalNameViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "PersonalNameViewController.h"

@interface PersonalNameViewController ()
{
    UIScrollView *scrollView;
    UITextField *name;
    UITextField *name1;
}
@end

@implementation PersonalNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"姓名";
    [super barRight:@"保存"];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    //姓
    name = [[UITextField alloc]initWithFrame:CGRectMake(20, 20,280, 40)];
    name.backgroundColor=[UIColor groupTableViewBackgroundColor];
    name.placeholder = @"姓  （必须输入姓名）";
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:name];
    //名
    name1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 80,280, 40)];
    name1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    name1.placeholder = @"名  （必须输入姓名）";
    name1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scrollView addSubview:name1];
}
-(void)rightAction{
    if (name.text.length==0 && name1.text.length==0) {
        [SVStatusHUD showWithStatus:@"信息必须填写完整"];
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid = %@",[GlobalVar share].user.userid];
    NSArray *arr=[RecommendCertification MR_findAllWithPredicate:predicate];
    if (arr.count==0) {
        RecommendCertification *rc=[RecommendCertification MR_createEntity];
        rc.userid=[GlobalVar share].user.userid;
        rc.nameInfo=[NSString stringWithFormat:@"%@%@",name.text,name1.text];
        rc.schoolInfo=@"";
        rc.workInfo=@"";
        rc.otherInfo=@"";
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    }
    else{
        RecommendCertification *rc =[arr objectAtIndex:0];
        rc.userid=rc.userid;
        rc.nameInfo=[NSString stringWithFormat:@"%@%@",name.text,name1.text];
        rc.schoolInfo=rc.schoolInfo;
        rc.workInfo=rc.workInfo;
        rc.otherInfo=rc.otherInfo;
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
