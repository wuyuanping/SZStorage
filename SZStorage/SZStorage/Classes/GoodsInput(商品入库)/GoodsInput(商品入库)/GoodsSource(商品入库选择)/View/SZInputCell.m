//
//  SZInputCell.m
//  SZStorage
//
//  Created by 吴园平 on 21/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZInputCell.h"

@interface SZInputCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selecedImage;

@end

@implementation SZInputCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"inputcell";
    SZInputCell *cell = [tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
