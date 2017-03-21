//
//  SZSaveTool.h
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZSaveTool : NSObject


/*
 * 根据key保存
 */
+ (void)setObject:(id)value forKey:(NSString *)key;

/*
 * 根据key取值
 */
+ (id)objectForKey:(NSString *)defaultNmae;

@end
