//
//  SZSupplierManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSupplierManagerController.h"
#import "SZSupplierManagerCell.h"
#import "SZSupplierDetailController.h"

@interface SZSupplierManagerController ()

@end

@implementation SZSupplierManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"供应商管理";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSupplierManagerCell *cell = [SZSupplierManagerCell cellWithTableView:tableView];
    //TODO
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSupplierDetailController *supplierDeVC = [[SZSupplierDetailController alloc] init];
    [self.navigationController pushViewController:supplierDeVC animated:YES];
}

@end
