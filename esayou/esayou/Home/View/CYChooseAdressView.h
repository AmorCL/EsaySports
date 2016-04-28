//
//  CYChooseAdressView.h
//  esayou
//
//  Created by ESAY on 16/4/25.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYChooseAdressViewDelegate <NSObject>
@optional
-(void)chooseAdressNow;
@end

@interface CYChooseAdressView : UIView
@property(nonatomic,strong)UIImageView *leftImgView;
@property(nonatomic,strong)UITextField *textFiled;
@property(nonatomic,strong)UIImageView *rightImgView;
@property(nonatomic,strong)id<CYChooseAdressViewDelegate> delegate;



@end
