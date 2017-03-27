//
//  SZInputRedController.m
//  SZStorage
//
//  Created by 吴园平 on 27/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZInputRedController.h"
#import "SZInputRedCell.h"

@interface SZInputRedController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SZInputRedController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZInputRedCell *cell = [SZInputRedCell cellWithTableView:tableView];
    //TODO
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
