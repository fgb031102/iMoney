//
//  ShowProductViewController.h
//  IQPlatform
//
//  Created by hulin on 15-1-3.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductModel.h"

@interface ShowProductViewController : BaseViewController
{
    ProductModel *aProduct;
}

-(id)initWithProduct:(ProductModel *)product;

@end
