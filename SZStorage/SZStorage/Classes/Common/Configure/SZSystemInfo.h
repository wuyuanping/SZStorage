//
//  SZSystemInfo.h
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef kScreenBounds
#define kScreenBounds [UIScreen mainScreen].bounds
#endif

#ifndef SCREEN_W
#define SCREEN_W kScreenBounds.size.width
#endif

#ifndef SCREEN_H
#define SCREEN_H kScreenBounds.size.height
#endif

#ifndef kDefaultColor
#define kDefaultColor SZColor(46,144,255)
#endif

#ifndef SZColor
#define SZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#endif

#ifndef kNavigationBarHeight
#define kNavigationBarHeight 64.0
#endif

#ifndef kTabBarHeight
#define kTabBarHeight 49.0
#endif

#ifndef SYSTEM_FONT
#define SYSTEM_FONT(__fontsize__)\
[UIFont systemFontOfSize:__fontsize__]
#endif

#ifndef IMAGE_NAMED
#define IMAGE_NAMED(__imageName__)\
[UIImage imageNamed:__imageName__]
#endif

#ifndef NIB_NAMED
#define NIB_NAMED(__nibName__)\
[UINib nibWithNibName:__nibName__ bundle:nil]
#endif

#ifndef SystemVersion
#define SystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#endif

#ifndef YPWeakSelf
#define YPWeakSelf __weak typeof(self) weakSelf = self;
#endif

#ifndef YPStrongSelf 
#define YPStrongSelf __strong typeof(self) strongSelf = weakSelf;
#endif

#ifndef kSZIsLogined
#define kSZIsLogined @"kSZIsLogined"
#endif

#ifndef isLogined
#define isLogined  @"isLogined"
#endif

#ifdef DEBUG //调试
#define YPLog (...) NSLog(__VA_ARGS__)
#else //发布
#define YPLog (...)
#endif

#ifndef IsEmptyStr
#define  IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO
#endif
@interface SZSystemInfo : NSObject

/*
 *手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/*
 *密码
 */
+ (BOOL)validatePassword:(NSString *)passWord;

/*
 *验证码
 */
+ (BOOL)validateVerifyCode:(NSString *)verifyCode;

/*
 *昵称
 */
+ (BOOL)validateNickname:(NSString *)nickname;


@end
