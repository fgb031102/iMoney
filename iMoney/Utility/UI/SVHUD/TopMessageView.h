//
//  TopMessageView.h
//  AudioJoke
//
//  Created by Yongfei He on 5/22/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopMessageViewDelegate <NSObject>

@optional
- (void)clickTopMsgButton:(id)sender;
@end

@interface TopMessageView : UIView

@property id<TopMessageViewDelegate> delegate;

-(void)showView;
-(void)hideView;
-(void)updateStatus:(NSString*)_status;

+(TopMessageView*) getOneTopViewWithStatus:(NSString*)_status origin:(CGPoint)origin inView:(UIView*) inView;

@end
