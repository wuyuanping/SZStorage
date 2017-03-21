//
//  SZButton.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZButton.h"

@implementation SZButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //自定义有圆角的按钮
    self.layer.cornerRadius = 7;
    self.backgroundColor = SZColor(255, 255, 255);
}

//调整按钮里面子控件位置：上边是文字，下边是图片
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.bounds.size.width, 150);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 185, self.bounds.size.width, 30);
}



@end
