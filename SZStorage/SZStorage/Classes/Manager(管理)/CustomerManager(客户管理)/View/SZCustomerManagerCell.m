//
//  SZCustomerManagerCell.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCustomerManagerCell.h"
#import "SZCustomerItem.h"

@interface SZCustomerManagerCell ()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;

@end
@implementation SZCustomerManagerCell


- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"customer";
    SZCustomerManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setItem:(SZCustomerItem *)item
{
    if (item) {
        _shopNameLabel.text = item.customer_name;
        _PhoneLabel.text = item.customer_mobile;
//        _customerNameLabel.text = @"暂无";
    }
}


@end
