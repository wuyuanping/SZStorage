//
//  SZSupplierManagerCell.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSupplierManagerCell.h"
#import "SZSupplierItem.h"

@interface SZSupplierManagerCell ()
//供应商名字
@property (weak, nonatomic) IBOutlet UILabel *supplierNameLabel;
//联系人名字
@property (weak, nonatomic) IBOutlet UILabel *connectNameLabel;
//联系人手机号
@property (weak, nonatomic) IBOutlet UILabel *connectPhoneLabel;

@end

@implementation SZSupplierManagerCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"cell";
    SZSupplierManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setItem:(SZSupplierItem *)item
{
    _supplierNameLabel.text = item.supplier_name;
    _connectNameLabel.text = item.contact;
    _connectPhoneLabel.text = item.contact_mobile;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
