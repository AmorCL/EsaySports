//
//  CYTravelWoldTableViewCell.m
//  esayou
//
//  Created by ESAY on 16/4/14.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYTravelWoldTableViewCell.h"

@implementation CYTravelWoldTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    // 1.缓存中取
    CYTravelWoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CYTravelWoldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
    
    //大图
    self.bigImageView = [UIImageView new];
//    _bigImageView.backgroundColor = GetColor(yellowColor);
    [self.contentView addSubview:_bigImageView];
    //标题
    self.travelTitleLab = [[UILabel alloc]init];
    _travelTitleLab.text = @"124";
    _travelTitleLab.textColor = GetColor(lightGrayColor);
    _travelTitleLab.textAlignment = NSTextAlignmentLeft;
    _travelTitleLab.font = GetFont(15);
    [self.contentView addSubview:_travelTitleLab];
    //地址
    self.adressLab = [UILabel new];
    _adressLab.text = @"124";
    _adressLab.textColor = GetColor(lightGrayColor);
    _adressLab.textAlignment = NSTextAlignmentLeft;
    _adressLab.font = GetFont(12);
    [self.contentView addSubview:self.adressLab];
    //时间
    _timeLab = [UILabel new];
    _timeLab.text = @"124";
    _timeLab.textColor = GetColor(lightGrayColor);
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.font = GetFont(12);
    [self.contentView addSubview:self.timeLab];
    //价格
    _priceLab = [UILabel new];
    _priceLab.textColor = GetColor(blueColor);
    _priceLab.textAlignment = NSTextAlignmentRight;
    _priceLab.textColor = GetColor(blueColor);
    _priceLab.font = GetFont(12);
    [self.contentView addSubview:self.priceLab];
    
    _bigImageView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .heightIs(100);

    
    _travelTitleLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.bigImageView,10)
    .heightIs(30)
    .widthIs(80);
    [_travelTitleLab setSingleLineAutoResizeWithMaxWidth:200];
    
    _adressLab.sd_layout
    .leftEqualToView(_travelTitleLab)
    .topSpaceToView(_travelTitleLab,10)
    .heightIs(20)
    .widthIs(100);
    [_adressLab setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLab.sd_layout
    .leftEqualToView(_adressLab)
    .topSpaceToView(_adressLab,10)
    .heightIs(20)
    .widthIs(100);
    [_timeLab setSingleLineAutoResizeWithMaxWidth:150];
    
    _priceLab.sd_layout
    .rightSpaceToView(self.contentView,20)
    .topSpaceToView(_adressLab,5)
    .heightIs(30)
    .widthIs(100);
    

    [_priceLab setSingleLineAutoResizeWithMaxWidth:100];
    
    
    

}
-(void)setModel:(CYTravelModel *)model{
    _model = model;

    self.travelTitleLab.text = model.title;
    [_travelTitleLab sizeToFit];
    _adressLab.text = model.title;
    [_adressLab sizeToFit];
    _timeLab.text = model.time;
    [_timeLab sizeToFit];
    _priceLab.text = model.price;
    [_priceLab sizeToFit];

    
    
    CGFloat bottomMargin = 0;
    
    // 在实际的开发中，网络图片的宽高应由图片服务器返回然后计算宽高比。

    UIImage *pic = [UIImage imageNamed:model.bigImageView];
    NSLog(@"pic:%f",pic.size.width);
    CGFloat scale = pic.size.height / pic.size.width;
    _bigImageView.sd_layout.autoHeightRatio(scale);
    _bigImageView.image = pic;
    bottomMargin = 10;

//    if (pic.size.width > 0) {
//        CGFloat scale = pic.size.height / pic.size.width;
//        _bigImageView.sd_layout.autoHeightRatio(scale)
//        .topEqualToView(self.contentView)
//        .bottomSpaceToView(_travelTitleLab,10);
//        _bigImageView.image = pic;
//        bottomMargin = 10;
//        //        _bigImgView.hidden = YES;
//    }
//    else {
//        _bigImageView.sd_layout.autoHeightRatio(0)
//        .topEqualToView(self.contentView)
//        .bottomSpaceToView(_travelTitleLab,10);
//        //        _bigImgView.hidden = NO;
//    }
    
    //***********************高度自适应cell设置步骤************************
    
    
    
    
//    [self setupAutoHeightWithBottomViewsArray:@[_timeLab,_bigImageView,_priceLab] bottomMargin:bottomMargin];
    [self setupAutoHeightWithBottomView:_timeLab bottomMargin:bottomMargin];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
