//
//  CYHomeBaseImageTableCell.h
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHomeLiveListModel.h"
@interface CYHomeBaseImageTableCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImgView;
@property(nonatomic,strong)UIImageView *bigImgView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *levelLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIButton *focusBtn;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *adressImgView;
@property(nonatomic,strong)UILabel *adressLab;
@property(nonatomic,strong)UIImageView *collecImgView;
@property(nonatomic,strong)UILabel *collecNum;
@property(nonatomic,strong)UIImageView *commentImgView;
@property(nonatomic,strong)UILabel *commentNum;
@property(nonatomic,strong)UIImageView *zanView;
@property(nonatomic,strong)UILabel *zanNum;
@property(nonatomic,strong)UIImageView *moreImg;
@property(nonatomic,strong)UIButton *playBtn;
@property (nonatomic, copy) void (^playButtonClickedBlock)(NSIndexPath *indexPath);
@property(nonatomic,strong)CYHomeLiveListModel *model;

@property(nonatomic,assign)BOOL shouldOpenTitleLabel;
@property(nonatomic,strong)UIButton *moreButton;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);
@property(nonatomic,strong)UIImage *image;

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;


@end
