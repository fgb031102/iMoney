//
//  ImageUtility.h
//  
//
//  Created by Yongfei He on 14-7-6.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtility : NSObject

+ (UIImage*)createRoundedRectImage:(UIImage*)image;
+(CGSize)scaleOneImageWidth2ImageSize:(CGSize)originalSize imageViewSize:(CGSize)imageViewSize;
+(CGSize)scaleOneImage2ImageSize:(CGSize)originalSize imageViewSize:(CGSize)imageViewSize;
+(NSString*)saveImage2Local:(UIImage*)img withUrl:(NSString*)url;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIColor *)createColorWithImage:(UIImage *)image;
+(void)downloadImage:(UIView *)imgView withUrl:(NSString*)url;
+(void)downloadImagewithUrl:(NSString*)url backFunc:(dataParseDataCallBackBlock)back;

@end
