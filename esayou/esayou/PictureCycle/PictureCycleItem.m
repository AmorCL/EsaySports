//
//  PictureCycleItem.m
//  Union
//
//  Created by 张展 on 15/7/27.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PictureCycleItem.h"

#import <UIImageView+WebCache.h>


@interface PictureCycleItem ()

@property (nonatomic , retain ) UIImageView *imageView;//图片

@property (nonatomic , retain ) UILabel *titleLabel;//标题标签

@end

@implementation PictureCycleItem

//初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化图片
        
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic0.jpg"]];
        
        
        
        [self addSubview:_imageView];
        
        //初始化标题标签
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 45 , CGRectGetWidth(self.frame), 30)];
        
        _titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;

        [self addSubview:_titleLabel];
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    if (_titleLabel != nil) {
        
        _titleLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 45 , CGRectGetWidth(self.frame), 30);
        
    }
    
}

//获取数据

-(void)setModel:(ImagePath *)model{
    
    if (_model != model) {
        _model = model;
    }
    
    //处理数据
    
    if (model != nil) {
        
        //SDWebImage加载图片
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.img_path] placeholderImage:[UIImage imageNamed:@"pic0.jpg"]];
        
        if (model.picTitle != nil) {
            
            _titleLabel.hidden = NO;
            
            _titleLabel.text = model.picTitle;
            
        } else {
            
            _titleLabel.hidden = YES;
            
        }
        
        
    }
    
    
    
}


@end
