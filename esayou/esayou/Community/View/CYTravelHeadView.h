//
//  CYTravelHeadView.h
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureCycleView.h"
#import "CYButtonLaab.h"
#import "CYSearchBar.h"
@protocol CYTravelHeadViewDelegate<NSObject>

@optional
-(void)chooseTypeOfBall:(NSInteger )tag;
-(void)startMyOrder;
-(void)searchBegain;
@end
@interface CYTravelHeadView : UIView<CYButtonLaabDelegata,UITextFieldDelegate>
@property(nonatomic,strong)id<CYTravelHeadViewDelegate> delegate;
@property(nonatomic,strong)PictureCycleView *adsCycleView;
@property(nonatomic,strong)CYButtonLaab *buttonLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)CYSearchBar *searchBtn;

@property(nonatomic,strong)NSMutableArray *datasArray;



@end
