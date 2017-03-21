//
//  SZStaffDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZStaffDetailController.h"

@interface SZStaffDetailController ()

@end

@implementation SZStaffDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"员工详情";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
