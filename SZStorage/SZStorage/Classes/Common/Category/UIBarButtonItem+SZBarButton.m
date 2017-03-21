//
//  UIBarButtonItem+SZBarButton.m
//  SZStorage
//
//  Created by 吴园平 on 21/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UIBarButtonItem+SZBarButton.h"

@implementation UIBarButtonItem (SZBarButton)

+ (instancetype)itemWithImage:(UIImage *)image
                   hightImage:(UIImage *)hightImage
                       target:(id)target
                       action:(SEL)action
{
    //1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    //2.监听按钮
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //3.防止自定义按钮点击范围扩大，在自定义按钮外面套一个UIView
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    
    //4.返回装有自定义按钮的自定义view的UIBarButtonItem对象
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (instancetype)itemWithImage:(UIImage *)image
                     selImage:(UIImage *)selImage
                       target:(id)target
                       action:(SEL)action
{
    //1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    //2.监听按钮
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //3.防止自定义按钮点击范围扩大，在自定义按钮外面套一个UIView
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    
    //4.返回装有自定义按钮的自定义view的UIBarButtonItem对象
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (instancetype)itemWithTitle:(NSString *)title color:(UIColor *)color 
                       action:(SEL)action
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSDictionary *attributes = @{NSFontAttributeName: SYSTEM_FONT(15)};
    CGSize size = [title sizeWithAttributes:attributes];
    //! 这里需要根据内容大小来调整宽度
    titleBtn.frame = CGRectMake(0, 0, size.width <= 10 ? 70 : size.width + 2, 44);
    [titleBtn setTitleColor:color forState:UIControlStateNormal];
    [titleBtn setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    titleBtn.titleLabel.font = SYSTEM_FONT(15);
    [titleBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:titleBtn.bounds];
    [view addSubview:titleBtn];
    //4.返回装有自定义按钮的自定义view的UIBarButtonItem对象
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}


@end
