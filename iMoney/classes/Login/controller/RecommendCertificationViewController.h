//
//  RecommendCertificationViewController.h
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalNameViewController.h"
#import "PersonalOtherViewController.h"
#import "RecommendPersonViewController.h"
#import "SchoolInfoViewController.h"
#import "DataPickerViewController.h"
#import "SchoolInfoListViewController.h"
@interface RecommendCertificationViewController : BaseViewController <UITextFieldDelegate,DataPickerViewControllerDelegate>
@property(nonatomic,assign) CertificationClass cc;
@end
