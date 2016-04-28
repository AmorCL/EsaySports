//
//  CYHomeBaseVedioTableCell.m
//  esayou
//
//  Created by ESAY on 16/4/27.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYHomeBaseVedioTableCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
extern const CGFloat contentLabelFontSize;
extern CGFloat maxTitleLabelHeight;
#define COUNT_DUR_TIMER_INTERVAL  0.025
@interface CYHomeBaseVedioTableCell()
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property(nonatomic,assign)BOOL playBeginState;
@property(nonatomic,assign)BOOL isPause;

@end
@implementation CYHomeBaseVedioTableCell
+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    // 1.缓存中取
    CYHomeBaseVedioTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CYHomeBaseVedioTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
    
    
    
    _vedioView = [UIImageView new];
    //    _bigImgView.contentMode = UIViewContentModeScaleToFill;
    _vedioView.backgroundColor = GetColor(blackColor);
    [self.contentView addSubview:_vedioView];
    
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
    .widthIs(30);
    
    _vedioView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.titleLab,5)
    .heightIs(kScreenWidth*9/16);
    
    _adressImgView.sd_layout
    .leftEqualToView(_vedioView)
    .topSpaceToView(_vedioView,5)
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
    
    [_adressLab setSingleLineAutoResizeWithMaxWidth:100];
    [_collecNum setSingleLineAutoResizeWithMaxWidth:60];
    [_commentNum setSingleLineAutoResizeWithMaxWidth:60];
    [_zanNum setSingleLineAutoResizeWithMaxWidth:60];
    _headImgView.sd_cornerRadiusFromWidthRatio = @(0.5);
    [_nameLab setSingleLineAutoResizeWithMaxWidth:200];
    [_timeLab setSingleLineAutoResizeWithMaxWidth:200];

    
    //播放结束
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(playerItemDidReachEnd:)
                                                 name: AVPlayerItemDidPlayToEndTimeNotification
                                               object: self.playerItem];
}

-(void)initPlayer:(NSURL *)fileUrl
{
    
    
    AVURLAsset *movieAsset    = [[AVURLAsset alloc]initWithURL:fileUrl options:nil];
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:0 context:NULL];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    playerLayer.frame = self.vedioView.layer.bounds;
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.vedioView.layer addSublayer:playerLayer];
    [self.player setAllowsExternalPlayback:YES];
    
    UIImageView *playView = [UIImageView new];
    playView.backgroundColor = GetColor(redColor);
    playView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVedio)];
    [playView addGestureRecognizer:tap];
    [self.vedioView addSubview:playView];
    
    playView.sd_layout
    .centerXEqualToView(self.vedioView)
    .centerYEqualToView(self.vedioView)
    .widthIs(30)
    .heightIs(30);
    
    
}
-(void)setModel:(CYHomeLiveListModel *)model{
    _model = model;
//    [self initPlayer:[NSURL URLWithString:model.video_path]];
    
    _vedioView.image = [self imageWithMediaURL:[NSURL URLWithString:model.video_path]];
    _vedioView.sd_layout.autoHeightRatio(0.5625);
    
    [self setupAutoHeightWithBottomView:_adressImgView bottomMargin:10];
}

/**
 *  通过视频的URL，获得视频缩略图
 *
 *  @param url 视频URL
 *
 *  @return首帧缩略图
 */
- (UIImage *)imageWithMediaURL:(NSURL *)url {
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
    generator.maximumSize = CGSizeMake(600, 450);
    // 初始化error
    NSError *error = nil;
    // 根据时间，获得第N帧的图片
    // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
    // 构造图片
    UIImage *image = [UIImage imageWithCGImage: img];
    return image;
}


-(void)playVedio{
    
}
#pragma mark - 加载视频完成
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        if (AVPlayerItemStatusReadyToPlay == self.player.currentItem.status)
        {
            // [self.player play];
            
            
            NSLog(@"准备播放");
            //            NSLog(@"%lf",[self playableDuration]);
            //            [UIView animateWithDuration:[self playableDuration] animations:^{
            //
            //            }];
            
        }
    }
}
#pragma mark - 播放结束时
- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    // Loop the video
    
    
    //        [self.player play];
    //    }else {
    //        mPlayer.actionAtItemEnd = AVPlayerActionAtItemEndAdvance;
    //    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
