//
//  CYTabbar.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYTabbar.h"
#import "CYTabbarButton.h"
@implementation CYTabbar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)setControllers:(NSArray *)controllers{
    _controllers = controllers;
//    self.controllers = controllers;
    [self setupInit];
}
-(void)setupInit{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIView *lineView = [QuickControl viewWithFrame:CGRectMake(0,0, kScreenWidth, 0.5) backgroundColor:RGB(237, 237, 237) tag:0];
    [self addSubview:lineView];
    CGFloat viewW = self.frame.size.width / _controllers.count;

    for (int i = 0; i < _controllers.count; i ++) {
        UINavigationController *vc = [_controllers objectAtIndex:i];
        CYTabbarButton *btn = [[CYTabbarButton alloc] initWithFrame:CGRectMake(i * viewW, 1, viewW, 49) title:vc.tabBarItem.title image:vc.tabBarItem.image selectedImage:vc.tabBarItem.selectedImage];
        btn.tag = i;
        __weak typeof(self) weakSelf = self;
        
        btn.btnDidSelected = ^(NSInteger tag){
            [weakSelf changeBtnStatus:tag];
        };
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        [self addSubview:btn];
        

    }
}
- (void)changeBtnStatus:(NSInteger)tag
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CYTabbarButton class]]) {
            CYTabbarButton *btn = ((CYTabbarButton *)view);
            if (btn.tag == tag) {
                btn.selected = YES;
                
                if ([_delegate respondsToSelector:@selector(tabBarDidSelected:)]) {
                    [_delegate tabBarDidSelected:tag];
                }
                
            }else {
                btn.selected = NO;
            }
        }
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
