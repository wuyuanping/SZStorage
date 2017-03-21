//
//  SZCustomerDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCustomerDetailController.h"

@interface SZCustomerDetailController ()

@end

@implementation SZCustomerDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"客户详情";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
