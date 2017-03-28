//
//  SZGoodsSpecificationCell.m
//  SZStorage
//
//  Created by 吴园平 on 28/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsSpecificationCell.h"

@interface SZGoodsSpecificationCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *colorAndSizeLabel;
//成本
@property (weak, nonatomic) IBOutlet UITextField *costFiled;
//批发价
@property (weak, nonatomic) IBOutlet UITextField *piFaFiled;
//库存
@property (weak, nonatomic) IBOutlet UITextField *storageFiled;

@end

@implementation SZGoodsSpecificationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    _costFiled.userInteractionEnabled = NO;
    _piFaFiled.userInteractionEnabled = NO;
    _storageFiled.delegate = self;
}

- (void)setFrame:(CGRect)frame
{
    //生成分割线
    frame.size.height -= 1;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"speci";
    SZGoodsSpecificationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setItem:(id)item
{
    _item = item;
    _colorAndSizeLabel.text = _item;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _storageFiled.placeholder = _storageFiled.text;
    //提交数据至服务器
}

@end
