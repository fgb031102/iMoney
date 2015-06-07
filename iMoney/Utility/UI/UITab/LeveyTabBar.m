//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by zhang on 12-10-10.
//  Copyright (c) 2012年 jclt. All rights reserved.
//
//

#import "LeveyTabBar.h"

@implementation LeveyTabBar

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray buttonTexts:(NSArray *)buttonTextArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		//[self setShadowImage:[UIImage imageNamed:@"personal_ico_consult.png"]];
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		self.labels = [NSMutableArray arrayWithCapacity:[buttonTextArray count]];
		BBBadgeButton *btn;
		CGFloat width = 320.0f / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [[BBBadgeButton alloc] init];
			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
            btn.frame = CGRectMake(width * i, 1, width, frame.size.height);
			
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
			[self.buttons addObject:btn];
            
            btn.badgeBGColor = [UIColor redColor];
            btn.badgeTextColor = [UIColor whiteColor];
            btn.badgeOriginX = 45;
            btn.badgeOriginY = 5;
            [self addSubview:btn];
            
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:13.0f];
            label.frame = CGRectMake(width * i, 30, width, 20);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.text = buttonTextArray[i];
            [self.labels addObject:label];
            [self addSubview:label];
		}
    }
    
    return self;
}
-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	BBBadgeButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
    if ([self.inner_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [self.inner_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		BBBadgeButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
		b.userInteractionEnabled = YES;
        UILabel *label = [self.labels objectAtIndex:i];
        label.textColor = [UIColor whiteColor];
	}
	BBBadgeButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
	btn.userInteractionEnabled = NO;
    
    UILabel *label = [self.labels objectAtIndex:index];
    label.textColor = [UIColor whiteColor];
    [self bringSubviewToFront:label];
}

- (void)setBadgeValue:(NSInteger)value AtIndex:(NSInteger)index{
    if (value > 99) value = 99;
    BBBadgeButton *btn = [self.buttons objectAtIndex:index];
    btn.badgeValue = [NSString stringWithFormat:@"%ld", (long)value];
}

- (void)setText:(NSString*)text AtIndex:(NSInteger)index{
    UILabel *label = [self.labels objectAtIndex:index];
    label.text = text;
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(BBBadgeButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (BBBadgeButton *btn in self.buttons)
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (BBBadgeButton *b in self.buttons)
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    BBBadgeButton *btn = [BBBadgeButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

@end
