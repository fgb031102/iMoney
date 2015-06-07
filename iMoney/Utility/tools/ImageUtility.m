//
//  UIImage+UIImage_wiRoundedRectImage.m
//  iAsk
//
//  Created by Yongfei He on 14-7-6.
//  Copyright (c) 2014年 jimujiaoyu. All rights reserved.
//

#import "ImageUtility.h"
#import "JMAPIRequest.h"

@implementation ImageUtility

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (UIImage*)createRoundedRectImage:(UIImage*)image
{
    int w = image.size.width;
    int h = image.size.height;
    NSInteger r = 10;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIColor *)createColorWithImage:(UIImage *)image{
    return [UIColor colorWithPatternImage:image];
}

+(CGSize)scaleOneImageWidth2ImageSize:(CGSize)originalSize imageViewSize:(CGSize)imageViewSize{
    float fScaleWidth = originalSize.width / imageViewSize.width;
    float fScale = fScaleWidth > 1.0f ? fScaleWidth : 1.0f;
    float actualWidth = originalSize.width / fScale;
    float actualHeight = originalSize.height / fScale;
    return CGSizeMake(actualWidth, actualHeight);
}

+(CGSize)scaleOneImage2ImageSize:(CGSize)originalSize imageViewSize:(CGSize)imageViewSize{
    float fScaleWidth = originalSize.width / imageViewSize.width;
    float fScaleHeight = originalSize.height / imageViewSize.height;
    float fScale = MAX(fScaleWidth, fScaleHeight) > 1.0f ? MAX(fScaleWidth, fScaleHeight) : 1.0f;
    float actualWidth = originalSize.width / fScale;
    float actualHeight = originalSize.height / fScale;
    return CGSizeMake(actualWidth, actualHeight);
}

+(NSString*)saveImage2Local:(UIImage*)img withUrl:(NSString*)url{
    
    NSString* key = [PublicUtility MD5StringOfString:url];
    
    NSMutableString* downloadsPath = [[NSMutableString alloc] initWithFormat:@"%@",  NSTemporaryDirectory()];
    [downloadsPath appendString:@"Documents/Files/"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:downloadsPath]) {
        //make dir
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadsPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    NSString* fileName = [[NSString alloc] initWithFormat:@"%@%@.%@", downloadsPath, key, [url pathExtension]];
    
    if([UIImagePNGRepresentation(img) writeToFile:fileName atomically:YES])
        return fileName;
    else
        return @"";
}

+(void)downloadImage:(UIView *)imgView withUrl:(NSString*) url{
    if ((id)url == [NSNull null] || [url isEqualToString:@""]) return;
    
    NSDictionary *params = [[NSDictionary alloc] init];
    
    [JMAPIRequest getFileFromPath:url params:params response:^(id data, NSInteger StatusCode) {
        if (StatusCode != -1) {
            if ([imgView isKindOfClass:[UIImageView class]]){
                UIImageView *view = (UIImageView*)imgView;
                UIImage *img = [ImageUtility createRoundedRectImage:[UIImage imageWithContentsOfFile:data]];
                view.image = img;
            }else{
                UIButton *view = (UIButton*)imgView;
                UIImage *img = [ImageUtility createRoundedRectImage:[UIImage imageWithContentsOfFile:data]];
                [view setImage:img forState:UIControlStateNormal];
            }
        }
    }];
}

+(void)downloadImagewithUrl:(NSString*)url backFunc:(dataParseDataCallBackBlock)back{
    if ((id)url == [NSNull null] || [url isEqualToString:@""]) return;
    NSDictionary *params = [[NSDictionary alloc] init];
    
    [JMAPIRequest getFileFromPath:url params:params response:^(id data, NSInteger StatusCode) {
        if (StatusCode != -1) {
            back(data, StatusCode);
        }
    }];
}

@end
