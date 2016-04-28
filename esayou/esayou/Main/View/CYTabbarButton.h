//
//  CYTabbarButton.h
//  tennisApp
//
//  Created by ESAY on 15/10/12.
//  Copyright (c) 2015年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTabbarButton : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) void(^btnDidSelected)(NSInteger tag);

- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
              image:(UIImage *)image
      selectedImage:(UIImage *)selectedImage;


@end
