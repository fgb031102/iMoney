//
//  GuideViewController.h
//  IQPlatform
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol indexCallbaceDelegate;
@interface GuideViewController : UIViewController<UIScrollViewDelegate,UIPageViewControllerDelegate>
@property(nonatomic,assign) id<indexCallbaceDelegate> delegate;
@end

@protocol indexCallbaceDelegate <NSObject>

-(void)entryMainPage;

@end
