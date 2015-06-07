//
//  YGPSegmentedController.h
//  YGPSegmentedSwitch
//
//  Created by yang on 13-6-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBBadgeButton.h"

@class YGPSegmentedController;
@protocol YGPSegmentedControllerDelegate <NSObject>
@optional
- (void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index;

@end

@interface YGPSegmentedController : UIView{
     UIImageView *ButtonbackgroundImage;
     NSInteger    SelectedTagChang;
     BOOL bCallDelegate;
}

@property (assign, nonatomic) id<YGPSegmentedControllerDelegate>Delegate;

@property (strong, nonatomic) NSMutableArray  * TitleArray;
@property (strong, nonatomic) BBBadgeButton* SegmentedButton;
@property (strong, nonatomic) UIScrollView * YGPScrollView;
@property (assign, nonatomic) NSUInteger  Textleng;
@property (strong, nonatomic) NSMutableArray * TEXTLENGARRAY;
@property (strong, nonatomic) NSMutableArray *segmentedButtonArray;

-(id)initContentTitle:(NSArray*)Title CGRect:(CGRect)Frame;

-(void)setBackgroundColor;

-(void)setSelectedSegment:(NSInteger)index;

-(NSInteger)getSelectedSegmentIndex;

-(void)setBadgeValue:(NSInteger)value Segment:(NSInteger)index;
-(void)setText:(NSString*)text Segment:(NSInteger)index;

@end
