//
//  CYMineTableCell.h
//  esayou
//
//  Created by ESAY on 16/3/29.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYMineModel;
@interface CYMineTableCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *rightImageView;

-(void)fillDataWith:(CYMineModel *)model;
+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;
@end
