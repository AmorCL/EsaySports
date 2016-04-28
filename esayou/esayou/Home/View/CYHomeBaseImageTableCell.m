//
//  CYHomeBaseImageTableCell.m
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYHomeBaseImageTableCell.h"
#import <AVFoundation/AVFoundation.h>
const CGFloat contentLabelFontSize = 15;
CGFloat maxTitleLabelHeight = 0;
@implementation CYHomeBaseImageTableCell
+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    // 1.缓存中取
    CYHomeBaseImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CYHomeBaseImageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    _shouldOpenTitleLabel = NO;

    _headImgView = [UIImageView new];
    _headImgView.contentMode = UIViewContentModeScaleAspectFill;
    _headImgView.backgroundColor = GetColor(whiteColor);
    [self.contentView addSubview:_headImgView];
    
    _nameLab = [UILabel new];
    _nameLab.backgroundColor = GetColor(whiteColor);
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.font = GetFont(15);
    [self.contentView addSubview:self.nameLab];
    
    _levelLab = [UILabel new];
    _levelLab.backgroundColor = GetColor(redColor);
    _levelLab.textAlignment = NSTextAlignmentLeft;
    _levelLab.font = GetFont(15);
    [self.contentView addSubview:self.levelLab];

    _timeLab = [UILabel new];
    _timeLab.backgroundColor = GetColor(whiteColor);
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.font = GetFont(12);
    [self.contentView addSubview:self.timeLab];
    
    _focusBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_focusBtn addTarget:self action:@selector(myfocus) forControlEvents:UIControlEventTouchUpInside];
    [_focusBtn setTitleColor:GetColor(blueColor) forState:UIControlStateNormal];
    [_focusBtn.titleLabel sizeToFit];
    [self.contentView addSubview:_focusBtn];
    
    _titleLab = [UILabel new];
    _titleLab.backgroundColor = GetColor(whiteColor);
    _titleLab.font = GetFont(contentLabelFontSize);
    if (maxTitleLabelHeight == 0) {
        maxTitleLabelHeight = _titleLab.font.lineHeight*3;
    }
    [self.contentView addSubview:_titleLab];
    
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_moreButton];
    
    _bigImgView = [UIImageView new];
    //    _bigImgView.contentMode = UIViewContentModeScaleToFill;
    _bigImgView.backgroundColor = GetColor(whiteColor);
    _bigImgView.userInteractionEnabled = NO;
    [self.contentView addSubview:_bigImgView];
    
    _adressImgView = [UIImageView new];
    _adressImgView.image =GetImage(@"live_btn_location");
    [self.contentView addSubview:_adressImgView];
    
    _adressLab = [UILabel new];
    _adressLab.textAlignment = NSTextAlignmentLeft;
    _adressLab.font = GetFont(12);
    [self.contentView addSubview:_adressLab];
    
    _collecImgView = [UIImageView new];
    _collecImgView.image = GetImage(@"live_btn_collect");
    [self.contentView addSubview:_collecImgView];
    
    _collecNum = [UILabel new];
    _collecNum.font = GetFont(12);
    [self.contentView addSubview:_collecNum];
    
    _commentImgView = [UIImageView new];
    _commentImgView.image = GetImage(@"live_btn_replay");
    [self.contentView addSubview:_commentImgView];
    
    _commentNum = [UILabel new];
    _commentNum.textAlignment = NSTextAlignmentLeft;
    _commentNum.font = GetFont(12);
    [self.contentView addSubview:_commentNum];
    
    _zanView = [UIImageView new];
    _zanView.image = GetImage(@"live_btn_praise");
    [self.contentView addSubview:_zanView];
    
    _zanNum = [UILabel new];
    _zanNum.textAlignment = NSTextAlignmentLeft;
    _zanNum.font = GetFont(12);
    [self.contentView addSubview:_zanNum];
    
    _moreImg = [UIImageView new];
    _moreImg.image = GetImage(@"live_btn_more");
    [self.contentView addSubview:_moreImg];
    
    _playBtn = [UIButton new];
    [_playBtn setBackgroundImage:GetImage(@"live_btn_video") forState:UIControlStateNormal];
    _playBtn.hidden = YES;
    _playBtn.userInteractionEnabled = YES;
    [_playBtn addTarget:self action:@selector(startPlayVedio) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_playBtn];

    _headImgView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(40)
    .heightIs(40);
    
    _nameLab.sd_layout
    .leftSpaceToView(self.headImgView,10)
    .topEqualToView(_headImgView)
    .heightIs(20)
    .widthIs(40);
    
    _levelLab.sd_layout
    .leftSpaceToView(_nameLab,5)
    .centerYEqualToView(_nameLab)
    .heightIs(20)
    .widthIs(40);
    
    _timeLab.sd_layout
    .leftEqualToView(_nameLab)
    .topSpaceToView(_nameLab,0)
    .heightIs(20)
    .autoHeightRatio(0);
    
    _focusBtn.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(_headImgView)
    .heightIs(20)
    .widthIs(40);
    
    _titleLab.sd_layout
    .leftEqualToView(_headImgView)
    .topSpaceToView(self.headImgView,5)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_titleLab)
    .topSpaceToView(_titleLab,0)
    .widthIs(40);
    
    _bigImgView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.titleLab,5)
    .heightIs(100);
    
    _adressImgView.sd_layout
    .leftEqualToView(_headImgView)
    .topSpaceToView(_bigImgView,5)
    .widthIs(20)
    .heightIs(20);
    
    _adressLab.sd_layout
    .leftSpaceToView(_adressImgView,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20);
    
    _moreImg.sd_layout
    .rightSpaceToView(self.contentView,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20)
    .widthIs(20);
    
    _zanNum.sd_layout
    .rightSpaceToView(_moreImg,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20);
    
    _zanView.sd_layout
    .rightSpaceToView(_zanNum,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20)
    .widthIs(20);
    
    _commentNum.sd_layout
    .rightSpaceToView(_zanView,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20);
    
    _commentImgView.sd_layout
    .rightSpaceToView(_commentNum,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20)
    .widthIs(20);
    
    _collecNum.sd_layout
    .rightSpaceToView(_commentImgView,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20);
    
    _collecImgView.sd_layout
    .rightSpaceToView(_collecNum,5)
    .centerYEqualToView(_adressImgView)
    .heightIs(20)
    .widthIs(20);
    _playBtn.sd_layout
    .centerXEqualToView(_bigImgView)
    .centerYEqualToView(_bigImgView)
    .widthIs(60)
    .heightIs(60);
    
    [_adressLab setSingleLineAutoResizeWithMaxWidth:100];
    [_collecNum setSingleLineAutoResizeWithMaxWidth:60];
    [_commentNum setSingleLineAutoResizeWithMaxWidth:60];
    [_zanNum setSingleLineAutoResizeWithMaxWidth:60];
    _headImgView.sd_cornerRadiusFromWidthRatio = @(0.5);
    [_nameLab setSingleLineAutoResizeWithMaxWidth:200];
    [_levelLab setSingleLineAutoResizeWithMaxWidth:60];
    [_timeLab setSingleLineAutoResizeWithMaxWidth:200];
}
-(void)setModel:(CYHomeLiveListModel *)model{
    _levelLab.text = @"Lv金";
    [_levelLab sizeToFit];
    _model = model;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.headimg] placeholderImage:GetImage(@"v.jpg")];
    NSLog(@"head:%@",model.headimg);
    _nameLab.text = model.user_name;
    // 防止单行文本label在重用时宽度计算不准的问题
    [_nameLab sizeToFit];
    
    _timeLab.text = model.datetime;
    [_timeLab sizeToFit];
    
    _shouldOpenTitleLabel = NO;
    _titleLab.text = model.content;
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(30);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _titleLab.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _titleLab.sd_layout.maxHeightIs(maxTitleLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    CGFloat picContainerTopMargin = 5;
    _bigImgView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    if ([model.img_path[0] length] == 0) {
        
        _playBtn.hidden = NO;
        _bigImgView.image = GetImage(@"v.jpg");
        _bigImgView.image = [self imageWithMediaURL:[NSURL URLWithString:model.video_path]];
        CGFloat scale = _bigImgView.image.size.height / _bigImgView.image.size.width;
        UIImage *temp = [UIImage new];
        temp =[self imageCompressForSize:_bigImgView.image targetSize:CGSizeMake(kScreenWidth, scale*kScreenWidth)];
        _bigImgView.image = [self cutImage:temp] ;
        _bigImgView.sd_layout.autoHeightRatio(0.5625);
        }else{
        [_bigImgView sd_setImageWithURL:[NSURL URLWithString:model.img_path[0]] placeholderImage:GetImage(@"v.jpg") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGFloat scale = image.size.height / image.size.width;
            NSLog(@"bigImage:%f    %f",image.size.width,image.size.height);
            UIImage *temp = [UIImage new];
            temp =[self imageCompressForSize:image targetSize:CGSizeMake(kScreenWidth, scale*kScreenWidth)];
            _bigImgView.image = [self cutImage:temp] ;
            _bigImgView.sd_layout.autoHeightRatio(0.5625);

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void){
                            });
        }];
    }
    
    _adressLab.text = model.country;
    [_adressLab sizeToFit];
    
    _collecNum.text = [NSString stringWithFormat:@"%@",model.share];
    [_commentNum sizeToFit];
    
    _commentNum.text = [NSString stringWithFormat:@"%@",model.comment];
    [_commentNum sizeToFit];

    _zanNum.text = [NSString stringWithFormat:@"%@",model.is_good];
    [_zanNum sizeToFit];
    [self setupAutoHeightWithBottomViewsArray:@[_adressLab,_collecNum,_zanNum] bottomMargin:10];

}
-(void)startPlayVedio{
    NSLog(@"播放");
    if (self.playButtonClickedBlock) {
        self.playButtonClickedBlock(self.indexPath);
    }
}
#pragma mark - private actions
-(void)myfocus{
    NSLog(@"关注");
}
-(void)moreBtned{
    NSLog(@"举报");
}
- (void)moreButtonClicked
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}
//裁剪成一定比例尺寸
- (UIImage *)cutImage:(UIImage *)image {
    
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    //以宽为标准进行裁剪图片
    newSize.width = image.size.width;
    newSize.height = image.size.width * 9 / 16;
    
    imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    
    return [UIImage imageWithCGImage:imageRef];
}

//等比压缩
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();

    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  通过视频的URL，获得视频缩略图
 *
 *  @param url 视频URL
 *
 *  @return首帧缩略图
 */
- (UIImage *)imageWithMediaURL:(NSURL *)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void){
        
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                         forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        // 初始化媒体文件
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
        // 根据asset构造一张图
        AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
        generator.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        //    generator.maximumSize = CGSizeMake(600, 450);
        // 初始化error
        NSError *error = nil;
        // 根据时间，获得第N帧的图片
        // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
        CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
        // 构造图片
        _image = [UIImage imageWithCGImage: img];
    });

    return _image;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
