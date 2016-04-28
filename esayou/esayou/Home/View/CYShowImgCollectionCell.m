//
//  CYShowImgCollectionCell.m
//  tennisApp
//
//  Created by ESAY on 16/1/14.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYShowImgCollectionCell.h"

@implementation CYShowImgCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
    }
    return self;
}
-(void)confingSubViews{
    self.picImgView = [QuickControl imageViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) imageFile:nil tag:0];
    self.picImgView.userInteractionEnabled = YES;
    [self addSubview:_picImgView];
    
    self.deleteButton = [QuickControl buttonWithFrame:CGRectMake(_picImgView.width-20, 0, 20, 20) title:nil backgroundColor:nil target:self action:@selector(deleteImage:) tag:0];
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"custon_button_reduce"] forState:UIControlStateNormal];
    [self.picImgView addSubview:self.deleteButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picImgViewDidselected:)];
    [self.picImgView addGestureRecognizer:tap];
    
}
-(void)fillDataWith:(NSMutableArray *)array and:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.picImgView.image = array[indexPath.row];
}
-(void)deleteImage:(UIButton *)btn{
    NSLog(@"删除pic");
    if ([self.deleteDelegate respondsToSelector:@selector(deleteItemWithIndexPath:)]) {
        [self.deleteDelegate deleteItemWithIndexPath:self.indexPath];
    }
}
-(void)picImgViewDidselected:(UITapGestureRecognizer *)tap{
    NSLog(@"图片被点击");
}
@end
