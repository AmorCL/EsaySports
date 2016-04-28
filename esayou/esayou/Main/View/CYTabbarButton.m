//
//  CYTabbarButton.m
//  tennisApp
//
//  Created by ESAY on 15/10/12.
//  Copyright (c) 2015年 ESAY. All rights reserved.
//

#import "CYTabbarButton.h"
@interface CYTabbarButton()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation CYTabbarButton


- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
              image:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.image = image;
        self.selectedImage = selectedImage;
        
        self.imageView.image = image;
        self.titleLabel.text = title;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTabBarDidSelected)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (_selected) {
        self.imageView.image = self.selectedImage;
        self.titleLabel.textColor = RGB(32, 177, 29);
    }else {
        self.imageView.image = self.image;
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

- (void)onTabBarDidSelected
{
    if (_btnDidSelected) {
        _btnDidSelected(self.tag);
    }
}

#pragma mark -- 懒加载 --
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20)];
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.bounds.size.width, 20)];
        _titleLabel.textColor     = RGB(0, 0, 0);
        _titleLabel.alpha = 0.87f;
        _titleLabel.font          = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
