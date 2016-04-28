//
//  CYHomeLiveListModel.h
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePath.h"
@interface CYHomeLiveListModel : NSObject
@property (nonatomic, copy) NSNumber *comment;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *datetime;
@property (nonatomic, copy) NSNumber *follow;
@property (nonatomic, copy) NSNumber *good;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, strong) NSArray *img_path;
@property (nonatomic, copy) NSNumber *is_good;
@property (nonatomic, copy) NSNumber *lal;
@property (nonatomic, copy) NSNumber *share;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *video_path;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@end
