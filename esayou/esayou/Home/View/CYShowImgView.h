//
//  CYShowImgView.h
//  tennisApp
//
//  Created by ESAY on 16/1/14.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShowImgCollectionCell.h"
#import "CYCollectionReusableFootView.h"
#import "CYShowVedioCell.h"
@class CYShowImgView;
@protocol CYShowImgViewDelegate <NSObject>
-(void)addImageOrVedioOrText;
-(void)playVedio:(NSURL *)url;
@optional


@end
@interface CYShowImgView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CYShowImgCollectionCellDelegate,CYCollectionReusableFootViewDelegate,CYShowVedioCellDelegate>
@property(nonatomic,weak)id<CYShowImgViewDelegate> delegate;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)BOOL isImage;
@property(nonatomic,strong)NSURL    *fileUrl;
@property(nonatomic,strong)CYShowVedioCell *cell ;
@property(nonatomic,assign)NSInteger vedioCount;

@end
