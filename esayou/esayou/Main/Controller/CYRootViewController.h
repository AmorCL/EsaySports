//
//  CYRootViewController.h
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYWithoutWifiView.h"
@interface CYRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CYWithoutWifiViewdelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *wifiView;
@property(nonatomic,strong)UIImageView *navBarView;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *navLeftBtn;
@property(nonatomic,strong)UIButton *navRightBtn;
@property(nonatomic,copy)NSString *titleString;
@property(nonatomic,strong)CYWithoutWifiView *noWifiView;

- (void)addTitleViewWithTitle:(NSString *)title;
- (void)addLeftBtnWithTitle:(NSString *)title imageFile:(NSString *)file selector:(SEL)selector;
- (void)addRightBtnWithTitle:(NSString *)title imageFile:(NSString *)file selector:(SEL)selector;

- (void)showWaiting:(BOOL)isShow;
- (void)showInfoView:(NSString *)info;
@end
