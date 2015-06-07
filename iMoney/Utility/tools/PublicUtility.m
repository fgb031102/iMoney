//
//  PublicUtility.m
//  AudioJoke
//
//  Created by heyf on 4/5/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import "PublicUtility.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#import "SqliteManager.h"
#import "DeviceCapabilityHelper.h"
#import "JMAPIRequest.h"
#import "SecurityUtil.h"

@implementation PublicUtility

static UIWindow *keyWindow = nil;

+ (UIWindow *)keyWindow {
    return [[UIApplication sharedApplication] keyWindow];
}

+(void) showActivityIndicatorFullScreen{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DeviceCapabilityHelper getScreenWidth], [UIScreen mainScreen].bounds.size.height)];
    [view setTag:110399];
    view.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.2];
    keyWindow = [self keyWindow];
    [keyWindow addSubview:view];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(160.0f - 16.0f, [UIScreen mainScreen].bounds.size.height / 2 - 16.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator startAnimating];
    [view addSubview:activityIndicator];
}

+(void) hideActivityIndicatorFullScreen{
    UIView *view = [keyWindow viewWithTag:110399];
    [view removeFromSuperview];
}

+(BOOL)isFirstUseApp{
    SqliteManager *sql = [SqliteManager shareManager];
    return [sql querySystemTableWithKey:@"firstUserApp"] == nil;
}

+(void)setFirstUseApp{
    SqliteManager *sql = [SqliteManager shareManager];
    [sql updateSystemTableWithKey:@"firstUserApp" Value:@"yes"];
}

+(NSString*)getNowSecond{
    NSDateFormatter *customDateFormatter = [[NSDateFormatter alloc] init];
    [customDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [customDateFormatter stringFromDate:[NSDate date]];
}

+(NSString*) getNowMintue {
    NSDateFormatter *customDateFormatter = [[NSDateFormatter alloc] init];
    [customDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [customDateFormatter stringFromDate:[NSDate date]];
}

+(NSString*) getNowHour {
    NSDateFormatter *customDateFormatter = [[NSDateFormatter alloc] init];
    [customDateFormatter setDateFormat:@"yyyyMMddHH"];
    return [customDateFormatter stringFromDate:[NSDate date]];
}

+(NSString*) MD5StringOfString:(NSString*) inputStr
{
	NSData* inputData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char outputData[CC_MD5_DIGEST_LENGTH];
	CC_MD5([inputData bytes], (CC_LONG)[inputData length], outputData);
    
	NSMutableString* hashStr = [NSMutableString string];
	int i = 0;
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
		[hashStr appendFormat:@"%02x", outputData[i]];
    
	return hashStr;
}

+(NSString*) convertDate2ReadableString:(NSDate*)datetime{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *str = [_dateFormatter stringFromDate:datetime];
    return str ? str : @"";
}

+(NSString*) convertDate2ShortReadableString:(NSDate*)datetime{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *str = [_dateFormatter stringFromDate:datetime];
    return str ? str : @"";
}

+(NSString*)convertDate2ReadableDayString:(NSDate*)datetime{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *str = [_dateFormatter stringFromDate:datetime];
    return str ? str : @"";
}

+(NSString*)convertDate2ReadableMonthString:(NSDate*)datetime{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-00"];
    
    NSString *str = [_dateFormatter stringFromDate:datetime];
    return str ? str : @"";
}


+(NSString*)convertTime2ReadableString:(long long)time{
    NSDate *datenow = [NSDate date];
    float interval = datenow.timeIntervalSince1970 - time ;

    if (interval < 60)
        return @"刚刚";
    else if(interval < 60 * 60)
        return [NSString stringWithFormat:@"%lld分钟前", (long long)interval/60];
    else if(interval < 24 * 60 * 60)
        return [NSString stringWithFormat:@"%lld小时前", (long long)interval/(60 * 60)];
    else if(interval < 30 * 24 * 60 * 60)
        return [NSString stringWithFormat:@"%lld天前", (long long)interval/(24 * 60 * 60)];
    else if(interval < 12 * 30 * 24 * 60 * 60)
        return [NSString stringWithFormat:@"%lld月前", (long long)interval/(30 * 24 * 60 * 60)];
    else if(interval < 10 * 12 * 30 * 24 * 60 * 60)
        return [NSString stringWithFormat:@"%lld年前", (long long)interval/(12 * 30 * 24 * 60 * 60)];
    else
        return @"很久前";
}

+(NSDate *)convertUTC2Local:(NSDate *)utcDate
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:utcDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:utcDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:utcDate];
    return destinationDateNow;
}

+(NSDate *)convertLocal2UTC:(NSDate *)localDate
{
    NSTimeZone* sourceTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:localDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:localDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:localDate];
    return destinationDateNow;
}

+(NSString*)convertLocalDateString2UTCDateString:(NSString*)strLocalDate{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *_date = [_dateFormatter dateFromString:strLocalDate];
    NSDate *utcDate = [PublicUtility convertLocal2UTC:_date];
    
    NSString *strUTCDate = [_dateFormatter stringFromDate:utcDate];
    return strUTCDate ? strUTCDate : @"";
}


+(NSString*) convertCurrencyId2String:(NSInteger)cid{
    if (cid == 1) {
        return @"$";
    }else if(cid == 86){
        return @"￥";
    }
    
    return @"";
}

//+(NSString*) generateUID{
//    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    return [NSString stringWithFormat:@"%ld_%ld_%d", (long)app.loginUser.user_id, time(NULL), arc4random() % 1000000];
//}

+(BOOL) handleNetworkRet:(id) data Status:(NSInteger) statusCode{
    if (statusCode == -1 || data == nil) {
        [SVStatusHUD showWithStatus:@"请求发送失败"];
        return FALSE;
    }else{
        if ([[data objectForKey:@"errcode"] intValue] != 0) {
            NSLog(@"%@", [data objectForKey:@"errdesc"]);
            return FALSE;
        }
    }
    
    return TRUE;
}

+(BOOL) handleNetworkwithNoPromptRet:(id) data Status:(NSInteger) statusCode{
    if (statusCode == -1 || !data) {
        //[SVStatusHUD showWithImage:nil status:@"网络不给力" duration:10];
        return FALSE;
    }else{
        if ([[data objectForKey:@"errcode"] intValue] != 0) {
            NSLog(@"%@", [data objectForKey:@"errdesc"]);
            return FALSE;
        }
    }
    return TRUE;
}

+(BOOL)CheckPhoneNumInput:(NSString *)_text{
    NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:_text];
}

+(BOOL)CheckValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(CGFloat) getTextLabelHeightByText:(NSString*) content width:(NSInteger)width fontSize:(NSInteger)fontsize{
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(width, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}

+ (NSString*)encodeURL:(NSString *)string
{
    NSString *base64 = [SecurityUtil encodeBase64String:string];
    return [base64 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
}

+ (NSString*)decodeURL:(NSString *)string
{
    NSString *str= [string stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    return [SecurityUtil decodeBase64String:str];
}

+(NSString*)dictionary2Base64jsonString:(NSDictionary*)dict{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self encodeURL:json];
}

+(NSString*)dictionary2jsonString:(NSDictionary*)dict{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSDictionary*)jsonString2Dictionary:(NSString*)json{
    NSError * jsonError;
                
    id obj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    
    return obj;
}

+(NSDictionary*)base64JsonString2Dictionary:(NSString*)json{
    NSString *decode64str = [self decodeURL:json];
    NSError * jsonError;
    
    id obj = [NSJSONSerialization JSONObjectWithData:[decode64str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    
    return obj;
}

+(CGRect) ios_6_7_frame:(CGRect) rt{
    if (IOS_7) {
        rt.origin.y += 20;
    }
    
    return rt;
}

+(void)setupNavgatorbar:(UIViewController*)ctrl{
    if(IOS_7){
        [ctrl.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bj"] forBarMetrics:UIBarMetricsDefault];
        ctrl.navigationController.navigationBar.translucent = NO;
        ctrl.extendedLayoutIncludesOpaqueBars = YES;
        ctrl.edgesForExtendedLayout = UIRectEdgeNone;
    }else{
        [ctrl.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bj_20"] forBarMetrics:UIBarMetricsDefault];
        ctrl.navigationController.navigationBar.translucent = NO;
    }
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    ctrl.navigationController.navigationBar.titleTextAttributes = dict;
    
    [[NSNotificationCenter defaultCenter] addObserver:ctrl selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
}

-(void)changeLanguage{
    
}

+(void)setupNavgatorbar:(UIViewController*)ctrl back_action:(SEL)action{
    [PublicUtility setupNavgatorbar:ctrl];
    UIImage* imgBack = [UIImage imageNamed:@"public_ico_leftarrow.png"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:imgBack forState:UIControlStateNormal];
    [backBtn addTarget:ctrl action:action forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    ctrl.navigationItem.leftBarButtonItem = backBtnItem;
}

+(void)drawUserLevelInView:(UIView*)view level:(NSInteger)level{
    for (int i = 0; i < level; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_level_star"]];
        imgView.frame = CGRectMake(i * (imgView.image.size.width + 2), 2, imgView.image.size.width, imgView.image.size.height);
        [view addSubview:imgView];
    }
}

+(CGSize)getOccupySizeString:(NSString*)str size:(CGSize)size{
    return [str sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
}


+(UIImage*)getServiceDefaultImage:(SERVICE_TYPE)service_type{
   NSArray *publishItemArray = [[NSArray alloc] initWithObjects:
                        @"homepage_service_guide",
                        @"homepage_service_route",
                        @"homepage_service_strategy",
                        @"homepage_service_company",
                        @"homepage_service_car",
                        @"homepage_service_visa",
                        @"homepage_service_ticket",
                        @"homepage_service_restaurant",
                        @"homepage_service_hotel",
                        @"homepage_service_club",
                        nil];
    if(service_type - 1 < publishItemArray.count)
        return [UIImage imageNamed:publishItemArray[service_type - 1]];
    else
        return nil;
}

+(void)drawUserTagsInView:(UIView*)view tags:(NSString*)tags{
    NSArray *tagArray = [tags componentsSeparatedByString:@","];
    float left = 2;
    for (int i = 0; i < tagArray.count; i++) {
        if ([tagArray[i] isEqualToString:@""])
            continue;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        btn.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:166.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
        [btn setTitle:tagArray[i] forState:UIControlStateNormal];
        CGSize size = [PublicUtility getOccupySizeString:tagArray[i] size:CGSizeMake(80, 18)];
        btn.frame = CGRectMake(left, 0, size.width + 10, 25);
        [view addSubview:btn];
        left += size.width + 15;
    }
}


+(UILabel*)addOneLabelWithText:(NSString*)text rect:(CGRect)frame{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textColor = [UIColor lightGrayColor];
    label.frame = frame;
    label.minimumScaleFactor = 0.2;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

+(UISwitch*)addOneSwitchWithValue:(BOOL)bValue rect:(CGRect)frame{
    UISwitch *us = [[UISwitch alloc] init];
    us.on = bValue;
    us.frame = frame;
    return us;
}

+(PPiFlatSegmentedControl*)addOneSegmentWithTextArray:(NSArray*)textArray selectIndex:(NSInteger)index rect:(CGRect)frame{
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    for (NSString *item in textArray)
        [itemArray addObject:@{@"text":item}];
    PPiFlatSegmentedControl *segmentViewCtrl =
    segmentViewCtrl = [[PPiFlatSegmentedControl alloc] initWithFrame:frame items:itemArray iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
    }];
    
    segmentViewCtrl.color = [UIColor whiteColor];
    segmentViewCtrl.borderWidth = 0.5;
    segmentViewCtrl.borderColor = [UIColor colorWithRed:24.0f/255.0 green:177.0f/255.0 blue:245.0f/255.0 alpha:1];
    segmentViewCtrl.selectedColor = [UIColor colorWithRed:24.0f/255.0 green:177.0f/255.0 blue:245.0f/255.0 alpha:1];
    segmentViewCtrl.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmentViewCtrl.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithRed:24.0f/255.0 green:177.0f/255.0 blue:245.0f/255.0 alpha:1]};
    segmentViewCtrl.selectedSegmentIndex = index;
    
    return segmentViewCtrl;
}

+(UITextField*)addOneTextFieldWithPlaceHolder:(NSString*)placeHolder rect:(CGRect)frame {
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeHolder;
    tf.frame = frame;
    return tf;
}

+(UIImageView*)addOneImageWithRect:(CGRect)frame{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = frame;
    return imgView;
}

+(UIImage*)getUserHeaderByType:(USER_TYPE)user_type{
    if (user_type == TRAVEL_AGENCY) {
        return [ImageUtility createRoundedRectImage:[UIImage imageNamed:@"travel_normal_default"]];
    }else if(user_type == TOURIST){
        return [ImageUtility createRoundedRectImage:[UIImage imageNamed:@"photo_normal"]];
    }else
        return [ImageUtility createRoundedRectImage:[UIImage imageNamed:@"daoyou_normal_default"]];
}
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
