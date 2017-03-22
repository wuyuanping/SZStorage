//
//  SZTabBarController.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZTabBarController.h"
#import "SZTruckOutController.h"
#import "SZGoodsOutputController.h"
#import "SZGoodsInputController.h"
#import "SZOutputListController.h"
#import "SZManagerController.h"

@interface SZTabBarController ()

@property (nonatomic, strong) NSMutableArray *controllerArray;

@end

@implementation SZTabBarController

#pragma mark - lazy load
- (NSMutableArray *)controllerArray
{
    if (!_controllerArray) {
        _controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
//    [self addAllChildVC];
//    [self setupaAllTabBarButton];
}

- (void)setup
{
    SZTruckOutController *truckVC = [[SZTruckOutController alloc]init];
    truckVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"出货车" image:IMAGE_NAMED(@"icon_底部栏_出货车_正常") selectedImage:[IMAGE_NAMED(@"icon_底部栏_出货车_选中") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    SZBaseNavigationController *oneNav = [[SZBaseNavigationController alloc]initWithRootViewController:truckVC];
    
    SZGoodsOutputController *GoodsOutVC = [[SZGoodsOutputController alloc]init];
    GoodsOutVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商品出库" image:IMAGE_NAMED(@"icon_底部栏_出库_正常") selectedImage:[IMAGE_NAMED(@"icon_底部栏_出库_选中") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    SZBaseNavigationController *twoNav = [[SZBaseNavigationController alloc]initWithRootViewController:GoodsOutVC];
    
    SZGoodsInputController *GoodsInVC = [[SZGoodsInputController alloc]init];
    GoodsInVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商品入库" image:IMAGE_NAMED(@"icon_底部栏_入库_正常") selectedImage:[IMAGE_NAMED(@"icon_底部栏_入库_选中") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    SZBaseNavigationController *threeNav = [[SZBaseNavigationController alloc]initWithRootViewController:GoodsInVC];
    
    SZOutputListController *OutListVC = [[SZOutputListController alloc]init];
    OutListVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"出库单" image:IMAGE_NAMED(@"icon_底部栏_出库单_正常") selectedImage:[IMAGE_NAMED(@"icon_底部栏_出库单_选中") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    SZBaseNavigationController *fourNav = [[SZBaseNavigationController alloc]initWithRootViewController:OutListVC];
    
    SZManagerController *ManagerVC = [[SZManagerController alloc]init];
    ManagerVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"管理" image:IMAGE_NAMED(@"icon_底部栏_管理_正常") selectedImage:[IMAGE_NAMED(@"icon_底部栏_管理_选中") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    SZBaseNavigationController *fiveNav = [[SZBaseNavigationController alloc]initWithRootViewController:ManagerVC];
    self.viewControllers = @[oneNav,twoNav,threeNav,fourNav,fiveNav];

}



//- (void)addAllChildVC
//{
//    NSArray *childrenVCName = @[@"SZTruckOutController",
//                                @"SZGoodsOutputController",
//                                @"SZGoodsInputController",
//                                @"SZOutputListController",
//                                @"SZManagerController"
//                                ];
//    for (NSString *childVC in childrenVCName) {
//        UIViewController *vc = [[NSClassFromString(childVC) alloc] init];
//        SZBaseNavigationController *naVC = [[SZBaseNavigationController alloc] initWithRootViewController:vc];
//        [self addChildViewController:naVC];
//    }
//}

//- (void)setupaAllTabBarButton
//{
//    //第0个按钮
//    SZBaseNavigationController *nav = self.childViewControllers[0];
//    nav.tabBarItem.title = @"出货车";
//    nav.tabBarItem.image = IMAGE_NAMED(@"icon_底部栏_出货车_正常");
//    nav.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"icon_底部栏_出货车_选中"];
//    
//    //第1个按钮
//    SZBaseNavigationController *nav1 = self.childViewControllers[1];
//    nav1.tabBarItem.title = @"商品出库";
//    nav1.tabBarItem.image = IMAGE_NAMED(@"icon_底部栏_出库_正常");
//    nav1.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"icon_底部栏_出库_选中"];
//    
//    //第2个按钮
//    SZBaseNavigationController *nav2 = self.childViewControllers[2];
//    nav2.tabBarItem.title = @"商品入库";
//    nav2.tabBarItem.image = IMAGE_NAMED(@"icon_底部栏_入库_正常");
//    nav2.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"icon_底部栏_入库_选中"];
//    
//    
//    //第3个按钮
//    SZBaseNavigationController *nav3 = self.childViewControllers[3];
//    nav3.tabBarItem.title = @"出库单";
//    nav3.tabBarItem.image = IMAGE_NAMED(@"icon_底部栏_出库单_正常");
//    nav3.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"icon_底部栏_出库单_选中"];
//    
//    //第4个按钮
//    SZBaseNavigationController *nav4 = self.childViewControllers[4];
//    nav4.tabBarItem.title = @"管理";
//    nav4.tabBarItem.image = IMAGE_NAMED(@"icon_底部栏_管理_正常");
//    nav4.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"icon_底部栏_管理_选中"];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//- (SZBaseNavigationController *)subControllerFor:(nullable Class)aClass
//{
//    SZBaseNavigationController *nav = [[SZBaseNavigationController alloc]initWithRootViewController:[[aClass alloc]init]];
//    return nav;
//}


@end
