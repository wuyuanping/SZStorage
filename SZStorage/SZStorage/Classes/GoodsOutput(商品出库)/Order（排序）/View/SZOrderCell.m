//
//  SZOrderCell.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZOrderCell.h"

@interface SZOrderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@property (weak, nonatomic) IBOutlet UILabel *OrderLabel;

@end

@implementation SZOrderCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const CELL = @"cell";
    SZOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setItem:(id)item
{
    _OrderLabel.text = item;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    _selectedImage.hidden = !selected;
    _OrderLabel.textColor = selected ? SZColor(44, 131, 248) : SZColor(122, 122, 122);
}

- (BOOL)isHighlighted
{
    return NO;
}


@end
