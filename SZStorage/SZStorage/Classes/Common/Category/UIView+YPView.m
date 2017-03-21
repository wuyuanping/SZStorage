//
//  UIView+YPView.m
//  BuDeJie
//
//  Created by 吴园平 on 17/10/2016.
//  Copyright © 2016 WuYuanPing. All rights reserved.
//

#import "UIView+YPView.h"

@implementation UIView (YPView)

- (void)setYp_x:(CGFloat)yp_x
{
    CGRect frame = self.frame;
    frame.origin.x = yp_x;
    self.frame = frame;
}

- (CGFloat)yp_x{
    return self.frame.origin.x;
}

- (CGFloat)yp_y
{
    return self.frame.origin.y;
}
- (void)setYp_y:(CGFloat)yp_y
{
    CGRect frame = self.frame;
    frame.origin.y = yp_y;
    self.frame = frame;
}

- (CGFloat)yp_width
{
    return self.frame.size.width;
}

- (void)setYp_width:(CGFloat)yp_width
{
    CGRect frame = self.frame;
    frame.size.width = yp_width;
    self.frame = frame;
}

- (CGFloat)yp_height
{
    return self.frame.size.height;
}
- (void)setYp_height:(CGFloat)yp_height
{
    CGRect frame = self.frame;
    frame.size.height = yp_height;
    self.frame = frame;
}

- (CGFloat)yp_centerX
{
    return self.center.x;
}
- (void)setYp_centerX:(CGFloat)yp_centerX
{
    CGPoint center = self.center;
    center.x = yp_centerX;
    self.center = center;
}

- (CGFloat)yp_centerY
{
    return self.center.y;
}

- (void)setYp_centerY:(CGFloat)yp_centerY
{
    CGPoint center = self.center;
    center.y = yp_centerY;
    self.center = center;
}





@end
