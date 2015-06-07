//
//  SchoolInfoViewController.h
//  HMSoft
//
//  Created by yunfei on 14/12/30.
//
//

#import <UIKit/UIKit.h>
#import "DataPickerViewController.h"
#import "RecommendCertification.h"
@protocol SchoolInfoDelegate;
@interface SchoolInfoViewController : BaseViewController<UITextFieldDelegate,DataPickerViewControllerDelegate>
@property(nonatomic,weak)id<SchoolInfoDelegate> delegate;
@property(nonatomic,assign) DataClass dc;
@end

@class SchoolInfoEntity;
@protocol SchoolInfoDelegate <NSObject>
-(void)SchoolInfo:(SchoolInfoEntity*)entity;

@end

@interface SchoolInfoEntity : NSObject
@property(nonatomic,strong) NSString *schoolName;
@property(nonatomic,strong) NSString *region;
@property(nonatomic,strong) NSString *recordFormal;
@property(nonatomic,strong) NSString *professionalType;
@property(nonatomic,strong) NSString *professionalName;
@end
