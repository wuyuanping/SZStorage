//
//  SZInputListController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZInputListController.h"

@interface SZInputListController ()

@end

@implementation SZInputListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"入库单";
    self.view.backgroundColor = SZColor(240, 240, 240);
    UIBarButtonItem *editBtn = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_入库单_新建入库") selImage:IMAGE_NAMED(@"icon_入库单_新建入库") target:self action:@selector(newBuildInputBtnClick)];
    self.navigationItem.rightBarButtonItem = editBtn;
}

- (void)newBuildInputBtnClick
{
    [SVProgressHUD showInfoWithStatus:@"待完善"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
