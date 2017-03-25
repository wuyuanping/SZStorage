//
//  SZOutputListCell.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZOutputListCell.h"

@interface SZOutputListCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLabel;
//出库单号
@property (weak, nonatomic) IBOutlet UILabel *outputListLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//联系人
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;


@end

@implementation SZOutputListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
   static NSString *const ID = @"list";
    SZOutputListCell *cell = [tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
