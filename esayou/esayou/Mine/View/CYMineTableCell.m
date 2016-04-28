//
//  CYMineTableCell.m
//  esayou
//
//  Created by ESAY on 16/3/29.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYMineTableCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CYMineModel.h"
@implementation CYMineTableCell

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
         // 1.缓存中取
  CYMineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
     // 2.创建
    if (cell == nil) {
             cell = [[CYMineTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
         }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.leftImageView = [UIImageView new];
    self.leftImageView.backgroundColor = GetColor(clearColor);
    [self.contentView addSubview:self.leftImageView];
    
    
    self.titleLab = [UILabel new];
//    self.titleLab.backgroundColor = GetColor(yellowColor);
    [self.contentView addSubview:self.titleLab];
    
    self.rightImageView = [UIImageView new];
    [self.contentView addSubview:self.rightImageView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(237, 237, 237);
    [self.contentView addSubview:lineView];
    
    _leftImageView.sd_layout
    .widthIs(40)
    .heightIs(40)
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,10);
    
    _titleLab.sd_layout
    .heightIs(20)
    .widthIs(100)
    .leftSpaceToView(self.leftImageView,10)
    .centerYEqualToView(self.contentView);
    
    _rightImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(_leftImageView)
    .widthIs(20)
    .heightIs(20);
    
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(1);
    
    NSLog(@"%f",_leftImageView.frame.size.height);
    
//    [_titleLab setSingleLineAutoResizeWithMaxWidth:100];
    
}
-(void)fillDataWith:(CYMineModel *)model{
    _titleLab.text = model.title;
    _leftImageView.image = GetImage(model.pic);
    _rightImageView.image = GetImage(@"my_btn_arrow_right");
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
