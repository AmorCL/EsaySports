//
//  CYCodeTextFiled.h
//  esayou
//
//  Created by ESAY on 16/4/8.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)();
@interface CYCodeTextFiled : UITextField
@property (nonatomic,copy) Block getCodeBtned;
@property(nonatomic,strong)UIButton *getCode;
@property(nonatomic,assign)NSInteger currentTime;
@property(nonatomic,strong)NSTimer *timer;

@end
