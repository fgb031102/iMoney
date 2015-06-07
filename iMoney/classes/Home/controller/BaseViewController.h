//
//  BaseViewController.h
//  iPregnant
//
//  Created by heyunfei on 14-8-11.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DataClass)  {
    school,
    unit
};
typedef NS_ENUM(NSInteger, CertificationClass)  {
    recommendCertification,
    platformCertification
};
@interface BaseViewController : UIViewController
-(void)leftBar;
-(BOOL)judgeLogin;
-(void)barRight:(NSString*)title;
-(void)rightAction;
-(void)showBackBtn:(BOOL)hide;
@end
