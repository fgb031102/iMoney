//
//  TopMessageView.m
//  AudioJoke
//
//  Created by Yongfei He on 5/22/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import "TopMessageView.h"

@implementation TopMessageView{
    UILabel *stringLabel;
    NSTimer *timer1;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:72.0f/255.0f blue:49.0f/255.0f alpha:0.9f];
//        self.layer.cornerRadius = 3;
        self.hidden = YES;
    }
    return self;
}

-(void)showView{
    [UIView animateWithDuration:0.7
                     animations:^{
                         self.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         self.hidden = NO;
                     }
     ];
}

-(void)hideView{
    [UIView animateWithDuration:0.7
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.hidden = YES;
                     }
     ];
}

-(void)dissmissFromSuperView{
    [self removeFromSuperview];
}

-(void)updateStatus:(NSString*)_status{
	self.stringLabel.text = _status;

    UIFont *font = [UIFont boldSystemFontOfSize:12];
    CGSize fontSize = [_status sizeWithFont:font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    self.stringLabel.frame = CGRectMake(self.frame.size.width / 2 - fontSize.width / 2, 5, fontSize.width, fontSize.height);
    
    CGRect rt = self.frame;
    rt.size.height = fontSize.height + 10;
    self.frame = rt;
    
    if (![_status isEqualToString:@""])
        [self showView];
}

+(TopMessageView*) getOneTopViewWithStatus:(NSString*)_status origin:(CGPoint)origin inView:(UIView*) inView{
    CGRect rt = CGRectMake(origin.x, origin.y, [UIScreen mainScreen].bounds.size.width - 10, 0);
    TopMessageView *view = [[TopMessageView alloc] initWithFrame:rt];
//    [[view layer] setShadowOffset:CGSizeMake(2, 2)];
//    [[view layer] setShadowRadius:2];
//    [[view layer] setShadowOpacity:0.5];
//    [[view layer] setShadowColor:[UIColor blackColor].CGColor];
    [view updateStatus:_status];
    [inView addSubview:view];
    [inView bringSubviewToFront:view];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(clickMsgButton)];
    [view addGestureRecognizer:tap1];
    return view;
}

-(void)clickMsgButton{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTopMsgButton:)])
        [self.delegate clickTopMsgButton:self];
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		stringLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:12];
        stringLabel.numberOfLines = 0;
		[self addSubview:stringLabel];
    }
    return stringLabel;
}

@end
