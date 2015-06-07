//
//  ShowAllImageViewController.m
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-28.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import "ShowAllImage.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation ShowAllImage

//+ (void)ShowAllImage:(NSString*)pic_group_id
//{
//    MainPictureModel *pictureList = [[MainPictureModel alloc] init];
//    [pictureList getPicturePathArrayByGroupID:pic_group_id backFunc:^(NSInteger statusCode) {
//        if (statusCode != -1) {
//            NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [pictureList.dataArray count]];
//            for (int i = 0; i < [pictureList.dataArray count]; i++) {
//                MainPictureItemModel *item = pictureList.dataArray[i];
//                MJPhoto *photo = [[MJPhoto alloc] init];
//                photo.url = [NSURL URLWithString:item.path];
//                [photos addObject:photo];
//            }
//            
//            if (pictureList.dataArray.count != 0) {
//                MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//                browser.currentPhotoIndex = 0;
//                browser.photos = photos;
//                [browser show];
//           }
//            
//        }
//    }];
//}

+(void)ShowImage:(NSArray*)imageArray index:(NSInteger)index{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for (int i = 0; i < [imageArray count]; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image = imageArray[i];
        [photos addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index;
    browser.photos = photos;
    [browser show];
}

@end
