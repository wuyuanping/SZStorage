//
//  SZCustomerManagerCell.h
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZCustomerItem;
@interface SZCustomerManagerCell : UITableViewCell
@property (nonatomic,strong) SZCustomerItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
