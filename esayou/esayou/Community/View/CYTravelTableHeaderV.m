//
//  CYTravelTableHeaderV.m
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYTravelTableHeaderV.h"
@interface CYTravelTableHeaderV()

@end
@implementation CYTravelTableHeaderV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.leftImageView = [UIImageView new];
    _leftImageView.backgroundColor = GetColor(clearColor);
    _leftImageView.image = GetImage(@"live_icon_fire");
    [self addSubview:_leftImageView];
    
    self.midLab = [UILabel new];
    _midLab.textColor = GetColor(lightGrayColor);
    _midLab.textAlignment = NSTextAlignmentCenter;
    _midLab.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_midLab];
    
    _midLab.sd_layout
    .centerXEqualToView(self)
    .widthIs(80)
    .heightIs(self.frame.size.height);
    
    _leftImageView.sd_layout
    .rightSpaceToView(_midLab,5)
    .centerYEqualToView(_midLab)
    .widthIs(20)
    .heightIs(20);

    [_midLab setSingleLineAutoResizeWithMaxWidth:100];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
