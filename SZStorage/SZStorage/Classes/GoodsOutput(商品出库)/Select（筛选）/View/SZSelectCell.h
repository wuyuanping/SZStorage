//
//  SZSelectCell.h
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZSelectCell : UITableViewCell
@property (nonatomic,strong)id Item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
