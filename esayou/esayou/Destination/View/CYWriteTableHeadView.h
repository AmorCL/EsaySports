//
//  CYWriteTableHeadView.h
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYButtonLaab.h"
@protocol CYWriteTableHeadViewDelegate<NSObject>

@optional
-(void)chooseType:(NSInteger )tag;
-(void)writeTravelNotsNow;
@end
@interface CYWriteTableHeadView : UIView<CYButtonLaabDelegata>
@property(nonatomic,strong)UIImageView *bagroundImageView;
@property(nonatomic,strong)UILabel *topBigLab;
@property(nonatomic,strong)CYButtonLaab *buttonLab;
@property(nonatomic,strong)UIButton *writeBtn;

@property(nonatomic,strong)NSMutableArray *datasArray;
@property(nonatomic,weak)id<CYWriteTableHeadViewDelegate> delegate;

@end
