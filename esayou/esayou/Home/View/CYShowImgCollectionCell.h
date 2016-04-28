//
//  CYShowImgCollectionCell.h
//  tennisApp
//
//  Created by ESAY on 16/1/14.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYShowImgCollectionCellDelegate <NSObject>

@optional
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface CYShowImgCollectionCell : UICollectionViewCell
@property (nonatomic, weak)id<CYShowImgCollectionCellDelegate> deleteDelegate;
@property(nonatomic,strong)UIImageView *picImgView;
@property (nonatomic, strong)UIButton *deleteButton;
@property (nonatomic, strong)NSIndexPath *indexPath;
-(void)fillDataWith:(NSMutableArray *)array and:(NSIndexPath *)indexPath;
@end
