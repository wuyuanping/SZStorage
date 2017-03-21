//
//  SZSortKindButton.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSortKindButton.h"

@implementation SZSortKindButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
    self.titleLabel.textColor = [UIColor blackColor];
}

//调整按钮里面子控件位置：左边是文字，右边是图片
- (void)layoutSubviews
{
    [super layoutSubviews];
    //因为系统布局控件自己和里面子控件均会调用一次，故会调用两次,按理说第一次加载按钮的View时是没有子控件的，但调用方法时，会懒加载子控件，故会受影响
    if (self.titleLabel.yp_x > self.imageView.yp_x) {
        self.titleLabel.yp_x = self.imageView.yp_x;
        self.imageView.yp_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    }
}

@end
