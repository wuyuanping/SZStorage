//
//  SZBaseNavigationController.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZBaseNavigationController.h"

@interface SZBaseNavigationController ()

@end

@implementation SZBaseNavigationController

+ (void)initialize
{
    //设置导航条统一的样式
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[SZBaseNavigationController class]]];
//    bar.barTintColor = SZColor(50, 48, 54);

    //设置背景图片
//    [bar setBackgroundImage:IMAGE_NAMED(@"icon_导航条") forBarMetrics:UIBarMetricsDefault];
    //设置标题的文字
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                            }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.shadowImage = [UIImage new];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        // 非根控制器时隐藏导航条
        viewController.hidesBottomBarWhenPushed = YES;
        //设置左边返回按钮
        SZBackView *backView = [SZBackView backViewWithImage:IMAGE_NAMED(@"icon_顶部栏_返回") highImage:IMAGE_NAMED(@"icon_顶部栏_返回") target:self action:@selector(back) title:nil];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        
    }
    [viewController.navigationController.navigationBar setBackgroundImage:IMAGE_NAMED(@"icon_导航条") forBarMetrics:UIBarMetricsDefault];
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
       return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
