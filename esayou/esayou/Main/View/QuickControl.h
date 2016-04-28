//
//  QuickControl.h
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QuickControl : NSObject

//快速创建 label
+(UILabel *)labelWithFrame:(CGRect)frame
                     title:(NSString *)title
                       tag:(NSInteger)tag;
//快速创建 imageView
+(UIImageView *)imageViewWithFrame:(CGRect)frame
                         imageFile:(NSString *)file
                               tag:(NSInteger)tag;
//快速创建 button
+(UIButton *)buttonWithFrame:(CGRect)frame
                       title:(NSString *)title
             backgroundColor:(UIColor *)color
                      target:(id)target
                      action:(SEL)action
                         tag:(NSInteger)tag;
//快速创建 imageButton
+(UIButton *)imageButtonWithFrame:(CGRect)frame
                            title:(NSString*)title
                        imageFile:(NSString *)file
                           target:(id)target
                           action:(SEL)action
                              tag:(NSInteger)tag;
//快速创建 imageButton2
+(UIButton *)imageButtonWithFrame:(CGRect)frame
                            title:(NSString*)title
                  SelectImageFile:(NSString *)selectFile
                unselectImageFile:(NSString*)unselectFile
                           target:(id)target
                           action:(SEL)action
                              tag:(NSInteger)tag;
//快速创建 view
+(UIView *)viewWithFrame:(CGRect)frame
         backgroundColor:(UIColor *)color
                     tag:(NSInteger)tag;
//快速创建 tableView
+(UITableView *)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
                   backgroundColor:(UIColor *)color
                    separatorColor:(UIColor *)color
                          delegate:(id <UITableViewDelegate>)delegate
                        dataSource:(id <UITableViewDataSource>)dataSource;
//快速创建 scrollView
+(UIScrollView *)scrollViewWithFrame:(CGRect)frame
                         contentSize:(CGSize)size
                       contentOffset:(CGPoint)offset
                             bounces:(BOOL)bounces
                          horizontal:(BOOL)showHorizontal
                            vertical:(BOOL)showVertical
                       pagingEnabled:(BOOL)pagingEnabled
                            delegate:(id<UIScrollViewDelegate>)delegate;
//快速创建 pageControl
+(UIPageControl *)pageControlWithFrame:(CGRect)frame
                pageIndicatorTintColor:(UIColor *)color
         currentPageIndicatorTintColor:(UIColor *)currentColor
                         numberOfPages:(NSInteger)pageNum
                           currentPage:(NSInteger)currentPageNum;

//快速创建 alertView
+(UIAlertView *)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                          delegate:(id /*<UIAlertViewDelegate>*/)delegate
                 cancelButtonTitle:(NSString *)cancelTitle
                 otherButtonTitles:(NSString *)otherTitle;

//设置圆角
+(void)imageViewDrawRect:(UIView *)imagView andUIRectCorner:(UIRectCorner)rectCorner andSize:(NSInteger)size;


@end
