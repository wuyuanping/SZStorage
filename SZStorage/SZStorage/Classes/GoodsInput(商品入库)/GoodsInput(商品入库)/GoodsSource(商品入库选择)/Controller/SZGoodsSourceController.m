//
//  SZGoodsSourceController.m
//  SZStorage
//
//  Created by 吴园平 on 21/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsSourceController.h"
#import "SZGoodsInputCell.h"
#import "SZGoodsInputHeaderView.h"

@interface SZGoodsSourceController ()
{
    BOOL unshow[1];//判断是否展开的数组
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (!unshow[section]) {
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZGoodsInputCell *cell = [SZGoodsInputCell cellWithTableView:tableView];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点哦" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.tag = section;
    [btn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}

- (void)expand:(UIButton *)sender {
    NSInteger section = sender.tag;
    unshow[sender.tag] = !unshow[sender.tag];
    
    //重新加载
    NSIndexSet *indexset = [NSIndexSet  indexSetWithIndex:section];
    [_tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
    
}

@end
