//
//  SZPropertySettingController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZPropertySettingController.h"

@interface SZPropertySettingController ()

@end

@implementation SZPropertySettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"属性管理";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
