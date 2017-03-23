//
//  SZStaffListController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZStaffListController.h"
#import "SZStaffListCell.h"
#import "SZStaffDetailController.h"
#import "SZLoginViewController.h"

@interface SZStaffListController ()

@end

@implementation SZStaffListController

- (void)viewDidLoad {
    [super viewDidLoad];
    

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
    SZStaffListCell *cell = [SZStaffListCell cellWithTableView:tableView];
    //TODO
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //崩溃？？？
    SZStaffDetailController *staffDetailVC = [[SZStaffDetailController alloc] init];
    [self.navigationController pushViewController:staffDetailVC animated:YES];
}

@end
