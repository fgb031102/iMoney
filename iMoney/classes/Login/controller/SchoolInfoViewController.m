//
//  SchoolInfoViewController.m
//  HMSoft
//
//  Created by yunfei on 14/12/30.
//
//

#import "SchoolInfoViewController.h"
@interface SchoolInfoViewController ()
{
    UITextField *schoolName;
    UITextField *region;
    UITextField *recordFormal;
    UITextField *professionalType;
    UITextField *professionalName;
    UIScrollView *scroll;
    DataPickerViewController *dataPicker;
    int selectIndex;
}
@end

@implementation SchoolInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super barRight:@"保存"];
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth,Screenheight)];
    [self.view addSubview:scroll];
    [scroll setBackgroundColor:[UIColor whiteColor]];
    [scroll setContentSize:CGSizeMake(0, 580)];
    
    schoolName=[[UITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 40)];
    schoolName.delegate=self;
    schoolName.backgroundColor=[UIColor groupTableViewBackgroundColor];
    schoolName.clearButtonMode=UITextFieldViewModeWhileEditing;
    schoolName.keyboardType=UIKeyboardTypeDefault;
    [scroll addSubview:schoolName];
    
    region=[[UITextField alloc]initWithFrame:CGRectMake(20, schoolName.frame.origin.y+schoolName.frame.size.height+20, 280, 40)];
    region.delegate=self;
    region.backgroundColor=[UIColor groupTableViewBackgroundColor];
    region.clearButtonMode=UITextFieldViewModeWhileEditing;
    region.keyboardType=UIKeyboardTypeDefault;
    [scroll addSubview:region];
    
    recordFormal=[[UITextField alloc]initWithFrame:CGRectMake(20, region.frame.origin.y+region.frame.size.height+20, 280, 40)];
    recordFormal.delegate=self;
    recordFormal.backgroundColor=[UIColor groupTableViewBackgroundColor];
    recordFormal.clearButtonMode=UITextFieldViewModeWhileEditing;
    recordFormal.keyboardType=UIKeyboardTypeDefault;
    [scroll addSubview:recordFormal];
    
    professionalType=[[UITextField alloc]initWithFrame:CGRectMake(20, recordFormal.frame.origin.y+recordFormal.frame.size.height+20, 280, 40)];
    professionalType.delegate=self;
    professionalType.backgroundColor=[UIColor groupTableViewBackgroundColor];
    professionalType.clearButtonMode=UITextFieldViewModeWhileEditing;
    professionalType.keyboardType=UIKeyboardTypeDefault;
    [scroll addSubview:professionalType];
    
    professionalName=[[UITextField alloc]initWithFrame:CGRectMake(20, professionalType.frame.origin.y+professionalType.frame.size.height+20, 280, 40)];
    professionalName.delegate=self;
    professionalName.backgroundColor=[UIColor groupTableViewBackgroundColor];
    professionalName.clearButtonMode=UITextFieldViewModeWhileEditing;
    professionalName.keyboardType=UIKeyboardTypeDefault;
    [scroll addSubview:professionalName];
    
    if(self.dc==school){
        schoolName.placeholder=@"学校名称";
        region.placeholder=@"地区";
        recordFormal.placeholder=@"学历";
        professionalType.placeholder=@"专业类型";
        professionalName.placeholder=@"专业名称";
    }
    else{
        schoolName.placeholder=@"单位名称";
        region.placeholder=@"单位类别";
        recordFormal.placeholder=@"工作年限";
        professionalType.placeholder=@"岗位专业";
        professionalName.placeholder=@"职务";
    }
}
#pragma mark - textField

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.dc==school){
        if (textField==region) {
            dataPicker=[[DataPickerViewController alloc]init];
            dataPicker.delegate=self;
            dataPicker.dataSource=[[NSMutableArray alloc]initWithObjects:@"国内",@"国外", nil];
            dataPicker.view.frame=CGRectMake(0,self.view.frame.size.height-240, 320, 216);
            [dataPicker selectFirst];
            [self.view addSubview:dataPicker.view];
            selectIndex=0;
            [self hiheKedboard];
        }
        else if (textField==recordFormal){
            dataPicker=[[DataPickerViewController alloc]init];
            dataPicker.delegate=self;
            dataPicker.dataSource=[[NSMutableArray alloc]initWithObjects:@"博士",@"在职博士",@"硕士",@"在职硕士",@"本科",@"双学位",@"其他", nil];
            dataPicker.view.frame=CGRectMake(0,self.view.frame.size.height-240, 320, 216);
            [dataPicker selectFirst];
            [self.view addSubview:dataPicker.view];
            selectIndex=1;
            [self hiheKedboard];
        }
        else if (textField==professionalType){
            dataPicker=[[DataPickerViewController alloc]init];
            dataPicker.delegate=self;
            dataPicker.dataSource=[[NSMutableArray alloc]initWithObjects:@"理科类",@"工科类",@"经济类",@"管理类",@"哲学类",@"历史类",@"经济学类",@"社会学类",@"其他", nil];
            dataPicker.view.frame=CGRectMake(0,self.view.frame.size.height-240, 320, 216);
            [dataPicker selectFirst];
            [self.view addSubview:dataPicker.view];
            selectIndex=2;
            [self hiheKedboard];
        }
    }
    else{
        if (textField==region) {
            dataPicker=[[DataPickerViewController alloc]init];
            dataPicker.delegate=self;
            dataPicker.dataSource=[[NSMutableArray alloc]initWithObjects:@"政府部门",@"事业单位",@"科研院所",@"企业",@"国外机构",@"其他", nil];
            dataPicker.view.frame=CGRectMake(0,self.view.frame.size.height-240, 320, 216);
            [dataPicker selectFirst];
            [self.view addSubview:dataPicker.view];
            selectIndex=0;
            [self hiheKedboard];
        }
        else if (textField==recordFormal){
            dataPicker=[[DataPickerViewController alloc]init];
            dataPicker.delegate=self;
            dataPicker.dataSource=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@">5", nil];
            dataPicker.view.frame=CGRectMake(0,self.view.frame.size.height-240, 320, 216);
            [dataPicker selectFirst];
            [self.view addSubview:dataPicker.view];
            selectIndex=1;
            [self hiheKedboard];
        }
    }
}

-(void)dataSelected:(NSString*)data{
    if (selectIndex==0) {
        region.text=data;
    }
    else if(selectIndex==1){
        recordFormal.text=data;
    }
    else if (selectIndex==2){
        professionalType.text=data;
    }
    
    [dataPicker.view removeFromSuperview];
}

-(void)dataCancel{
    [dataPicker.view removeFromSuperview];
}

-(void)hiheKedboard{
    [schoolName resignFirstResponder];
    [region resignFirstResponder];
    [recordFormal resignFirstResponder];
    [professionalType resignFirstResponder];
    [professionalName resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(void)rightAction{
    if(schoolName.text.length>0 && region.text.length>0 && recordFormal.text.length>0 && professionalType.text.length>0 && professionalName.text.length>0){
        if ([self.delegate respondsToSelector:@selector(SchoolInfo:)]) {
            
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid = %@",[GlobalVar share].user.userid];
        NSArray *arr=[RecommendCertification MR_findAllWithPredicate:predicate];
        if (arr.count==0) {
            RecommendCertification *rc=[RecommendCertification MR_createEntity];
            rc.userid=[GlobalVar share].user.userid;
            rc.nameInfo=@"";
            rc.schoolInfo=[NSString stringWithFormat:@"%@,%@,%@,%@,%@;",schoolName.text,region.text,recordFormal.text,professionalType.text,professionalName.text];
            rc.workInfo=@"";
            rc.otherInfo=@"";
            [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        }
        else{
            RecommendCertification *rc =[arr objectAtIndex:0];
            NSString *str=[NSString stringWithFormat:@"%@%@,%@,%@,%@,%@;",rc.schoolInfo,schoolName.text,region.text,recordFormal.text,professionalType.text,professionalName.text];
            rc.userid=rc.userid;
            rc.nameInfo=rc.nameInfo;
            rc.schoolInfo=str;
            rc.workInfo=rc.workInfo;
            rc.otherInfo=rc.otherInfo;
            [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        }
        [self.navigationController popViewControllerAnimated:NO];
    }
    else{
        [SVStatusHUD showWithStatus:@"信息必须填写完整"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
@implementation SchoolInfoEntity

@end