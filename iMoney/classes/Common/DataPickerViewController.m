//
//  DataPickerViewController.m
//  iPregnant
//
//  Created by heyunfei on 14-8-26.
//  Copyright (c) 2014年 muqiapp. All rights reserved.
//

#import "DataPickerViewController.h"

@interface DataPickerViewController (){
    NSString *selectValue;
}
@property(nonatomic,strong)IBOutlet UIButton *btn;
@property(nonatomic,strong)IBOutlet UIButton *cancelBtn;

@end

@implementation DataPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectValue=@"";
     [_btn setTitleColor:[UIColor colorWithRed:(64.0/255.0) green:(177.0/255.0)  blue:(217.0/255.0) alpha:1.0] forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithRed:(64.0/255.0) green:(177.0/255.0)  blue:(217.0/255.0) alpha:1.0] forState:UIControlStateNormal];

    _pick=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 42, 320, 236)];
    _pick.backgroundColor=[UIColor whiteColor];
    _pick.dataSource=self;
    _pick.delegate=self;
    [self.view addSubview:_pick];
    
    if (self.dataSource > 0) {
        selectValue = [self.dataSource objectAtIndex:0];
    }
    
}
-(void)selectFirst{
    selectValue=[self.dataSource objectAtIndex:0];
}


#pragma mark pickerview function

/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource count];
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row];
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // NSLog(@"font %@ is selected.",row);
    selectValue=[self.dataSource objectAtIndex:row];
    NSLog(@"%@",selectValue);
    
}

-(IBAction)okAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(dataSelected:)]){
        [self.delegate dataSelected:selectValue];
    }
}

-(IBAction)cancelAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(dataCancel)]){
        [self.delegate dataCancel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
