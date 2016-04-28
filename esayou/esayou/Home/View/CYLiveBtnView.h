//
//  CYLiveBtnView.h
//  esayou
//
//  Created by ESAY on 16/4/13.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYLiveBtnViewDelagete<NSObject>

@optional
-(void)liveBtned:(NSInteger )tag;
@end
@interface CYLiveBtnView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)id<CYLiveBtnViewDelagete> delegate;


@end
