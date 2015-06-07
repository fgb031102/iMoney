//
//  YGPSegmentedController.m
//  YGPSegmentedSwitch
//
//  Created by yang on 13-6-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import "YGPSegmentedController.h"
#import "Globle.h"
#import "YGPConstKEY.h"
//按钮空隙
#define BUTTONGAP 5
//按钮长度
#define BUTTONWIDTH 100
//按钮宽度
#define BUTTONHEIGHT 25
//滑条CONTENTSIZEX
#define CONTENTSIZEX 320

//偏移量
#define Off 200
//选择显示区域（view）
#define SelectVisible (sender.tag - 100)
#define initselectedIndex 0

@implementation YGPSegmentedController
{
     int ButtonWidthBackg;
     NSMutableArray * _Buutonimage;
}

@synthesize TitleArray;
@synthesize SegmentedButton;
@synthesize Delegate=_delegate;
@synthesize Textleng;
@synthesize YGPScrollView;
@synthesize TEXTLENGARRAY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         
         self.frame =CGRectZero;
         YGPScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
         SelectedTagChang = 1;
        
        bCallDelegate = YES;
       
         [self SetScrollview];     //setup
         [self setSelectedIndex:0];
        
        self.segmentedButtonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

//初始化框架数据
-(id)initContentTitle:(NSMutableArray*)Title CGRect:(CGRect)Frame
{
     if (self = [super init])
     {
          [self addSubview:YGPScrollView];
          TitleArray = Title ;
          [self setFrame:Frame];
          [YGPScrollView setFrame:Frame];
          [self setBackgroundColor];
          YGPScrollView.contentSize = CGSizeMake(0, 40);
          TEXTLENGARRAY = [[NSMutableArray alloc]init];
     }


     //初始化button
     [self initWithButton];
     return self;
}

//设置滚动视图
-(void)SetScrollview
{
     YGPScrollView.backgroundColor = [UIColor whiteColor];
     YGPScrollView.pagingEnabled = NO;
     YGPScrollView.scrollEnabled= NO;
     YGPScrollView.showsHorizontalScrollIndicator = NO;
     YGPScrollView.showsVerticalScrollIndicator = NO;
}

//初始化button
-(void)initWithButton
{
    int buttonPadding = 18;
     int xPos = 0;
     SegmentedButton.titleLabel.text=nil;
     NSMutableArray * array2 = [[NSMutableArray alloc]init];
     for (int i = 0; i<[self.TitleArray count]; i++)
     {
          
          NSString *title = [TitleArray objectAtIndex:i];
          SegmentedButton = [BBBadgeButton buttonWithType:UIButtonTypeCustom];
          [SegmentedButton setTitle:[NSString stringWithFormat:@"%@",[self.TitleArray objectAtIndex:i]] forState:UIControlStateNormal];

         
          int buttonWidth = [title sizeWithFont:SegmentedButton.titleLabel.font
                             constrainedToSize:CGSizeMake(150, 40)
                                  lineBreakMode:NSLineBreakByCharWrapping].width;
          
          [SegmentedButton setFrame:CGRectMake(xPos, 9, buttonWidth + buttonPadding, BUTTONHEIGHT)];
          SegmentedButton.tag = i + 100;
          if (i==0)
               SegmentedButton.selected = NO;
         
          [SegmentedButton setTitleColor:[Globle colorFromHexRGB:@"868686"] forState:UIControlStateNormal];
          [SegmentedButton setTitleColor:[Globle colorFromHexRGB:@"1ca0f2"] forState:UIControlStateSelected];
          [SegmentedButton addTarget:self action:@selector(SelectButton:) forControlEvents:UIControlEventTouchUpInside];
       
          
          xPos += buttonWidth+buttonPadding;
          
          _Buutonimage = [[NSMutableArray alloc]init];
          ButtonWidthBackg=buttonWidth+buttonPadding;
         
          NSString * strings;
          strings = nil;
         strings = [NSString stringWithFormat:@"%f",SegmentedButton.frame.size.width];
          
          [_Buutonimage removeAllObjects];
          [array2 addObject:strings];
          for (NSMutableArray * array3 in array2) {
               [_Buutonimage addObject:array3];
          }
      
         SegmentedButton.badgeBGColor = [UIColor redColor];
         SegmentedButton.badgeTextColor = [UIColor whiteColor];
         SegmentedButton.badgeOriginX = 68;
         SegmentedButton.badgeOriginY = -5;

          [YGPScrollView addSubview:SegmentedButton];
         
         //add segment
         if (i != [self.TitleArray count] - 1) {
             UIImageView *segView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"daohang_shuxiang.png"]];
             segView.frame = CGRectMake(xPos - 2, 12, 2, 20);
             [YGPScrollView addSubview:segView];
         }
         
         //add to segment to array
         [self.segmentedButtonArray addObject:SegmentedButton];
     }
     
     //设置选中背景
     ButtonbackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[_Buutonimage objectAtIndex:0]floatValue], 40)];
     [ButtonbackgroundImage setImage:[UIImage imageNamed:@"red_background.png"]];
     [YGPScrollView addSubview:ButtonbackgroundImage];
}

//点击button调用方法
-(void)SelectButton:(UIButton*)sender
{
     //取消当前选择
     if (sender.tag != SelectedTagChang)
     {
          UIButton * ALLButton = (UIButton*)[self viewWithTag:SelectedTagChang];
          ALLButton.selected = NO;
          SelectedTagChang = sender.tag;
     }
   
     sender.selected = YES;
   
     //button 背景图片
     [UIView animateWithDuration:0.25 animations:^{
          [ButtonbackgroundImage setFrame:CGRectMake(sender.frame.origin.x, 0,[[_Buutonimage objectAtIndex:SelectVisible]floatValue] , 40)];
     } completion:^(BOOL finished){
       }];

    if (bCallDelegate)
        [self setSelectedIndex:SelectVisible];
    bCallDelegate = YES;

    //float x = YGPScrollView.contentOffset.x;
    //[YGPScrollView setContentOffset:CGPointMake(x, 0)];
     
     
     //设置居中
     //if (sender.frame.origin.x>Off)
     //{
          //[YGPScrollView setContentOffset:CGPointMake(sender.frame.origin.x-130, 0) animated:YES];
     //}

}

//选择index
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
     if ([_delegate respondsToSelector:@selector(segmentedViewController:touchedAtIndex:)])
          [_delegate segmentedViewController:self touchedAtIndex:selectedIndex];
}

-(void)setBackgroundColor
{
    YGPScrollView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:241.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    YGPScrollView.alpha = 0.9;
}

-(void)setSelectedSegment:(NSInteger)index{
    bCallDelegate = NO;
    UIButton *btn = [self.segmentedButtonArray objectAtIndex:index];
    [self SelectButton:btn];
}

-(void)setBadgeValue:(NSInteger)value Segment:(NSInteger)index{
    if (value > 99) value = 99;
    BBBadgeButton *btn = [self.segmentedButtonArray objectAtIndex:index];
    btn.badgeValue = [NSString stringWithFormat:@"%d", value];
}

-(void)setText:(NSString*)text Segment:(NSInteger)index{
    BBBadgeButton *btn = [self.segmentedButtonArray objectAtIndex:index];
    [btn setTitle:text forState:UIControlStateNormal];
}

-(NSInteger)getSelectedSegmentIndex{
    return SelectedTagChang - 100;
}

@end
