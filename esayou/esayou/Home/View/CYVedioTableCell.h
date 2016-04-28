//
//  CYVedioTableCell.h
//  esayou
//
//  Created by ESAY on 16/4/25.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "CYHomeLiveListModel.h"
@interface CYVedioTableCell : UITableViewCell
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic, copy) void (^playButtonClickedBlock)(NSIndexPath *indexPath);
@property(nonatomic,strong)NSIndexPath *indexpath;

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;
-(void)fillDataWith:(CYHomeLiveListModel *)model;
@end
