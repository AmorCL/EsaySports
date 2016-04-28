//
//  CYTitleLabView.m
//  esayou
//
//  Created by ESAY on 16/3/30.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYTitleLabView.h"
@implementation CYTitleLabView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI:frame];
    }
    return self;
}
-(void)creatUI:(CGRect)frame{
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-4)];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = GetColor(lightGrayColor);
    self.titleLab.font = [UIFont systemFontOfSize:18];
    
    [self addSubview:self.titleLab];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(self.titleLab.x, frame.size.height - 2 -1, self.titleLab.width, 2)];
    self.lineView.backgroundColor = GetColor(lightGrayColor);
    [self addSubview:self.lineView];
    self.scale = 0.0;
}
/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.titleLab.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:scale alpha:1];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:scale alpha:1];

    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.titleLab.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    
    self.lineView.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
