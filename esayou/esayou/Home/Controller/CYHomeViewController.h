//
//  CYHomeViewController.h
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYRootViewController.h"
@interface CYHomeViewController : CYRootViewController<UIScrollViewDelegate>
//小的滑动视图
@property (nonatomic,weak) UIScrollView *smallScroll;
//大的滑动视图
@property (nonatomic,weak) UIScrollView *bigScroll;

@end
