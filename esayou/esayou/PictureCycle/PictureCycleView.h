//
//  PictureCycleView.h
//  Union
//
//  Created by 张展 on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PictureCycleModel.h"

typedef void (^SelectedPictureBlock)(PictureCycleModel *model);

@interface PictureCycleView : UIView

@property (nonatomic , retain) NSMutableArray *dataArray;//数据源数组

@property (nonatomic , assign) NSTimeInterval timeInterval;//轮播时间间隔

@property (nonatomic , assign) BOOL isPicturePlay;//是否播放图片


@property (nonatomic , copy ) SelectedPictureBlock selectedPictureBlock;//选中图片Block

@end
