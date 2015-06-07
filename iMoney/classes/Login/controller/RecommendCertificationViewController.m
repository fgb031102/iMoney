//
//  RecommendCertificationViewController.m
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "RecommendCertificationViewController.h"
@interface RecommendCertificationViewController ()
{
    UIScrollView *scrollView;
    UITextField *name;
    UITextField *schoolName;
    UITextField *unitName;
    UITextField *otherInfo;
    DataPickerViewController *dataPicker;
    int selectIndex;
}
@end

@implementation RecommendCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"填写认证信息";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, Screenheight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 50)];
    desc.text = @"请如实填写信息，信息一旦经过认证，无法进行修改。";
    desc.numberOfLines=2;
    desc.textAlignment=NSTextAlignmentLeft;
    desc.backgroundColor = [UIColor clearColor];
    desc.textColor = [UIColor grayColor];
    desc.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:desc];

    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(20,desc.frame.origin.y+desc
                                                                .frame.size.height+20, 60, 40)];
    title1.text = @"姓名:";
    title1.numberOfLines=1;
    title1.textAlignment=NSTextAlignmentLeft;
    title1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title1.textColor = [UIColor blackColor];
    title1.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title1];
    
    name=[[UITextField alloc]initWithFrame:CGRectMake(90, desc.frame.origin.y+desc
                                                      .frame.size.height+20, 210, 40)];
    name.placeholder=@"请输入";
    name.delegate=self;
    name.backgroundColor=[UIColor groupTableViewBackgroundColor];
    name.clearButtonMode=UITextFieldViewModeWhileEditing;
    name.keyboardType=UIKeyboardTypeDefault;
    name.textAlignment=NSTextAlignmentRight;
    [scrollView addSubview:name];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(20,title1.frame.origin.y+title1
                                                                .frame.size.height+20, 60, 40)];
    title2.text = @"毕业学校";
    title2.numberOfLines=1;
    title2.textAlignment=NSTextAlignmentLeft;
    title2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title2.textColor = [UIColor blackColor];
    title2.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title2];
    
    schoolName=[[UITextField alloc]initWithFrame:CGRectMake(90, title1.frame.origin.y+title1
                                                            .frame.size.height+20, 210, 40)];
    schoolName.placeholder=@"请输入";
    schoolName.delegate=self;
    schoolName.backgroundColor=[UIColor groupTableViewBackgroundColor];
    schoolName.clearButtonMode=UITextFieldViewModeWhileEditing;
    schoolName.keyboardType=UIKeyboardTypeDefault;
    schoolName.textAlignment=NSTextAlignmentRight;
    [scrollView addSubview:schoolName];
    
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(20,title2.frame.origin.y+title2
                                                                .frame.size.height+20, 60, 40)];
    title3.text = @"工作单位";
    title3.numberOfLines=1;
    title3.textAlignment=NSTextAlignmentLeft;
    title3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title3.textColor = [UIColor blackColor];
    title3.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title3];
    
    unitName=[[UITextField alloc]initWithFrame:CGRectMake(90, title2.frame.origin.y+title2
                                                            .frame.size.height+20, 210, 40)];
    unitName.placeholder=@"请输入";
    unitName.delegate=self;
    unitName.backgroundColor=[UIColor groupTableViewBackgroundColor];
    unitName.clearButtonMode=UITextFieldViewModeWhileEditing;
    unitName.keyboardType=UIKeyboardTypeDefault;
    unitName.textAlignment=NSTextAlignmentRight;
    [scrollView addSubview:unitName];
    
    UILabel *title4 = [[UILabel alloc] initWithFrame:CGRectMake(20,title3.frame.origin.y+title3
                                                                .frame.size.height+20, 60, 40)];
    title4.text = @"其他信息";
    title4.numberOfLines=1;
    title4.textAlignment=NSTextAlignmentLeft;
    title4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    title4.textColor = [UIColor blackColor];
    title4.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:title4];
    
    otherInfo=[[UITextField alloc]initWithFrame:CGRectMake(90, title3.frame.origin.y+title3
                                                          .frame.size.height+20, 210, 40)];
    otherInfo.placeholder=@"请输入";
    otherInfo.delegate=self;
    otherInfo.backgroundColor=[UIColor groupTableViewBackgroundColor];
    otherInfo.clearButtonMode=UITextFieldViewModeWhileEditing;
    otherInfo.keyboardType=UIKeyboardTypeDefault;
    otherInfo.textAlignment=NSTextAlignmentRight;
    [scrollView addSubview:otherInfo];
    
    UIButton *type5 = [UIButton buttonWithType:UIButtonTypeCustom];
    type5.frame = CGRectMake(20,title4.frame.origin.y+title4
                             .frame.size.height+40, 280, 40);
    [type5.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [type5 setTitle:@"下一步" forState:UIControlStateNormal];
    [type5 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [type5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [type5 addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:type5];
}
-(void)viewWillAppear:(BOOL)animated{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid = %@",[GlobalVar share].user.userid];
    NSArray *arr=[RecommendCertification MR_findAllWithPredicate:predicate];
    if (arr.count>0) {
        RecommendCertification *rc =[arr objectAtIndex:0];
        NSArray *temp=[rc.schoolInfo componentsSeparatedByString:@";"];
        NSArray *temp1=[[temp objectAtIndex:0] componentsSeparatedByString:@","];
        name.text=rc.nameInfo;
        schoolName.text=[temp1 objectAtIndex:0];
        unitName.text=rc.workInfo;
        otherInfo.text=rc.otherInfo;
    }
}

#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self resignFirstResponder];
    if (textField==name) {
        PersonalNameViewController *cer=[[PersonalNameViewController alloc]init];
        [self.navigationController pushViewController: cer animated: YES];
        [self hiheKedboard];
    }
    else if (textField==schoolName){
        SchoolInfoListViewController *list=[[SchoolInfoListViewController alloc]init];
        list.dc=school;
        [self.navigationController pushViewController: list animated: NO];
        [self hiheKedboard];
    }
    else if (textField==unitName){
        SchoolInfoListViewController *list=[[SchoolInfoListViewController alloc]init];
        list.dc=unit;
        [self.navigationController pushViewController: list animated: NO];
        [self hiheKedboard];
//        dataPicker=[[DataPickerViewController alloc]init];
//        dataPicker.delegate=self;
//        dataPicker.dataSource=[[NSMutableArray alloc]initWithObjects:@"理科类",@"工科类",@"经济类",@"管理类",@"哲学类",@"历史类",@"经济学类",@"社会学类",@"其他", nil];
//        dataPicker.view.frame=CGRectMake(0,self.view.frame.size.height-240, 320, 216);
//        [dataPicker selectFirst];
//        [self.view addSubview:dataPicker.view];
//        selectIndex=2;
    }
    else{
        PersonalOtherViewController  *other=[[PersonalOtherViewController alloc]init];
        [self.navigationController pushViewController:other animated:NO];
         [self hiheKedboard];
    }
}

-(void)dataSelected:(NSString*)data{
    if (selectIndex==0) {
        //region.text=data;
    }
    else if(selectIndex==1){
        //recordFormal.text=data;
    }
    else if (selectIndex==2){
        //professionalType.text=data;
    }
    
    [dataPicker.view removeFromSuperview];
}

-(void)dataCancel{
    [dataPicker.view removeFromSuperview];
}

-(void)hiheKedboard{
    [schoolName resignFirstResponder];
    [name resignFirstResponder];
    [unitName resignFirstResponder];
    [otherInfo resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(void)submitAction:(UIButton*)btn{
    if (self.cc==recommendCertification) {
        RecommendPersonViewController *rpv=[[RecommendPersonViewController alloc]init];
        [self.navigationController pushViewController:rpv animated:NO];

    }
    else{
        ElectronicDataViewController *edc=[[ElectronicDataViewController alloc]init];
        [self.navigationController pushViewController:edc animated:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
