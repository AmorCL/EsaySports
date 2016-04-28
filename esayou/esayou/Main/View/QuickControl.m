//
//  QuickControl.m
//  esayou
//
//  Created by ESAY on 16/3/4.
//  Copyright © 2016年 ESAY. All rights reserved.
//

#import "QuickControl.h"

@implementation QuickControl
//快速创建 label
+(UILabel *)labelWithFrame:(CGRect)frame
                     title:(NSString *)title
                       tag:(NSInteger)tag
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.tag = tag;
    return label;
}
//快速创建 imageView
+(UIImageView *)imageViewWithFrame:(CGRect)frame
                         imageFile:(NSString *)file
                               tag:(NSInteger)tag
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:file];
    imageView.tag =tag;
    return imageView;
}
//快速创建 button
+(UIButton *)buttonWithFrame:(CGRect)frame
                       title:(NSString *)title
             backgroundColor:(UIColor *)color
                      target:(id)target
                      action:(SEL)action
                         tag:(NSInteger)tag
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame =frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor =color;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag =tag;
    return button;
}
//快速创建 imageButton
+(UIButton *)imageButtonWithFrame:(CGRect)frame
                            title:(NSString*)title
                        imageFile:(NSString *)file
                           target:(id)target
                           action:(SEL)action
                              tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:file] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    return button;
}
//快速创建 imageButton2
+(UIButton *)imageButtonWithFrame:(CGRect)frame
                            title:(NSString*)title
                  SelectImageFile:(NSString *)selectFile
                unselectImageFile:(NSString*)unselectFile
                           target:(id)target
                           action:(SEL)action
                              tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectFile] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:unselectFile] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    return button;
}
//快速创建 view
+(UIView *)viewWithFrame:(CGRect)frame
         backgroundColor:(UIColor *)color
                     tag:(NSInteger)tag
{
    UIView *view =[[UIView alloc]initWithFrame:frame];
    view.backgroundColor =color;
    view.tag =tag;
    return view;
}
//快速创建 tableView
+(UITableView *)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
                   backgroundColor:(UIColor *)color
                    separatorColor:(UIColor *)sepColor
                          delegate:(id <UITableViewDelegate>)delegate
                        dataSource:(id <UITableViewDataSource>)dataSource
{
    UITableView *tableView =[[UITableView alloc]initWithFrame:frame style:style];
    tableView.backgroundColor =color;
    tableView.separatorColor =sepColor;
    tableView.delegate =delegate;
    tableView.dataSource =dataSource;
    return tableView;
}
//快速创建 scrollView
+(UIScrollView *)scrollViewWithFrame:(CGRect)frame
                         contentSize:(CGSize)size
                       contentOffset:(CGPoint)offset
                             bounces:(BOOL)bounces
                          horizontal:(BOOL)showHorizontal
                            vertical:(BOOL)showVertical
                       pagingEnabled:(BOOL)pagingEnabled
                            delegate:(id<UIScrollViewDelegate>)delegate
{
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:frame];
    scrollView.contentSize =size;
    scrollView.contentOffset =offset;
    scrollView.bounces =bounces;
    scrollView.showsHorizontalScrollIndicator =showHorizontal;
    scrollView.showsVerticalScrollIndicator =showVertical;
    scrollView.pagingEnabled =pagingEnabled;
    scrollView.delegate =delegate;
    return scrollView;
}
//快速创建 pageControl
+(UIPageControl *)pageControlWithFrame:(CGRect)frame
                pageIndicatorTintColor:(UIColor *)color
         currentPageIndicatorTintColor:(UIColor *)currentColor
                         numberOfPages:(NSInteger)pageNum
                           currentPage:(NSInteger)currentPageNum
{
    UIPageControl *pageControl =[[UIPageControl alloc]initWithFrame:frame];
    pageControl.pageIndicatorTintColor =color;
    pageControl.currentPageIndicatorTintColor =currentColor;
    pageControl.numberOfPages =pageNum;
    pageControl.currentPage =currentPageNum;
    return pageControl;
}

//快速创建 alertView
+(UIAlertView *)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                          delegate:(id)delegate
                 cancelButtonTitle:(NSString *)cancelTitle
                 otherButtonTitles:(NSString *)otherTitle
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    return alert;
}
+(void)imageViewDrawRect:(UIView *)imagView andUIRectCorner:(UIRectCorner)rectCorner andSize:(NSInteger)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imagView.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(size, size)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imagView.bounds;
    maskLayer.path = maskPath.CGPath;
    imagView.layer.mask = maskLayer;
}


@end
