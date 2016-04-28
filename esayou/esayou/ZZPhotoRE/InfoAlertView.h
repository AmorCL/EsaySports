//
//  InfoAlertView.h
//  mcare-ui
//
//  Created by sam on 12-10-11.
//
//

#import "MBProgressHUD.h"
//#import "XBSettingCell.h"
@interface ProgressHUD2 : MBProgressHUD {
    
}

@end

@interface InfoAlertView : NSObject {
    ProgressHUD2 *hud;
}

+ (void)setInView:(UIView *)view;
+ (void)showInfo:(NSString *)info duration:(CGFloat)duration;
+ (void)showInfo:(NSString *)info inView:(UIView *)inView duration:(CGFloat)duration;

@end
