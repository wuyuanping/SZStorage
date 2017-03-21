//
//  SZOrderController.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZOrderController.h"
#import "SZOrderCell.h"
#import "SZGoodsOutputController.h"

@interface SZOrderController ()
@property (nonatomic,strong) NSArray *ItemArray;
@end

@implementation SZOrderController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ItemArray = @[@"库存",@"日期",@"金额",@"名称"];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [super viewDidAppear:animated];
}

#pragma  mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZOrderCell *cell = [SZOrderCell cellWithTableView:tableView];
    cell.item = _ItemArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"按照 %@ 排序",_ItemArray[indexPath.row]);
    //匿名通知修改排序文字 并且隐藏排序tableView
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changOrder" object:nil userInfo:@{@"order": _ItemArray[indexPath.row]}];
}

@end
