//
//  SZBaseTableView.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZBaseTableView.h"

@implementation SZBaseTableView

// tableView有内容才显示
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
//}

////取消cell高亮状态
//- (void)setHighlighted:(BOOL)highlighted
//              animated:(BOOL)animated
//{
//}


@end
