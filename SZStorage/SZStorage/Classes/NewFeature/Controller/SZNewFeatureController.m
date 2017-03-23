//
//  SZNewFeatureController.m
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZNewFeatureController.h"
#import "SZTabBarController.h"
#import "SZRegisterViewController.h"

@interface SZNewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIPageControl *pageControl;

@end

@implementation SZNewFeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI
{
    //1.添加滑动页和按钮
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(3 * SCREEN_W, SCREEN_H);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    NSArray *imageNames = @[@"onepage.jpg",@"twopage.jpg",@"threepage.jpg"];
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H)];
        imageView.image = IMAGE_NAMED(imageNames[i]);
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5;
    btn.frame = CGRectMake((SCREEN_W - 120) * 0.5, SCREEN_H - 100, 120, 40);
    [btn setTitle:@"进入速致仓储" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(enterApp) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageV = [self.view viewWithTag:2];
    [imageV addSubview:btn];
    
    //2.添加UIPageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_W - 60) * 0.5, SCREEN_H - 50, 60, 40)];
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_pageControl];
    
    //3.取消状态栏
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)enterApp
{
    SZRegisterViewController *registerVC = [[SZRegisterViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = registerVC;
}

#pragma mark - UIScrollViewDelegate
//当scrollview滚动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / SCREEN_W;
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
