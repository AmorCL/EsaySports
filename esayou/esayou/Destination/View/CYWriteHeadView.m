//
//  CYWriteHeadView.m
//  esayou
//
//  Created by ESAY on 16/3/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYWriteHeadView.h"


@implementation CYWriteHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.bgView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:self.bgView];
    
    self.title = [[UITextField alloc]initWithFrame:CGRectMake(40, self.frame.size.height/2-15, self.frame.size.width-60, 30)];
    self.title.placeholder = @"点击编辑标题 (30个字以内)";
    
    [self addSubview:self.title];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
