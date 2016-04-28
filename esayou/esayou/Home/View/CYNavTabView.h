//
//  CYNavTabView.h
//  esayou
//
//  Created by ESAY on 16/3/18.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(NSInteger selectIndex);
@interface CYNavTabView : UIView
@property (nonatomic , retain)NSArray *dataArray;//数据源数组
@property (nonatomic , retain)UIScrollView *scrollView;//滑动视图
@property (nonatomic , retain)UIView *lineView; //下划线视图
@property (nonatomic , assign)NSInteger selectIndex;//选中按钮下标
@property (nonatomic , copy)Block returnIndex;//返回选中的下标

@end
