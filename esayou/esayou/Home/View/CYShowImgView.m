//
//  CYShowImgView.m
//  tennisApp
//
//  Created by ESAY on 16/1/14.
//  Copyright (c) 2016年 ESAY. All rights reserved.
//

#import "CYShowImgView.h"
@implementation CYShowImgView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing=10;
    flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flow];
    [_collectionView registerClass:[CYShowImgCollectionCell class] forCellWithReuseIdentifier:@"CYShowImgCell"];
    [self.collectionView registerClass:[CYCollectionReusableFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"aroundCollectionFoot"];
    [self.collectionView registerClass:[CYShowVedioCell class] forCellWithReuseIdentifier:@"CYShowVedioCell"];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = GetColor(whiteColor);
    flow.itemSize=CGSizeMake((kScreenWidth-60)/5,(kScreenWidth-60)/5);
    [self addSubview:_collectionView];
}
#pragma mark  每一组返回多少行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!_isImage) {
        return _vedioCount;
    }
    NSLog(@"cllection:%ld",self.dataArray.count);
    return _dataArray.count;
}
#pragma mark 返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 返回单元
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isImage) {
        _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYShowVedioCell" forIndexPath:indexPath];
        [_cell playWith:self.fileUrl];
        _cell.delegate = self;
        return _cell;
    }else{
        CYShowImgCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CYShowImgCell" forIndexPath:indexPath];
        [cell fillDataWith:self.dataArray and:indexPath];
        //    NSLog(@"cell2%@",cell.datas);
        cell.deleteDelegate = self;
        return cell;
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CYCollectionReusableFootView *resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"aroundCollectionFoot" forIndexPath:indexPath];
    resuableView.delegate = self;
    resuableView.backgroundColor = GetColor(whiteColor);
    return resuableView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake((kScreenWidth-60)/5, (kScreenWidth-60)/5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
#pragma mark ----------------- 删除cell ---------------------
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
    
    //删除之后更新collectionView上对应cell的indexPath
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CYShowImgCollectionCell *cell = (CYShowImgCollectionCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
    }

}
-(void)addImageOrVedio{
    NSLog(@"点击");
    if ([self.delegate respondsToSelector:@selector(addImageOrVedioOrText)]) {
        [self.delegate addImageOrVedioOrText];
    }
}
#pragma mark--播放和删除视频--
-(void)deleteVedioNow{
    NSLog(@"删除视频");
    _vedioCount = 0;
    [self.collectionView reloadData];
}
-(void)playVedioNow:(NSURL *)fileUrl{
    NSLog(@"播放视频");
    if ([self.delegate respondsToSelector:@selector(playVedio:)]) {
        [self.delegate playVedio:fileUrl];
    }
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = [NSMutableArray array];
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
-(void)setFileUrl:(NSURL *)fileUrl{
    _fileUrl = fileUrl;
    [_cell playWith:fileUrl];
    [self.collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
