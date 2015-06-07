//
//  VerticallyAlignedLabel.h
//  AudioJoke
//
//  Created by heyf on 4/14/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

// VerticallyAlignedLabel.h
typedef enum VerticalAlignment{
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
