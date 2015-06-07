//
//  PersonalInfoViewController.m
//  IQPlatform
//
//  Created by heyunfei on 15-1-5.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "PersonalInfoViewController.h"

@interface PersonalInfoViewController ()
{
    UITableView *table;
    UIView *headerView;
}
@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftBar];
    self.title=@"个人资料";
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    table.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    table.backgroundColor = [UIColor whiteColor];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    {
        headerView = [[UIView alloc]init];
        headerView.frame=CGRectMake(0, 0, 300, 70);
        table.tableHeaderView = headerView;
        
        UILabel *record = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 220, 30)];
        record.text = @"头像";
        record.backgroundColor = [UIColor clearColor];
        record.textColor = [UIColor grayColor];
        record.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:record];
        
        UIImageView *header=[[UIImageView alloc]initWithFrame:CGRectMake(250, 10, 50, 50)];
        header.layer.masksToBounds=YES;
        header.layer.cornerRadius=25;
        header.backgroundColor=[UIColor grayColor];
        //header.image=[UIImage imageNamed:@"tab_ico_ personal"];
        [headerView addSubview:header];
        
        UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modifyHandle)];
        headerView.userInteractionEnabled=YES;
        [headerView addGestureRecognizer:TapGesture];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[delegate.tabBarCtrl hidesTabBar:NO animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(20, 10,280,30)];
        name.tag=101;
        name.textColor=[UIColor grayColor];
        name.textAlignment=NSTextAlignmentLeft;
        name.font=[UIFont systemFontOfSize:15];
        [cell addSubview:name];
    }
    UILabel *n1=(UILabel*)[cell viewWithTag:101];
    if (indexPath.row==0) {
        n1.text=@"性别";
    }
    else if (indexPath.row==1) {
        n1.text=@"xxx大学   博士   经济学";
    }
    else if (indexPath.row==2) {
        n1.text=@"xxx机构   科研院所   工程师";
    }
    else if (indexPath.row==3) {
        n1.text=@"专长地区";
    }
    else if (indexPath.row==4) {
        n1.text=@"擅长领域";
    }
    else if (indexPath.row==5) {
        n1.text=@"职称";
    }
    else if (indexPath.row==6) {
        n1.text=@"其他成果";
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}
-(void)modifyHandle{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
