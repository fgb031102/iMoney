//
//  IQArticleViewController.h
//  iPregnant
//
//  Created by heyunfei on 14-12-28.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import "PersonModel.h"
#import "InstitutionModel.h"
#import "ImagePlayerView.h"
#import "SDImageView+SDWebCache.h"
@interface IQArticleViewController : BaseViewController<UINavigationControllerDelegate,UITableViewDataSource, UITableViewDelegate,UITextViewDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,ImagePlayerViewDelegate>
{
    ArticleModel *articleData;
    PersonModel *personData;
    InstitutionModel *institutionData;
}

@property (strong, nonatomic) UITableView *itemsTableView;
@property (strong, nonatomic) ImagePlayerView *imagePlayerView;
@property (strong, nonatomic) NSArray *imageURLs;

@end
