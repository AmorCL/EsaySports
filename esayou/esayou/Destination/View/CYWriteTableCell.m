//
//  CYWriteTableCell.m
//  esayou
//
//  Created by ESAY on 16/4/15.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYWriteTableCell.h"
#import "CYWriteModel.h"
@implementation CYWriteTableCell
+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    // 1.缓存中取
    CYWriteTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CYWriteTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    self.bigImageView = [UIImageView new];
//    _bigImageView.backgroundColor = GetColor(blueColor);
    [self.contentView addSubview:_bigImageView];
    
    self.typeLab = [UILabel new];
    _typeLab.textColor = GetColor(whiteColor);
    _typeLab.textAlignment = NSTextAlignmentCenter;
    [self.bigImageView addSubview:_typeLab];
    
    self.timeLab = [UILabel new];
    _timeLab.textColor = GetColor(whiteColor);
    _timeLab.textAlignment = NSTextAlignmentLeft;
    [_bigImageView addSubview:_timeLab];
    
    self.personImagView = [UIImageView new];
//    self.personImagView.backgroundColor = GetColor(redColor);
    _personImagView.layer.cornerRadius = 15;
    _personImagView.clipsToBounds = YES;
    [_bigImageView addSubview:_personImagView];
    
    self.personNameLab = [UILabel new];
    self.personNameLab.textColor = GetColor(whiteColor);
    _personNameLab.textAlignment = NSTextAlignmentCenter;
    _personNameLab.font = GetFont(12);
    [_bigImageView addSubview:_personNameLab];
    
    self.titleLab = [UILabel new];
//    self.titleLab.backgroundColor = GetColor(yellowColor);
    _titleLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLab];
    
    self.adressImg = [UIImageView new];
//    self.adressImg.backgroundColor = GetColor(redColor);
    [self.contentView addSubview:_adressImg];
    
    self.adressLab = [UILabel new];
    _adressLab.font = GetFont(12);
    _adressLab.adjustsFontSizeToFitWidth = YES;
    _adressLab.textAlignment = NSTextAlignmentLeft;
//    _adressLab.backgroundColor = GetColor(yellowColor);
    [self.contentView addSubview:_adressLab];
    
    self.comentLab = [UILabel new];
    _comentLab.font = GetFont(12);

//    _comentLab.backgroundColor = GetColor(purpleColor);
    _comentLab.textAlignment = NSTextAlignmentRight;
    _comentLab.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_comentLab];
    
    _bigImageView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .heightIs(100);
    
    _typeLab.sd_layout
    .leftSpaceToView(_bigImageView,0)
    .topSpaceToView(_bigImageView,0)
    .widthIs(100)
    .heightIs(30);
    
    _timeLab.sd_layout
    .leftSpaceToView(_bigImageView,20)
    .bottomSpaceToView(_bigImageView,10)
    .widthIs(100)
    .heightIs(20);
    
    _personNameLab.sd_layout
    .rightSpaceToView(_bigImageView,20)
    .bottomSpaceToView(_bigImageView,10)
    .widthIs(100)
    .heightIs(20);
    
    _personImagView.sd_layout
    .rightSpaceToView(_bigImageView,20)
    .bottomSpaceToView(_personNameLab,5)
    .widthIs(30)
    .heightIs(30);
    
    _titleLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_bigImageView,10)
    .widthIs(kScreenWidth-40)
    .heightIs(30);
    
    _adressImg.sd_layout
    .leftEqualToView(_titleLab)
    .topSpaceToView(_titleLab,5)
    .widthIs(20)
    .heightIs(20);
    
    _adressLab.sd_layout
    .leftSpaceToView(_adressImg,5)
    .centerYEqualToView(_adressImg)
    .widthIs(100)
    .heightIs(20);
    
    _comentLab.sd_layout
    .leftSpaceToView(_adressLab,10)
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(_adressImg)
    .heightIs(20);
    
    [_typeLab setSingleLineAutoResizeWithMaxWidth:100];
    [_titleLab setSingleLineAutoResizeWithMaxWidth:150];
    [_personNameLab setSingleLineAutoResizeWithMaxWidth:100];
    [_titleLab setSingleLineAutoResizeWithMaxWidth:kScreenWidth-40];
    [_adressLab setSingleLineAutoResizeWithMaxWidth:100];
}

-(void)setModel:(CYWriteModel *)model{
    _model = model;
    _typeLab.text = model.type;
    _timeLab.text = model.time;
    _personNameLab.text = model.personName;
    _titleLab.text = model.title;
    _adressLab.text = model.adress;
    _comentLab.text = model.coment;
    
    [_typeLab sizeToFit];
    [_timeLab sizeToFit];
    [_titleLab sizeToFit];
    [_personNameLab sizeToFit];
    [_adressLab sizeToFit];
    [_comentLab sizeToFit];
    _adressImg.image = GetImage(model.adressImage);
    _personImagView.image = GetImage(model.personImag);

    CGFloat bottomMargin = 0;
    // 在实际的开发中，网络图片的宽高应由图片服务器返回然后计算宽高比。
    UIImage *pic = [UIImage imageNamed:model.bigImage];
    NSLog(@"pic:%f",pic.size.width);
    CGFloat scale = pic.size.height / pic.size.width;
    _bigImageView.sd_layout.autoHeightRatio(scale);
    _bigImageView.image = pic;
    bottomMargin = 10;

    [self setupAutoHeightWithBottomView:_comentLab bottomMargin:bottomMargin];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
