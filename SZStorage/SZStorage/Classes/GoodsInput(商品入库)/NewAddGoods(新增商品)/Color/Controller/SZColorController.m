//
//  SZColorController.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZColorController.h"
#import "SZColorCell.h"

@interface SZColorController ()
@property (nonatomic,strong) NSArray *ItemArray;
@end

@implementation SZColorController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setup
{
    _ItemArray = @[@"白色",@"黑色",@"红色",@"灰色"];
    
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
    SZColorCell *cell = [SZColorCell cellWithTableView:tableView];
    cell.item = _ItemArray[indexPath.row];
    return cell;
}



@end
