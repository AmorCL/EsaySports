//
//  CYPickVedioViewController.h
//  esayou
//
//  Created by ESAY on 16/4/21.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CYPickVedioViewController : UIViewController
@property(strong,nonatomic) void (^VedioResult)(id responseObject);

@end
