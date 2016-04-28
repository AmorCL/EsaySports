//
//  CYWithoutWifiView.h
//  tennisApp
//
//  Created by ESAY on 16/1/3.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYWithoutWifiView;
@protocol CYWithoutWifiViewdelegate <NSObject>

@optional
-(void)reloadView;

@end
@interface CYWithoutWifiView : UIView
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,weak)id delegate;

@end
