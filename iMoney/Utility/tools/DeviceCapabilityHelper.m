//
//  DeviceCapabilityHelper.m
//  AudioJoke
//
//  Created by heyf on 4/13/13.
//  Copyright (c) 2013 jimujiaoyu. All rights reserved.
//

#import "DeviceCapabilityHelper.h"
#import <sys/utsname.h>

@implementation DeviceCapabilityHelper

+(enumIphoneVersion) getPhoneVersion{
    struct utsname u;
    uname(&u);
    NSString *machine = [NSString stringWithFormat:@"%s", u.machine];
    
    if ([machine isEqualToString:@"iPhone5,2"])
        return IPHONE_5;
    if ([machine isEqualToString:@"iPhone4,1"])
        return IPHONE_4;
    else 
        return IPHONE_3GS;
}

+ (id)loadCellFromBundle:(NSString *)bundleName andClass:(id)cls {
    NSMutableString *clsBundleName = [[NSMutableString alloc] initWithFormat:@"%@", bundleName];
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:clsBundleName owner:nil options:nil];
    
    for(id currentObject in topLevelObjects) {
        if([currentObject isKindOfClass:cls]){
            return currentObject;
        }
    }
    return nil;
}

+(id) createObjectFromClassString:(NSString*) clsName{
    if ([DeviceCapabilityHelper isDeviceAsIphone])
        return [[NSClassFromString(clsName) alloc] init];
    else{
        NSString *string_ipad = [clsName stringByAppendingString:@"_ipad"];
        return [[NSClassFromString(clsName) alloc] initWithNibName:string_ipad bundle:nil];
    }
}

+(BOOL)isDeviceAsIphone{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+(float)getScreenWidth{
    return [[UIScreen mainScreen] bounds].size.width;
}

+(float)getScreenHeight{
    return [[UIScreen mainScreen] bounds].size.height;
}

+(float)getScreenHeightExcludeNavigatorBar{
    float navBarHeight = [[UINavigationController alloc] init].navigationBar.frame.size.height;
    return [[UIScreen mainScreen] applicationFrame].size.height - navBarHeight;
}

+(CGSize)getScreenSize{
    return [[UIScreen mainScreen] bounds].size;
}

+(CGRect)getScreenRect{
    return [[UIScreen mainScreen] bounds];
}


@end
