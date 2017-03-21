//
//  SZTruckOutController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZTruckOutController.h"

@interface SZTruckOutController ()

@end

@implementation SZTruckOutController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"出货车";
    self.view.backgroundColor = [UIColor redColor];
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
