//
//  PublicUtility.h
//  AudioJoke
//
//  Created by heyf on 4/5/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPiFlatSegmentedControl.h"

@interface PublicUtility : NSObject

+(NSString*) getNowSecond;
+(NSString*) getNowMintue;
+(NSString*) getNowHour;
+(NSString*) MD5StringOfString:(NSString*) inputStr;

//time
+(NSString*) convertDate2ReadableString:(NSDate*)datetime;
+(NSString*) convertDate2ShortReadableString:(NSDate*)datetime;
+(NSString*) convertTime2ReadableString:(long long)time;
+(NSString*) convertDate2ReadableDayString:(NSDate*)datetime;
+(NSString*)convertDate2ReadableMonthString:(NSDate*)datetime;

//local date and UTC
+(NSDate *)convertUTC2Local:(NSDate *)utcDate;
+(NSDate *)convertLocal2UTC:(NSDate *)localDate;
+(NSString*)convertLocalDateString2UTCDateString:(NSString*)strLocalDate;

//uuid
+(NSString*) generateUID;

//network
+(BOOL) handleNetworkRet:(id) data Status:(NSInteger) statusCode;
+(BOOL) handleNetworkwithNoPromptRet:(id) data Status:(NSInteger) statusCode;

//image

//validate
+(BOOL)CheckPhoneNumInput:(NSString *)_text;
+(BOOL)CheckValidateEmail:(NSString *)email;

//text height
+(CGFloat) getTextLabelHeightByText:(NSString*) content width:(NSInteger)width fontSize:(NSInteger)fontsize;
+(CGSize)getOccupySizeString:(NSString*)str size:(CGSize)size;

//activity indicator
+(void) showActivityIndicatorFullScreen;
+(void) hideActivityIndicatorFullScreen;

+(BOOL)isFirstUseApp;
+(void)setFirstUseApp;

//json and dictionary
+(NSString*)dictionary2Base64jsonString:(NSDictionary*)dict;
+(NSString*)dictionary2jsonString:(NSDictionary*)dict;
+(NSDictionary*)base64JsonString2Dictionary:(NSString*)json;
+(NSDictionary*)jsonString2Dictionary:(NSString*)json;

//ios6 7
+(CGRect) ios_6_7_frame:(CGRect) rt;
+(void)setupNavgatorbar:(UIViewController*)ctrl;
+(void)setupNavgatorbar:(UIViewController*)ctrl back_action:(SEL)action;

//add control
+(UILabel*)addOneLabelWithText:(NSString*)text rect:(CGRect)frame;
+(UIImageView*)addOneImageWithRect:(CGRect)frame;
+(UITextField*)addOneTextFieldWithPlaceHolder:(NSString*)placeHolder rect:(CGRect)frame;
+(UISwitch*)addOneSwitchWithValue:(BOOL)bValue rect:(CGRect)frame;
+(PPiFlatSegmentedControl*)addOneSegmentWithTextArray:(NSArray*)textArray selectIndex:(NSInteger)index rect:(CGRect)frame;

//color
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
@end
