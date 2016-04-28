//
//  CYCollectionReusableFootView.h
//  esayou
//
//  Created by ESAY on 16/4/20.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYCollectionReusableFootViewDelegate<NSObject>
-(void)addImageOrVedio;
@end
@interface CYCollectionReusableFootView : UICollectionReusableView
@property (nonatomic, strong)UIButton *addBtn;
@property(nonatomic,strong)id<CYCollectionReusableFootViewDelegate> delegate;

@end
