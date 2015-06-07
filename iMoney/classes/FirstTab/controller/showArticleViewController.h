//
//  showArticleViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-2.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"
#import "ArticleModel.h"

@interface showArticleViewController : BaseViewController
{
    ArticleModel *anArticle;
}

-(id)initWithArticle:(ArticleModel *)article;


@end
