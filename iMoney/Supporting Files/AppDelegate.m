//
//  AppDelegate.m
//  iPregnant
//
//  Created by Yongfei He on 14-7-19.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BPush.h"
#import "JSONKit.h"
#import "OpenUDID.h"
//#import "PushMessageManager.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // request Queuee
    self.requestQueue = [[NSOperationQueue alloc] init];
    // Allow 30 concurrent requests
    [self.requestQueue setMaxConcurrentOperationCount:15];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //load NSUserDefaults data
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_data"];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [GlobalVar share].user = user;
    
    //Baidu Push
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    
    //launch by remote
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] != nil) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        //[[PushMessageManager getInstance] fetchUnReadMsg];
    }
    
    //guide
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstUserApp"]) {
        GuideViewController *guide=[[GuideViewController alloc]init];
        [self.window setRootViewController:guide];
        [self.window makeKeyAndVisible];
    }
    else{
        [self showMainUI];
    }
    
    //set the appkey of UMeng
    [UMSocialData setAppKey:@"53f7fbc0fd98c585ca01b20c"];
    [UMSocialQQHandler setQQWithAppId:@"100426610" appKey:@"e4ad744fb7dbb47097d87cb7a161368f" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setSupportQzoneSSO:YES];
    [UMSocialWechatHandler setWXAppId:@"wxab4bc949d618c29c" url:nil];
    //setStatusBarStyle
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    int cacheSizeMemory = 1*1024*1024; // 4MB
    int cacheSizeDisk = 5*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    NSString *dataBasePath= [documentPath stringByAppendingPathComponent:@"iq.sqlite"];
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:[NSURL fileURLWithPath:dataBasePath]];
     return YES;
}

-(void)showMainUI{
    self.article = [[IQArticleViewController alloc] init];
    UINavigationController *articleNav = [[UINavigationController alloc] init];
    [articleNav pushViewController: self.article animated: FALSE];
    
    self.market = [[IQMarketViewController alloc] init];
    UINavigationController *marketNav = [[UINavigationController alloc] init];
    [marketNav pushViewController: self.market animated: FALSE];
    
    self.arrangements = [[IQArrangementsViewController alloc] init];
    UINavigationController *arrangementsNav = [[UINavigationController alloc] init];
    [arrangementsNav pushViewController: self.arrangements animated: FALSE];
    
    self.message = [[IQMessageViewController alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc] init];
    [messageNav pushViewController: self.message animated: FALSE];
    
    self.my= [[IQMyViewController alloc] init];
    UINavigationController *myNav = [[UINavigationController alloc] init];
    [myNav pushViewController: self.my animated: FALSE];
    
	NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic1 setObject:[UIImage imageNamed:@"tab_ico_consult"] forKey:@"Default"];
	[imgDic1 setObject:[UIImage imageNamed:@"tab_ico_consult_pressed"] forKey:@"Highlighted"];
	[imgDic1 setObject:[UIImage imageNamed:@"tab_ico_consult_pressed"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"tab_ico_diary"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"tab_ico_diary_pressed"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"tab_ico_diary_pressed"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"tab_ico_diary"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"tab_ico_diary_pressed"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"tab_ico_diary_pressed"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"tab_ico_genetic"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"tab_ico_genetic_pressed"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"tab_ico_genetic_pressed"] forKey:@"Seleted"];
    
	NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic5 setObject:[UIImage imageNamed:@"tab_ico_ personal"] forKey:@"Default"];
	[imgDic5 setObject:[UIImage imageNamed:@"tab_ico_ personal_pressed"] forKey:@"Highlighted"];
	[imgDic5 setObject:[UIImage imageNamed:@"tab_ico_ personal_pressed"] forKey:@"Seleted"];
	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic1,imgDic3,imgDic4,imgDic5,nil];
	
	self.tabBarCtrl = [[LeveyTabBarController alloc] initWithViewControllers:[NSArray arrayWithObjects: articleNav, arrangementsNav, messageNav, myNav, nil] imageArray:imgArr buttonTexts:[[NSArray alloc] initWithObjects:@"首页", @"课表", @"消息", @"我的", nil]];
    self.tabBarCtrl.delegate = self;
    [self.tabBarCtrl setTabBarTransparent:NO];
    
    UIImage* btnBjImg = [UIImage imageNamed:@"consult_ico_circle.png"];
    self.msgNoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.msgNoteBtn.frame = CGRectMake(40, self.tabBarCtrl.tabBar.frame.size.height-45, 15, 15);
    [self.msgNoteBtn setBackgroundImage:btnBjImg forState:UIControlStateNormal];
    [self.msgNoteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.msgNoteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:7];
    [self.tabBarCtrl.tabBar addSubview:self.msgNoteBtn];
    [self.msgNoteBtn setHidden:YES];
    self.msgNum_init = 0;
    self.msgNum = 0;
    self.bindBaiduNum = 0;
    
    [self.window setRootViewController:self.tabBarCtrl];
    [self.window makeKeyAndVisible];
}
-(void)userReg{
    RegisterViewController *reg=[[RegisterViewController alloc]init];
    UINavigationController *navOnLoginViewController = [[UINavigationController alloc] init];
    [navOnLoginViewController pushViewController: reg animated: FALSE];
    [self.window setRootViewController:navOnLoginViewController];
    [self.window makeKeyAndVisible];
}
-(void)userLogin{
    LoginViewController *login=[[LoginViewController alloc]init];
    UINavigationController *navOnLoginViewController = [[UINavigationController alloc] init];
    [navOnLoginViewController pushViewController: login animated: FALSE];
    [self.window setRootViewController:navOnLoginViewController];
    [self.window makeKeyAndVisible];
}
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application{
    [application setApplicationIconBadgeNumber:0];
    //[[PushMessageManager getInstance] fetchUnReadMsg];
    
    if (self.msgNum_init >0) {
        [self.tabBarCtrl setSelectedIndex:0];  //定位到在线咨询首页
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [self.tabBarCtrl setSelectedIndex:2];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken deviceToken:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannel];
    self.deviceTokenData = deviceToken;
}

- (void) onMethod:(NSString*)method response:(NSDictionary*)data
{
    NSLog(@"On method:%@", method);
    NSLog(@"data:%@", [data description]);
    
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            NSLog(@"appID:%@\n userID:%@\n channelID:%@\n",appid,userid,channelid);
            
            {
                NSString *pushValue=[NSString stringWithFormat:@"%@,%@",userid,channelid];
                [[NSUserDefaults standardUserDefaults] setObject:pushValue forKey:@"BDpush"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            if ([GlobalVar share].user) {
                UserModel *model=[GlobalVar share].user;
                model.push_user_id = userid;
                model.push_channel_id = channelid;
                [GlobalVar share].user=model;
                NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
                [ud setObject: [NSKeyedArchiver archivedDataWithRootObject:model] forKey:@"user_data"];
                [ud synchronize];
            }
            else{
                UserModel *model=[[UserModel alloc]init];
                model.push_user_id = userid;
                model.push_channel_id = channelid;
                [GlobalVar share].user=model;
                NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
                [ud setObject: [NSKeyedArchiver archivedDataWithRootObject:model] forKey:@"user_data"];
                [ud synchronize];
            }
            [self submitBaiduID];
        } else {
            //绑定失败时，再次尝试3次
            if (self.bindBaiduNum<3) {
                [BPush registerDeviceToken:self.deviceTokenData];
                [BPush bindChannel];
                self.bindBaiduNum++;
            }
        }
        
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            NSLog(@"BPushRequestMethod_Unbind");
        }
    }
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSLog(@"%@", aps);
    NSString *content;
    
    NSString *questionID = [userInfo objectForKey:@"question_id"];
    NSString *msgID = [userInfo objectForKey:@"msg_id"];
    NSString *alert = [aps objectForKey:@"alert"];
    NSString *msgType = [userInfo objectForKey:@"msg_type"];
    
    content = alert;
    if ([msgType isEqualToString:@"picture"]) {
        NSString *picture_url = [userInfo objectForKey:@"picture_url"];
        content = picture_url;
    }
    
    if (application.applicationState == UIApplicationStateActive) {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.

    }
    [application setApplicationIconBadgeNumber:0];
    [BPush handleNotification:userInfo];
    
    self.msgNum_init ++;
    [self.msgNoteBtn setHidden:NO];
    
    //[[PushMessageManager getInstance] showMsg:questionID msgID:msgID contet:content type:msgType];
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
-(void)submitBaiduID
{
    if ([GlobalVar share].user.login_token == nil) {
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *apiUrl = @"users/update_device_token/";
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"BDpush"];
    NSArray *arr=[str componentsSeparatedByString:@","];
    if (arr.count<2) {
        return;
    }
    [params setValue: [GlobalVar share].user.login_token forKey:@"login_token"];
    [params setValue: @"4" forKey:@"device_type"];
    [params setValue: [arr objectAtIndex:0] forKey:@"push_user_id"];
    [params setValue: [arr objectAtIndex:1]  forKey:@"push_channel_id"];
    
    [JMAPIRequest offlineRequestWithMethod:@"GET" path:apiUrl params:params response:^(id data, NSInteger statusCode) {
        if (![PublicUtility handleNetworkwithNoPromptRet:data Status:statusCode]) {
            NSLog(@"###submit BaiduID fail!");
        }else{
            NSLog(@"###submit BaiduID success!");
        }
    }];
}

-(void) applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"$$$$ applicationDidReceiveMemoryWarning!!");
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
