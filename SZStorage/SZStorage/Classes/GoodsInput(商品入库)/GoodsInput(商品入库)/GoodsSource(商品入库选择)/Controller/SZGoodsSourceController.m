//
//  SZGoodsSourceController.m
//  SZStorage
//
//  Created by 吴园平 on 21/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsSourceController.h"
#import "SZGoodsInputCell.h"

@interface SZGoodsSourceController ()

@end

@implementation SZGoodsSourceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZGoodsInputCell *cell = [SZGoodsInputCell cellWithTableView:tableView];
    //TODO
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath) {
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  140;
}


@end
