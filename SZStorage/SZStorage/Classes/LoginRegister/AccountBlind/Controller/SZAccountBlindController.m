//
//  SZAccountBlindController.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZAccountBlindController.h"
#import "SZLoginViewController.h"
#import "SZTabBarController.h"
#import "SZCreatePersonalStorageController.h"
#import "SZJoinExitStorageController.h"

@interface SZAccountBlindController ()

@end

@implementation SZAccountBlindController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
}
//创建个人店铺
- (IBAction)createPersonalStorage
{
    SZCreatePersonalStorageController *createPerStorageVC = [[SZCreatePersonalStorageController alloc] init];  
    [UIApplication sharedApplication].keyWindow.rootViewController = createPerStorageVC;
}

//加入已经存在的店铺
- (IBAction)joinExitStorage
{
    SZJoinExitStorageController *exitStorageVC = [[SZJoinExitStorageController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = exitStorageVC;
}

- (IBAction)reBack
{
    //返回到登入界面
    SZLoginViewController *loginVC = [[SZLoginViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
