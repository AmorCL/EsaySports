//
//  CYWantLiveViewController.h
//  esayou
//
//  Created by ESAY on 16/4/20.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYRootViewController.h"
#import "CYTextView.h"
#import "CYShowImgView.h"
@interface CYWantLiveViewController : CYRootViewController<CYShowImgViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)CYTextView *editTextView;
@property(nonatomic,strong)CYShowImgView *showImgView;
@property(strong,nonatomic) void (^PhotoResult)();


@end
