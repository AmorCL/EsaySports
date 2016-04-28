//
//  CYMineHeaderView.h
//  esayou
//
//  Created by ESAY on 16/3/24.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYMineHeaderViewDelegate<NSObject>

@optional
-(void)headImageBtned;
-(void)myFocusBtned;
-(void)myFansBtned;
-(void)myPersonalBtned;
-(void)mesageBtned;
-(void)settingBtned;
@end

@interface CYMineHeaderView : UIView
@property(nonatomic,strong)id<CYMineHeaderViewDelegate> delegate;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *focusBtn;
@property(nonatomic,strong)UILabel *focusNum;
@property(nonatomic,strong)UILabel *fansBtn;
@property(nonatomic,strong)UILabel *fansNum;
@property(nonatomic,strong)UILabel *personalBtn;
@property(nonatomic,strong)UIButton *imageBtn;
@property(nonatomic,strong)UIButton *settingBtn;
@property(nonatomic,strong)UIButton *mesageBtn;








@end
