//
//  CYShowVedioCell.m
//  esayou
//
//  Created by ESAY on 16/4/22.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "CYShowVedioCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#define COUNT_DUR_TIMER_INTERVAL  0.025
@interface CYShowVedioCell()
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property(nonatomic,assign)BOOL playBeginState;
@property(nonatomic,assign)BOOL isPause;

@end
@implementation CYShowVedioCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
    }
    return self;
}
-(void)confingSubViews{
    self.backgroundColor = GetColor(clearColor);
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
    
    UIImageView *deleteView = [UIImageView new];
    deleteView.backgroundColor = GetColor(redColor);
    
    deleteView.userInteractionEnabled = YES;
    UITapGestureRecognizer *deletetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteVedio)];
    [deleteView addGestureRecognizer:deletetap];
    [self addSubview:deleteView];

    
    playView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(30)
    .heightIs(30);
    
    deleteView.sd_layout
    .rightEqualToView(self)
    .topEqualToView(self)
    .widthIs(20)
    .autoHeightRatio(1);
    
    

}
-(void)playWith:(NSURL *)fileUrl{
    NSLog(@"play:%@",fileUrl);
    [self initPlayer:fileUrl];
    _fileUrl = fileUrl;
//    [self.player play];
}
-(void)playVedio{
    if ([self.delegate respondsToSelector:@selector(playVedioNow:)]) {
        [self.delegate playVedioNow:self.fileUrl];
    }
}
-(void)deleteVedio{
    if ([self.delegate respondsToSelector:@selector(deleteVedioNow)]) {
        [self.delegate deleteVedioNow];
    }
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

@end
