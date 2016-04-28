//
//  CYPhotoVedioCollectionViewCell.m
//  esayou
//
//  Created by ESAY on 16/4/21.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYPhotoVedioCollectionViewCell.h"

@implementation CYPhotoVedioCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    _backgroundImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.contentView addSubview:_backgroundImg];
}

@end
