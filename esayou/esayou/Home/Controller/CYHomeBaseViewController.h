//
//  CYHomeBaseViewController.h
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYRootViewController.h"
#import "CYWithoutWifiView.h"

@interface CYHomeBaseViewController : CYRootViewController<CYWithoutWifiViewdelegate>
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) NSString *urlString;
@property(nonatomic,assign)CGSize size;

@end
