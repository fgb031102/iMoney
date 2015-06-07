
#import <Foundation/Foundation.h>

@interface ShowAllImage: NSObject{
}

+ (void)ShowAllImage:(NSString*)pic_group_id;

+ (void)ShowImage:(NSArray*)imageArray index:(NSInteger)index;

@end
