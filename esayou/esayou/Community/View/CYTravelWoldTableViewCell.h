//
//  CYTravelWoldTableViewCell.h
//  esayou
//
//  Created by ESAY on 16/4/14.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTravelModel.h"

@interface CYTravelWoldTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *bigImageView;
@property(nonatomic,strong)UILabel *travelTitleLab;
@property(nonatomic,strong)UILabel *adressLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)CYTravelModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;




@end
