//
//  CYTextView.m
//  tennisApp
//
//  Created by ESAY on 16/1/14.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYTextView.h"

@implementation CYTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return  self;
}
-(void)creatUI{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithRed:76./255. green:75./255. blue:71./255. alpha:1]};
    self.attributedText = [[NSAttributedString alloc]initWithString:self.text attributes:attributes];

    _lable = [QuickControl labelWithFrame:CGRectMake(20, 10, self.frame.size.width-40, 20) title:nil tag:0];
    _lable.textAlignment = NSTextAlignmentLeft;
    _lable.font = GetFont(16);
    _lable.textColor = RGBAlpha(0, 0, 0, 0.4);
    [self addSubview:_lable];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
