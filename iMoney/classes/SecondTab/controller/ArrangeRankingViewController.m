//
//  ArrangeRankingViewController.m
//  IQPlatform
//
//  Created by hulin on 15-1-3.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "ArrangeRankingViewController.h"
#import "ArrangeTableViewCell.h"
#import "ShowArrangeViewController.h"

@interface ArrangeRankingViewController ()

@end

@implementation ArrangeRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动榜";
    self.view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - IO7_TOP_BAR_HEIGHT);
    
    [PublicUtility setupNavgatorbar:self];
    [self leftBar];
    
    UIImage* imgFilterBtn = [UIImage imageNamed:@"public_ico_ share.png"];
    UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    filterBtn.backgroundColor = [UIColor clearColor];
    filterBtn.frame = CGRectMake(0, 0, 30, 30);
    [filterBtn setImage:imgFilterBtn forState:UIControlStateNormal];
    [filterBtn addTarget: self action: @selector(filterBtnAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIImage *imgFindBtn = [UIImage imageNamed:@"public_ico_ collect.png"];
    UIButton *findBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    findBtn.frame = CGRectMake(0, 0, 30, 30);
    [findBtn setImage:imgFindBtn forState:UIControlStateNormal];
    [findBtn addTarget: self action: @selector(findBtnAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *filterBtnItem = [[UIBarButtonItem alloc]initWithCustomView:filterBtn];
    UIBarButtonItem *findBtnItem = [[UIBarButtonItem alloc]initWithCustomView:findBtn];
    NSArray *buttonArray = [NSArray arrayWithObjects:findBtnItem,filterBtnItem, nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
    //add table view
    self.itemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.itemsTableView.dataSource = self;
    self.itemsTableView.delegate = self;
    self.itemsTableView.showsVerticalScrollIndicator = NO;
    //self.itemsTableView.sectionFooterHeight = 10;
    [self.view addSubview:self.itemsTableView];
    
    [self loadData];
}

-(void) viewWillAppear:(BOOL)animated{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.tabBarCtrl hidesTabBar:NO animated:NO];
}

-(void) filterBtnAction
{
    
}

-(void) findBtnAction
{
    
}

-(void)loadData{
    arrangeData = [[ArrangeModel alloc]init];
    //    myInputQuestionData = [[MyInputQuestionListModel alloc] init];
    //    [myInputQuestionData getDataFromServer:^(NSInteger statusCode) {
    //        if(statusCode != -1){
    //            NSIndexSet * section2 = [[NSIndexSet alloc]initWithIndex:1];
    //            [self.itemsTableView reloadSections:section2 withRowAnimation:UITableViewRowAnimationNone];
    //            [self.itemsTableView reloadData];
    //        }
    //    }];
    //
    //    hotQuestionData = [[HotQuestionListModel alloc] init];
    //    [hotQuestionData getDataFromServer:^(NSInteger statusCode) {
    //        if(statusCode != -1){
    //            //该页面只显示5个数据
    //            if (hotQuestionData.dataArray.count>5) {
    //                for (int i=5; i<hotQuestionData.dataArray.count; i++) {
    //                    [hotQuestionData.dataArray removeObjectAtIndex:i];
    //                }
    //            }
    //
    //            NSIndexSet * section2 =[[NSIndexSet alloc]initWithIndex:2];
    //            [self.itemsTableView reloadSections:section2 withRowAnimation:UITableViewRowAnimationNone];
    //            [self.itemsTableView reloadData];
    //        }
    //    }];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrangeData.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"ArrangePageTableViewCell";
    
    ArrangeTableViewCell *cell = (ArrangeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [DeviceCapabilityHelper loadCellFromBundle:@"ArrangeTableViewCell" andClass:[ArrangeTableViewCell class]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        //cell.imgScrollView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //cell.imgScrollView.layer.borderWidth = 0.5;
        //            [cell.submitBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
        //
        //            [cell.submitImgBtn addTarget:self action:@selector(submitImgBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArrangeModel *itemData = arrangeData.dataArray[indexPath.row];
    ShowArrangeViewController *articlePage = [[ShowArrangeViewController alloc]initWithArrange:itemData];
    [self.navigationController pushViewController:articlePage animated:YES];
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
