//
//  SchoolInfoListViewController.m
//  HMSoft
//
//  Created by yunfei on 14/12/30.
//
//

#import "SchoolInfoListViewController.h"

@interface SchoolInfoListViewController ()
{
    UITableView *table;
}
@end

@implementation SchoolInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super barRight:@"添加"];
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:20];
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    table.backgroundColor = [UIColor whiteColor];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    //[self tableHeadData];
}
-(void)viewWillAppear:(BOOL)animated{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid = %@",[GlobalVar share].user.userid];
    NSArray *arr=[RecommendCertification MR_findAllWithPredicate:predicate];
    if (arr.count>0) {
        [self.dataSource removeAllObjects];
        RecommendCertification *rc =[arr objectAtIndex:0];
        NSArray *temp=[rc.schoolInfo componentsSeparatedByString:@";"];
        for (NSString *e in temp) {
            if (e.length==0) {
                continue;
            }
            NSArray *temp1=[e componentsSeparatedByString:@","];
            SchoolInfoEntity *record=[[SchoolInfoEntity alloc]init];
            record.schoolName=[temp1 objectAtIndex:0];
            record.region=[temp1 objectAtIndex:1];
            record.recordFormal=[temp1 objectAtIndex:2];
            record.professionalType=[temp1 objectAtIndex:3];
            record.professionalName=[temp1 objectAtIndex:4];
            [self.dataSource addObject:record];
        }
        [table reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
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
        
        UILabel *name1=[[UILabel alloc]initWithFrame:CGRectMake(130, 10,150,30)];
        name1.tag=102;
        name1.textColor=[UIColor grayColor];
        name1.textAlignment=NSTextAlignmentRight;
        name1.font=[UIFont systemFontOfSize:15];
        [cell addSubview:name1];
    }
    UILabel *n1=(UILabel*)[cell viewWithTag:101];
    UILabel *n2=(UILabel*)[cell viewWithTag:102];
    SchoolInfoEntity *rc =[self.dataSource objectAtIndex:indexPath.row];
    n1.text=rc.schoolName;
    n2.text=rc.professionalName;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {

            break;
        }
        default:
            break;
    }
}

-(void)tableHeadData{
    UIView *headerView = [[UIView alloc]init];
    headerView.frame=CGRectMake(0, 0, 320, 30);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    btn.frame = CGRectMake(20, 20, 60, 30);
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerView addSubview:btn];
    table.tableHeaderView = headerView;
}

-(void)rightAction{
    SchoolInfoViewController *info=[[SchoolInfoViewController alloc]init];
    info.dc=self.dc;
    [self.navigationController pushViewController:info animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
