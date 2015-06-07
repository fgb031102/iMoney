//
//  AppDelegate.h
//  iPregnant
//
//  Created by Yongfei He on 14-7-19.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQArticleViewController.h"
#import "IQMarketViewController.h"
#import "IQArrangementsViewController.h"
#import "IQMessageViewController.h"
#import "IQMyViewController.h"
#import "LeveyTabBarController.h"
#import "GuideViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "JMAPIRequest.h"
#import "RegisterViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, LeveyTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (atomic, strong)      NSOperationQueue *requestQueue;
@property (nonatomic,strong)    LeveyTabBarController *tabBarCtrl;
@property (nonatomic,strong)    UINavigationController *nav;

@property(nonatomic, strong)  IQArticleViewController *article;
@property(nonatomic, strong) IQMarketViewController *market;
@property(nonatomic, strong)  IQArrangementsViewController *arrangements;
@property(nonatomic, strong)  IQMessageViewController *message;
@property(nonatomic, strong)  IQMyViewController *my;


@property(nonatomic, strong)  UIButton *msgNoteBtn;
@property  int msgNum_init;
@property  int msgNum;
@property  int bindBaiduNum;
@property(nonatomic, strong)  NSData *deviceTokenData;
-(void)showMainUI;
-(void)userLogin;
-(void)userReg;
@end
