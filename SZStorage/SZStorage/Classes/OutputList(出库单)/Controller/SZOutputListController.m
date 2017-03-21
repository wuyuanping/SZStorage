//
//  SZOutputListController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZOutputListController.h"

@interface SZOutputListController ()

@end

@implementation SZOutputListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp
{
    self.navigationItem.title = @"出库单";
    self.view.backgroundColor = SZColor(240, 240, 240);
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
