//
//  CYPickPhotoViewController.h
//  esayou
//
//  Created by ESAY on 16/4/20.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYRootViewController.h"
#import "Common.h"

@interface CYPickPhotoViewController : CYRootViewController
@property(strong,nonatomic) void (^PhotoResult)(id responseObject);
@property(strong,nonatomic) void (^VedioResult)(id responseObject);
@property(assign,nonatomic) NSInteger selectNum;
@property(assign,nonatomic) BOOL isAlubSeclect;
@property(strong,nonatomic) PHFetchResult *fetch;
@property (nonatomic,copy) NSString *navTitleString;


@end
