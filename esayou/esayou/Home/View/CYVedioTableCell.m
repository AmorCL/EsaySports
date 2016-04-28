//
//  CYVedioTableCell.m
//  esayou
//
//  Created by ESAY on 16/4/25.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYVedioTableCell.h"

@implementation CYVedioTableCell

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    // 1.缓存中取
    CYVedioTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CYVedioTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
    self.backgroundColor = GetColor(clearColor);
    //播放结束
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(playerItemDidReachEnd:)
                                                 name: AVPlayerItemDidPlayToEndTimeNotification
                                               object: self.playerItem];
    

}
-(void)fillDataWith:(CYHomeLiveListModel *)model{
    NSURL *url = [NSURL URLWithString:model.video_path];
    AVURLAsset *movieAsset    = [[AVURLAsset alloc]initWithURL:url options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    [self.playerItem addObserver:self forKeyPath:@"status" options:0 context:NULL];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    playerLayer.frame = self.layer.bounds;
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:playerLayer];
    [self.player setAllowsExternalPlayback:YES];
    
    UIImageView *playView = [UIImageView new];
    playView.backgroundColor = GetColor(redColor);
    playView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVedio)];
    [playView addGestureRecognizer:tap];
    [self addSubview:playView];
    
    
    playView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(30)
    .heightIs(30);
    
}
-(void)playVedio{
    NSLog(@"播放");
    self.playButtonClickedBlock(self.indexpath);
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
