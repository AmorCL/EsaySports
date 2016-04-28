//
//  CYTabbar.h
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYTabBarDelegate <NSObject>

- (void)tabBarDidSelected:(NSInteger)index;

@end

@interface CYTabbar : UIView
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, assign) id<CYTabBarDelegate>delegate;

@end
