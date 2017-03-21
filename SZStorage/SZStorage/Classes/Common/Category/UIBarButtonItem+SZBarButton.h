//
//  UIBarButtonItem+SZBarButton.h
//  SZStorage
//
//  Created by 吴园平 on 21/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SZBarButton)


+ (instancetype)itemWithImage:(UIImage *)image
                   hightImage:(UIImage *)hightImage
                       target:(id)target
                       action:(SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image
                     selImage:(UIImage *)selImage
                       target:(id)target action:(SEL)action;

+ (instancetype)itemWithTitle:(NSString *)title
                        color:(UIColor *)color
                       action:(SEL)action;


@end
