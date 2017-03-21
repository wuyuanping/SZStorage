//
//  SZWeChatLoginController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZWeChatLoginController.h"
#import "SZTabBarController.h"
#import "SZSaveTool.h"

@interface SZWeChatLoginController ()

@end

@implementation SZWeChatLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)WeChatLogin
{
    SZTabBarController *tabVC = [[SZTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
    [SZSaveTool setObject:isLogined forKey:kSZIsLogined];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
