//
//  SZFileManager.m
//  SZStorage
//
//  Created by 吴园平 on 13/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZFileManager.h"

@implementation SZFileManager

+ (void)directorySizeString:(NSString *)directoryPath
                 completion:(void(^)(NSString * ))strCompletion
{
    [SZFileManager getDirectorySize:directoryPath completion:^(int totalSize) {
        
        NSInteger size = totalSize;
        NSString *str = @"清除缓存";
        if (size > 1000 * 1000) { // MB
            CGFloat sizeF = size / 1000.0 / 1000.0;
            str = [NSString stringWithFormat:@"%@(%.1fMB)",str,sizeF];
        } else if (size > 1000) { // KB
            CGFloat sizeF = size / 1000.0;
            str = [NSString stringWithFormat:@"%@(%.1fKB)",str,sizeF];
        } else if (size > 0) { // B
            str = [NSString stringWithFormat:@"%@(%ldB)",str,size];
        }
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        if (strCompletion) {
            strCompletion(str);
        }
    }];
}

+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    // 创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExists || !isDirectory) {
        // 报错:抛异常
        @throw  [NSException exceptionWithName:@"FileError" reason:@"小笨蛋，传入文件夹路径不存在，或者不是文件夹" userInfo:nil];
    }
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (void)getDirectorySize:(NSString *)directoryPath
              completion:(void(^)(int))completion
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //1.创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        //2.容错处理
        BOOL isDirectory = NO;
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isExists || !isDirectory) {
            NSException *excp = [NSException exceptionWithName:@"FileError" reason:@"小笨蛋，传入文件夹路径不存在，或者不是文件夹" userInfo:nil];
            [excp raise];
        }
        
        //3.累加指定文件路径下的所有“子路径文件大小”
        NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
        int totalSize = 0;
        for (NSString *subPath in subpaths) {
            
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // ①忽略隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // ②容错处理：文件夹路径不存在 或 仅仅是目录也忽略
            BOOL isDirectory = NO;
            BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExists || isDirectory) continue;
            
            // ③获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize += [attr fileSize];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
}


@end
