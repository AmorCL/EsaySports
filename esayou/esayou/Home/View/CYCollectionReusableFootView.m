//
//  CYCollectionReusableFootView.m
//  esayou
//
//  Created by ESAY on 16/4/20.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYCollectionReusableFootView.h"

@implementation CYCollectionReusableFootView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    _addBtn = [UIButton new];
    [_addBtn setBackgroundImage:GetImage(@"live_btn_add(1)") forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.backgroundColor = GetColor(whiteColor);
    _addBtn.frame = CGRectMake(0, 10, self.width, self.width);
    [self addSubview:_addBtn];
    
}
-(void)addImage{
    NSLog(@"dianj");
    if ([self.delegate respondsToSelector:@selector(addImageOrVedio)]) {
        [self.delegate addImageOrVedio];
    }
}

@end
