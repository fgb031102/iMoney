//
//  DataPickerViewController.h
//  iPregnant
//
//  Created by heyunfei on 14-8-26.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DataPickerViewControllerDelegate;
@interface DataPickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>


-(IBAction)okAction:(id)sender;
@property(nonatomic,assign)id<DataPickerViewControllerDelegate> delegate;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong)IBOutlet UIPickerView *pick;

-(void)selectFirst;

@end

@protocol DataPickerViewControllerDelegate <NSObject>
-(void)dataSelected:(NSString*)data;
-(void)dataCancel;
@end