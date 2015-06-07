//
//  UIButton+AA.m
//  iTravel
//
//  Created by Yongfei He on 14-5-31.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import "UIButton+ImageOnRightEdgeButton.h"

@implementation UIButton (ImageOnRightEdgeButton)

-(void)drawSeperatorLine{
    UIImage *img = [UIImage imageNamed:@"button_seperator_vertical_line"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(self.frame.size.width - img.size.width, (self.frame.size.height - img.size.height) / 2, img.size.width, img.size.height);
    [self addSubview:imgView];
}

-(void)drawDownArrow{
    //image
    float x = self.frame.size.width / 2 + self.titleLabel.frame.size.width / 2;
    UIImage *img = [UIImage imageNamed:@"down_arrow"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    CGRect rt = CGRectMake(x + 5, (self.frame.size.height - img.size.height) / 2, img.size.width, img.size.height);
    imgView.frame = rt;
    [self addSubview:imgView];
}

@end
