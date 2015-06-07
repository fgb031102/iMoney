//
//  LeveyTabBar.h
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "BBBadgeButton.h"

@protocol LeveyTabBarDelegate;

@interface LeveyTabBar : UIView
{
	UIImageView *_backgroundView;
	NSMutableArray *_buttons;
}

@property (nonatomic) UIImageView *backgroundView;
@property (nonatomic) id<LeveyTabBarDelegate> inner_delegate;
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) NSMutableArray *labels;


- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray buttonTexts:(NSArray *)buttonTextArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (void)setBackgroundImage:(UIImage *)img;

//
- (void)setBadgeValue:(NSInteger)value AtIndex:(NSInteger)index;

- (void)setText:(NSString*)text AtIndex:(NSInteger)index;

@end
@protocol LeveyTabBarDelegate<NSObject>
@optional
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
