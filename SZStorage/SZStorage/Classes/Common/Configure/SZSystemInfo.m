//
//  SZSystemInfo.m
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSystemInfo.h"

@implementation SZSystemInfo

//手机号
+ (BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//密码
+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//验证码
+ (BOOL)validateVerifyCode:(NSString *)verifyCode
{
    BOOL flag;
    if (verifyCode.length != 6) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{6})";
    NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [verifyCodePredicate evaluateWithObject:verifyCode];
}

//昵称 最长不得超过7个汉字，或20个字节(数字，字母和下划线)正则表达式
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{1,7}$|^[\\dA-Za-z_]{4,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

@end
