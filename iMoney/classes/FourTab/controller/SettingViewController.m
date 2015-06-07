//
//  SettingViewController.m
//  IQPlatform
//
//  Created by heyunfei on 15-1-5.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    UITableView *table;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftBar];
    self.title=@"设置";
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    table.backgroundColor = [UIColor whiteColor];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(20, 10,120,30)];
        name.tag=101;
        name.textColor=[UIColor grayColor];
        name.textAlignment=NSTextAlignmentLeft;
        name.font=[UIFont systemFontOfSize:15];
        [cell addSubview:name];
    }
    UILabel *n1=(UILabel*)[cell viewWithTag:101];
    if (indexPath.row==0) {
        n1.text=@"签名档设置";
    }
    else if (indexPath.row==1) {
        n1.text=@"密码设置";
    }
    else if (indexPath.row==2) {
        n1.text=@"隐私设置";
    }
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
//            PersonalInfoViewController *personal=[[PersonalInfoViewController alloc]init];
//            [self.navigationController pushViewController:personal animated:NO];
        }
            break;
        case 1:
        {
            
            break;
        }
        case 2:
        {
            
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
