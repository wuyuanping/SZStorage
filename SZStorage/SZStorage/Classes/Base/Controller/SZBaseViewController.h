//
//  SZBaseViewController.h
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RightItemBlock)(NSInteger index);

@interface SZBaseViewController : UIViewController

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, copy) RightItemBlock block;

/*
 *隐藏导航栏
 */
- (void)hideNavigationBar:(BOOL)hidden
                 animated:(BOOL)animated;

/*
 *导航栏LeftItem文字
 */
- (void)setLeftItemTitle:(NSString *)title
                  action:(SEL)action;

/*
 *导航栏LeftItem图片
 */
- (void)setLeftImageNamed:(NSString *)name
                   action:(SEL)action;

/*
 *导航栏RightItem文字和响应事件
 */
- (void)setRightItemTitle:(NSString *)title
                   action:(SEL)action;

/*
 *导航栏RightItem文字,颜色和响应事件
 */
- (void)setRightItemTitle:(NSString *)title
               titleColor:(UIColor *)color
                   action:(SEL)action;

/*
 *导航栏RightItem图片 和响应事件
 */
- (void)setRightImageNamed:(NSString *)name
                    action:(SEL)action;

/*
 *导航栏RightItem多个图片
 */
- (void)setupRightItems:(NSArray *)images;

/*
 *设置titleView图片
 */
- (void)setTitleView:(NSString *)imageName;

/*
 *设置默认navigationbar status bar 黑色
 */
//- (void)setDefaultNavigationBar;

/*
 *设置透明navigationbar status bar 黑色
 */
//- (void)setClearNavigationBar;

/*
 *设置返回按钮
 */
- (void)setBackItem;
- (void)setBackItemAction:(SEL)sel;
- (void)setBackItem:(NSString *)title
             action:(SEL)sel;

/*
 *设置导航栏背景图片 字体颜色
 */
- (void)setNavigationBarBackgroundImage:(UIImage *)image
                              tintColor:(UIColor *)tintColor
                              textColor:(UIColor *)textColor
                         statusBarStyle:(UIStatusBarStyle)style;
/*
 *push不隐藏tabbar
 */
- (void)pushController:(SZBaseViewController *)controller;

/*
 *push隐藏tabbar
 */
- (void)hideBottomBarPush:(SZBaseViewController *)controller;

/*
 *导航栏渐变
 */
- (void)setNavigationBarCover:(UIScrollView *)scrollView
                        color:(UIColor *)color;



@end
