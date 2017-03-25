//
//  SZOutputCell.m
//  SZStorage
//
//  Created by 吴园平 on 17/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZOutputCell.h"

@interface SZOutputCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageSumLabel;

@end
static NSString * const ID = @"cell";
@implementation SZOutputCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    SZOutputCell *cell = [tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
