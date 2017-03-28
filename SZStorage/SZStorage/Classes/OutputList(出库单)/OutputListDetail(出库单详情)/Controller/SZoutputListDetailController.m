//
//  SZoutputListDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 28/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZoutputListDetailController.h"

@interface SZoutputListDetailController ()

@end

@implementation SZoutputListDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"出库单详情";
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
