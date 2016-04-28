//
//  CYWriteTableCell.h
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYWriteModel;
@interface CYWriteTableCell : UITableViewCell
@property(nonatomic,strong)UIImageView *bigImageView;
@property(nonatomic,strong)UILabel *typeLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView *personImagView;
@property(nonatomic,strong)UILabel *personNameLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *adressImg;
@property(nonatomic,strong)UILabel *adressLab;
@property(nonatomic,strong)UILabel *comentLab;
@property(nonatomic,strong)CYWriteModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;







@end
