//
//  CYShowVedioCell.h
//  esayou
//
//  Created by ESAY on 16/4/22.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYShowVedioCellDelegate <NSObject>
@optional
-(void)playVedioNow:(NSURL *)fileUrl;
-(void)deleteVedioNow;
@end
@interface CYShowVedioCell : UICollectionViewCell
@property(nonatomic,strong)id<CYShowVedioCellDelegate> delegate;
@property(nonatomic,strong)NSURL *fileUrl;


-(void)playWith:(NSURL *)fileUrl;

@end
