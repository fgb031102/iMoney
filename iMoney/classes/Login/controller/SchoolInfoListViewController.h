//
//  SchoolInfoListViewController.h
//  HMSoft
//
//  Created by yunfei on 14/12/30.
//
//

#import <UIKit/UIKit.h>
#import "SchoolInfoViewController.h"
#import "RecommendCertification.h"
@interface SchoolInfoListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,assign) DataClass dc;
@end
