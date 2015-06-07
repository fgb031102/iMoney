//
//  IQMessageViewController.m
//  消息
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "IQMessageViewController.h"
#import "SystemMessageViewController.h"
#import "InstitutionMessageViewController.h"
#import "FirendMessageViewController.h"
#import "MyCareMessageViewController.h"

@interface IQMessageViewController ()

@end

@implementation IQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
}

#pragma mark -
#pragma mark UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 10,120,30)];
        name.tag = 101;
        name.textColor = [UIColor blackColor];
        name.textAlignment = NSTextAlignmentLeft;
        name.font = [UIFont systemFontOfSize:15];
        [cell addSubview:name];
    }
    UILabel *n1 = (UILabel*)[cell viewWithTag:101];
    if (indexPath.row==0) {
        n1.text = @"系统平台消息";
    }
    else if (indexPath.row==1) {
        n1.text = @"机构用户消息";
    }
    else if (indexPath.row==2) {
        n1.text = @"好友消息";
    }
    else if (indexPath.row==3) {
        n1.text = @"我关注的人";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMessageViewController *systemMessagePage = [[SystemMessageViewController alloc]init];
    InstitutionMessageViewController *institutionMessagePage = [[InstitutionMessageViewController alloc]init];
    FirendMessageViewController *firendMessagePage = [[FirendMessageViewController alloc]init];
    MyCareMessageViewController *mycareMessagePage = [[MyCareMessageViewController alloc]init];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:systemMessagePage animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:institutionMessagePage animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:firendMessagePage animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:mycareMessagePage animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
