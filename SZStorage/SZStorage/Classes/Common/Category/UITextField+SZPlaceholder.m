//
//  UITextField+SZPlaceholder.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UITextField+SZPlaceholder.h"

@implementation UITextField (SZPlaceholder)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";//当没有占位文字就赋给一个空格，确保可以懒加载到placeholderLabel控件，这样才可以设置占位文字颜色
    }
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];//通过断点拿到属性placeholderLabel，再通过kvc获得占位文字。
    //    NSLog(@"%@",placeholderLabel);//测验后：只有设置占位空格后，即使没有占位字符也可以拿到占位控件placeholderLabel。更严谨。
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    return placeholderLabel.textColor;
}

@end
