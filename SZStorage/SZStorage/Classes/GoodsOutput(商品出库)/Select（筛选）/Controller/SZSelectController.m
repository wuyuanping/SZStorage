//
//  SZSelectController.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSelectController.h"
#import "SZSelectCell.h"

@interface SZSelectController ()
@property (nonatomic,strong) NSArray *selectArray;
@end

@implementation SZSelectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _selectArray = @[@"全部",@"T恤",@"上衣",@"裙子"];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSelectCell *cell = [SZSelectCell cellWithTableView:tableView];
    cell.Item = _selectArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //通知隐藏筛选tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selected" object:nil];
}


@end
