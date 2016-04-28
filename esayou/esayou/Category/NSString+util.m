//
//  NSString+util.m
//  2_LabelHeight
//
//  Created by qianfeng on 15/7/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSString+util.h"

@implementation NSString (util)

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin
            attributes:@{NSFontAttributeName : font} context:nil].size;
        return size.height;
    } else {
        CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
        return size.height;
    }
}

@end
