//
//  DeviceCapabilityHelper.h
//  AudioJoke
//
//  Created by heyf on 4/13/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    IPHONE_UNKOWN,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_5
}enumIphoneVersion;

@interface DeviceCapabilityHelper : NSObject

+(enumIphoneVersion) getPhoneVersion;

+(BOOL)isDeviceAsIphone;

+(id) createObjectFromClassString:(NSString*) clsName;

+(float)getScreenWidth;
+(float)getScreenHeight;
+(float)getScreenHeightExcludeNavigatorBar;
+(CGSize)getScreenSize;
+(CGRect)getScreenRect;

+ (id)loadCellFromBundle:(NSString *)bundleName andClass:(id)cls;

@end
