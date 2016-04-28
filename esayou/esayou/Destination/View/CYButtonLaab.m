//
//  CYButtonLaab.m
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYButtonLaab.h"

@implementation CYButtonLaab
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{

    CGFloat height = (self.frame.size.height - 20)*0.5;
    
    _topImageView = [UIImageView new];
    _topImageView.layer.cornerRadius = self.frame.size.width/2;
    _topImageView.clipsToBounds = YES;
    _topImageView.backgroundColor = GetColor(redColor);
//    _topImageView.alpha = 0.9;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnTap:)];
    _topImageView.userInteractionEnabled = YES;
    [_topImageView addGestureRecognizer:tap];
    [self addSubview:_topImageView];
    
    _bottomLab = [UILabel new];
//    _bottomLab.alpha = 0.9;
    _bottomLab.adjustsFontSizeToFitWidth = YES;
    _bottomLab.textAlignment = NSTextAlignmentCenter;
//    [_bottomLab sizeToFit];
    _bottomLab.font = GetFont(12);
    _bottomLab.textColor = GetColor(whiteColor);
    _bottomLab.backgroundColor = GetColor(clearColor);
    _bottomLab.userInteractionEnabled = YES;
//    [_bottomLab addGestureRecognizer:tap];
    [self addSubview:_bottomLab];
    
    _bottomLab.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(20);
    
    _topImageView.sd_layout
    .topEqualToView(self)
    .bottomSpaceToView(_bottomLab,0)
    .centerXEqualToView(_bottomLab)
    .widthIs(height*2);
    
    
}
-(void)btnTap:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了");
    if ([self.delegate respondsToSelector:@selector(buttonIsBtned:)]) {
        [self.delegate buttonIsBtned:self.tag];
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
