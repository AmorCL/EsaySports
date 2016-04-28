//
//  CYWithoutWifiView.m
//  tennisApp
//
//  Created by ESAY on 16/1/3.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYWithoutWifiView.h"

@implementation CYWithoutWifiView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-78, self.frame.size.height/2-60-60, 156, 120)];
        _bgImgView.image = GetImage(@"other_wify");
        _bgImgView.userInteractionEnabled  = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick:)];
        [_bgImgView addGestureRecognizer:tap];
        [self addSubview:_bgImgView];
    }
    return self;
}
-(void)btnClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");
    if ([self.delegate respondsToSelector:@selector(reloadView)]) {
        [self.delegate reloadView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
