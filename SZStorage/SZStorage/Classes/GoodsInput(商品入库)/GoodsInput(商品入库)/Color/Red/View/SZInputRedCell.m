//
//  SZInputRedCell.m
//  SZStorage
//
//  Created by 吴园平 on 27/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZInputRedCell.h"

@interface SZInputRedCell ()
@property (weak, nonatomic) IBOutlet UILabel *SizeLabel;
//数量
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@end
static NSInteger quantity = 0;
@implementation SZInputRedCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    quantity = [_quantityLabel.text integerValue];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"inputRed";
    SZInputRedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

//数量加一
- (IBAction)addBtnClick
{
    quantity ++;
    _quantityLabel.text = [NSString stringWithFormat:@"%ld",(long)quantity];
}

//数量减一
- (IBAction)minusBtnClick
{
    quantity --;
    _quantityLabel.text = [NSString stringWithFormat:@"%ld",(long)quantity];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
