//
//  CYHomeLiveListModel.m
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYHomeLiveListModel.h"
extern const CGFloat contentLabelFontSize;
extern CGFloat maxTitleLabelHeight;

@implementation CYHomeLiveListModel
@synthesize content = _content;
+(NSDictionary *)mj_objectClassInArray{
    return @{@"img_path":@"Imagepath"};
}

-(void)setContent:(NSString *)content{
    _content = content;
}
-(NSString *)content{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 40;
    CGRect textRect = [_content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
    if (textRect.size.height > maxTitleLabelHeight) {
        _shouldShowMoreButton = YES;
    } else {
        _shouldShowMoreButton = NO;
    }
    
    return _content;
}
- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

@end
