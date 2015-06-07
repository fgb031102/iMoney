#import <UIKit/UIKit.h>

@interface SVStatusHUD : UIView{    
}
@property BOOL bShowOnTop;

+ (void)showWithStatus:(NSString*)string;
+ (void)showWithStatusOnTop:(NSString*)string;
@end
