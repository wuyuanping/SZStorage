//
//  SZWillVerifyStaffController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZWillVerifyStaffController.h"
#import "SZWillVerifStaffCell.h"

@interface SZWillVerifyStaffController ()

@end

@implementation SZWillVerifyStaffController

- (void)viewDidLoad
{
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZWillVerifStaffCell *cell = [SZWillVerifStaffCell cellWithTableView:tableView];
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
    //取消cell选中
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
