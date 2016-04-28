//
//  CYButtonLaab.h
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYButtonLaabDelegata<NSObject>

@optional
-(void)buttonIsBtned:(NSInteger )tag;
@end
@interface CYButtonLaab : UIView
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)id<CYButtonLaabDelegata> delegate;


@end
