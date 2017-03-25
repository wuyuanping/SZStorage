//
//  SZColorCell.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZColorCell.h"

@interface SZColorCell ()
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;


@end

@implementation SZColorCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

 + (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"color";
    SZColorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setItem:(id)item
{
    _item = item;
    _colorLabel.text = item;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    _selectedImage.hidden = !selected;
    _colorLabel.textColor = selected ? SZColor(49, 148, 255) : SZColor(172, 172, 172);

}

@end
