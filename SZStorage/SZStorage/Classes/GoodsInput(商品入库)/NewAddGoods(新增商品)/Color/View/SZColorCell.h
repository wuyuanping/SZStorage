//
//  SZColorCell.h
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZColorCell : UITableViewCell

@property (nonatomic,strong) id item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
