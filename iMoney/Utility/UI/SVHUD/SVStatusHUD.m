#import "SVStatusHUD.h"
#import <QuartzCore/QuartzCore.h>

#define SVStatusHUDVisibleDuration 2.0f
#define SVStatusHUDFadeOutDuration 2.0f


@interface SVStatusHUD () {
    int messageWidth;
}

@property (nonatomic, retain) NSTimer *fadeOutTimer;
@property (nonatomic, readonly) UIWindow *overlayWindow;
@property (nonatomic, readonly) UIView *hudView;
@property (nonatomic, readonly) UILabel *stringLabel;

- (void)setStatus:(NSString*)string;
- (void)positionHUD:(NSNotification*)notification;
- (void)dismiss;

@end


@implementation SVStatusHUD

@synthesize overlayWindow, hudView, fadeOutTimer, stringLabel;

static SVStatusHUD *sharedView = nil;

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (SVStatusHUD*)sharedView {
	
	if(sharedView == nil)
		sharedView = [[SVStatusHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	return sharedView;
}

#pragma mark - Show Methods

+ (void)showWithStatus:(NSString*)string{
    [[SVStatusHUD sharedView] showWithStatus:string duration:SVStatusHUDVisibleDuration];
}

+ (void)showWithStatusOnTop:(NSString*)string{
    [SVStatusHUD sharedView].bShowOnTop = true;
    [[SVStatusHUD sharedView] showWithStatus:string duration:SVStatusHUDVisibleDuration];
}

#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
        [self.overlayWindow addSubview:self];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
	
    return self;
}

- (void)setStatus:(NSString *)string {
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize fontSize = [string sizeWithFont:font constrainedToSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];

    self.hudView.bounds = CGRectMake(0, 0, fontSize.width + 20, fontSize.height + 20);
    self.stringLabel.frame = CGRectMake(10, 10, fontSize.width, fontSize.height);
		
	self.stringLabel.text = string;
}


- (void)showWithStatus:(NSString *)string duration:(NSTimeInterval)duration {
	   
	[self setStatus:string];
    self.overlayWindow.hidden = NO;
    [self positionHUD:nil];
    
	if(self.alpha != 1)
		self.alpha = 1;
    
	fadeOutTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    
    [self setNeedsDisplay];
}


- (void)positionHUD:(NSNotification*)notification {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
    }
    
    CGFloat activeHeight = orientationFrame.size.height;
    
    CGFloat posY = floor(activeHeight*0.52);
    CGFloat posX = orientationFrame.size.width/2;
    
    if (self.bShowOnTop) {
        posY = 100;
        self.bShowOnTop = NO;
    }
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) { 
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI; 
            newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
            break;
        default: // as UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    } 
    
    self.hudView.transform = CGAffineTransformMakeRotation(rotateAngle); 
    self.hudView.center = newCenter;
}

- (void)dismiss {
	[UIView animateWithDuration:SVStatusHUDFadeOutDuration
						  delay:0
						options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
					 animations:^{	
						 sharedView.alpha = 0;
					 }
					 completion:^(BOOL finished){ 
                         if(sharedView.alpha == 0) {
                             [[NSNotificationCenter defaultCenter] removeObserver:sharedView];                             
                             self.overlayWindow.hidden = YES;
                             
                         }
                     }];
}

#pragma mark - Getters

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
    }
    return overlayWindow;
}

- (UIView *)hudView {
    if(!hudView) {
        hudView = [[UIView alloc] initWithFrame:CGRectZero];
        hudView.layer.cornerRadius = 10;
		hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        hudView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [self addSubview:hudView];
    }
    return hudView;
}

- (UILabel *)stringLabel {
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 123, messageWidth, 20)];
		stringLabel.textColor = [UIColor whiteColor];
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:16];
		stringLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.7];
		stringLabel.shadowOffset = CGSizeMake(1, 1);
        stringLabel.numberOfLines = 0;
		[self.hudView addSubview:stringLabel];
    }
    return stringLabel;
}


@end
