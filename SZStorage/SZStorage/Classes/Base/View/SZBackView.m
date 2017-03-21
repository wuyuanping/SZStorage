//
//  SZBackView.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZBackView.h"

@implementation SZBackView


+ (instancetype)backViewWithImage:(UIImage *)image
                        highImage:(UIImage *)highImage
                           target:(id)target
                           action:(SEL)action
                            title:(NSString *)title
{
    //1.创建按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //2.设置按钮属性
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    
    //3.监听按钮点击
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //4.将按钮添加进自定义View（按钮外面包装一个UIView可以防止自定义按钮点击范围扩大）
    SZBackView *view = [[self alloc] initWithFrame:backButton.bounds];
    [view addSubview:backButton];
    return view;
}

@end
