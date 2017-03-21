//
//  YPSearchBar.h
//  HXSearchBar
//
//  Created by 吴园平 on 13/03/2017.
//  Copyright © 2017 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPSearchBar : UISearchBar

/** 光标颜色 */
@property (nonatomic,strong) UIColor *cursorColor;
/** 搜索框TextField */
@property (nonatomic,strong) UITextField *searchBarTextField;
/** 输入框清除按钮图片 */
@property (nonatomic,strong) UIImage *clearButtonImage;
/** 隐藏SearchBar背景灰色部分 默认显示 */
@property (nonatomic,assign) BOOL hideSearchBarBackgroundImage;
/** 取消按钮 showsCancelButton = YES 才能获取到 */
@property (nonatomic,strong) UIButton *cancleButton;
/** 搜索区背景颜色 */
@property (nonatomic, strong) UIColor *textFieldBackgroundColor;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
//可变高度，半透明
@property (nonatomic, assign) UIEdgeInsets contentInset;

/** 获取UITextField */
- (UITextField *)textField;





@end
