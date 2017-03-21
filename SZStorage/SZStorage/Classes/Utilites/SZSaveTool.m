//
//  SZSaveTool.m
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSaveTool.h"

@implementation SZSaveTool

+ (void)setObject:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (id)objectForKey:(NSString *)defaultNmae
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultNmae];
}

@end
