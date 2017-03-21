//
//  YPSearchBar.m
//  HXSearchBar
//
//  Created by 吴园平 on 13/03/2017.
//  Copyright © 2017 All rights reserved.
//

#import "YPSearchBar.h"

@implementation YPSearchBar

@synthesize placeholder = _placeholder;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([self respondsToSelector:@selector(barTintColor)]) {
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.1) {
                //ios7.1
                [[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
                [self setBackgroundColor:[UIColor clearColor]];
            }else{
                //ios7.0
                [self setBarTintColor:[UIColor clearColor]];
                [self setBackgroundColor:[UIColor clearColor]];
            }
        }else{
            //iOS7.0 以下
            [[self.subviews objectAtIndex:0] removeFromSuperview];
            [self setBackgroundColor:[UIColor clearColor]];
        }
    }
    self.tintColor=[UIColor blueColor]; //解决光标不出现的问题
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UITextField *textField = [self textField];
    if (UIEdgeInsetsEqualToEdgeInsets(_contentInset, UIEdgeInsetsZero)) {
        CGFloat x = 8, y = (CGRectGetHeight(self.bounds) - 28)/2.0, w = CGRectGetWidth(self.bounds) - 2 * 8, h = 28;
        textField.frame = CGRectMake(x, y, w, h);
    } else {
        textField.frame = CGRectMake(_contentInset.left, _contentInset.top, CGRectGetWidth(self.bounds) - _contentInset.left - _contentInset.right, CGRectGetHeight(self.bounds) - _contentInset.top - _contentInset.bottom);
    }
}

#pragma mark - setter
- (void)setTextFieldBackgroundColor:(UIColor *)textFieldBackgroundColor
{
    _textFieldBackgroundColor = textFieldBackgroundColor;
    UITextField *textField = [self textField];
    if ([textField isKindOfClass:[UITextField class]]) {
        UIColor *bgColor = _textFieldBackgroundColor;
        textField.backgroundColor = bgColor;
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    if (!_placeholder.length) {
        return;
    }
    [self updatePalceholder];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self updatePalceholder];
}

//设置输入框光标颜色
- (void)setCursorColor:(UIColor *)cursorColor
{
    if (cursorColor) {
        _cursorColor = cursorColor;
        //获取输入框
        UITextField *searchField = self.searchBarTextField;
        if (searchField) {
            //光标颜色
            [searchField setTintColor:cursorColor];
        }
    }
}

//设置清除按钮图标
- (void)setClearButtonImage:(UIImage *)clearButtonImage
{
    if (clearButtonImage) {
        _clearButtonImage = clearButtonImage;
        //获取输入框
        UITextField *searchField = self.searchBarTextField;
        if (searchField) {
            //设置清除按钮图片
            UIButton *button = [searchField valueForKey:@"_clearButton"];
            [button setImage:clearButtonImage forState:UIControlStateNormal];
            searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
}

- (void)setHideSearchBarBackgroundImage:(BOOL)hideSearchBarBackgroundImage
{
    if (hideSearchBarBackgroundImage) {
        _hideSearchBarBackgroundImage = hideSearchBarBackgroundImage;
        self.backgroundImage = [[UIImage alloc] init];
    }
}


- (void)updatePalceholder
{
    if (!_placeholderColor) {
        super.placeholder = _placeholder;
        return;
    }
    NSDictionary *attrs = @{NSForegroundColorAttributeName:_placeholderColor};
    [self textField].attributedPlaceholder = [[NSAttributedString alloc]initWithString:_placeholder attributes:attrs];
    //    self.barTintColor = _placeholderColor;
}


#pragma mark - public
- (UITextField *)textField
{
    for (UIView *view in self.subviews) {
        for (UIView *sView in view.subviews) {
            if ([sView isKindOfClass:[UITextField class]]) {
                return (UITextField *)sView;
            }
        }
    }
    return nil;
}

#pragma mark - getter
//获取输入框
- (UITextField *)searchBarTextField
{
    _searchBarTextField = [self valueForKey:@"searchField"];
    return _searchBarTextField;
}

//获取取消按钮
- (UIButton *)cancleButton
{
    self.showsCancelButton = YES;
    for (UIView *view in [[self.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            _cancleButton = (UIButton *)view;
        }
    }
    return _cancleButton;
}


/*
 .m文件中 使用如下：
 
 //添加搜索条
 - (void)addSearchBar {
     //加上 搜索栏
     YPSearchBar *searchBar = [[YPSearchBar alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 35)];
     searchBar.backgroundColor = [UIColor clearColor];
     searchBar.delegate = self;
     //输入框提示
     searchBar.placeholder = @"搜索材质";
     //光标颜色
     searchBar.cursorColor = [UIColor redColor];
     //TextField
     searchBar.searchBarTextField.layer.cornerRadius = 4;
     searchBar.searchBarTextField.layer.masksToBounds = YES;
     searchBar.searchBarTextField.layer.borderColor = [UIColor orangeColor].CGColor;
     searchBar.searchBarTextField.layer.borderWidth = 1.0;
     
     //清除按钮图标
     searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
     
     //去掉取消按钮灰色背景
     searchBar.hideSearchBarBackgroundImage = YES;
     
     [self.view addSubview:searchBar];
 }
 
 #pragma mark - UISearchBar Delegate
 
 //已经开始编辑时的回调
 - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar 
 {
     YPSearchBar *sear = (YPSearchBar *)searchBar;
     //取消按钮
     sear.cancleButton.backgroundColor = [UIColor clearColor];
     [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
     [sear.cancleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
     sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
 }
 
 //编辑文字改变的回调
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
 {
    NSLog(@"searchText:%@",searchText);
 }
 
 //搜索按钮
 - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
 {
 
 }
 
 //取消按钮点击的回调
 - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar 
 {
     searchBar.showsCancelButton = NO;
     searchBar.text = nil;
     [self.view endEditing:YES];
 }

 */

@end
