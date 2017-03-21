//
//  UIImage+Original.h
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Original)

/*
 *加载一个不要被渲染的图片
 */
 + (UIImage *)imageNamedWithOriginal:(NSString *)name;

@end
