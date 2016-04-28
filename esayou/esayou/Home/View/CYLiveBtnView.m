//
//  CYLiveBtnView.m
//  esayou
//
//  Created by ESAY on 16/4/13.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYLiveBtnView.h"

@implementation CYLiveBtnView
-(instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    view.backgroundColor = GetColor(clearColor);
    [self addSubview:view];
    self.imageView = [UIImageView new];
    self.imageView.layer.cornerRadius = self.frame.size.height/2;
    self.imageView.clipsToBounds = YES;
    [view addSubview:self.imageView];
    
    self.lable = [UILabel new];
    self.lable.textAlignment = NSTextAlignmentCenter;
//    self.lable.textColor = GetColor(yellowColor);
    self.lable.font = GetFont(12);
    [view addSubview:self.lable];
    
    _imageView.sd_layout
    .leftEqualToView(view)
    .topEqualToView(view)
    .widthIs(view.height)
    .heightIs(view.height);
    
    _lable.sd_layout
    .leftSpaceToView(_imageView,5)
    .centerYEqualToView(_imageView)
    .heightIs(20)
    .widthIs(30);
    [_lable setSingleLineAutoResizeWithMaxWidth:(view.width-_imageView.width-10)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(isTaped)];
    [view addGestureRecognizer:tap];
    
    
}
-(void)isTaped{
    if ([self.delegate respondsToSelector:@selector(liveBtned:)]) {
        [self.delegate liveBtned:self.tag];
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
