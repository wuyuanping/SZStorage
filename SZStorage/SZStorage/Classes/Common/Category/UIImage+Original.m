//
//  UIImage+Original.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "UIImage+Original.h"

@implementation UIImage (Original)

+ (UIImage *)imageNamedWithOriginal:(NSString *)name
{
    UIImage *selImage = [UIImage imageNamed:name];
    //没有渲染的图片，覆盖原图片
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return selImage;
}


@end
