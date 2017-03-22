//
//  SZHttpsRequest.m
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZHttpsRequest.h"

AFHTTPSessionManager *_mgr;
@implementation SZHttpsRequest

+ (void)postJSONWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure
{
    
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    // 请求参数传json给服务器
    _mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [_mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postHTTPWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure
{
    
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    _mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getJSONWithURL:(NSString *)url
                params:(id)params
               success:(void (^)(id responseJSON))success
               failure:(void (^)(NSError *error))failure;
{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    _mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [_mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




//TODO : 解析参数待更改！！
+ (void)postToUrlStr:(NSString *)urlString
   WithParameterDic:(NSDictionary *)dict
           Sucessful:(void (^)(NSDictionary *))Sucessful
             failure:(void (^)(NSString *))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[self serializeToUrlByDicString:dict] dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"网络请求失败");
            failure(@"当前网络不可用，\n请检查您的网络设置");
            return ;
        }
        else
        {
            NSError *error;
            NSDictionary *RequestDataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"解析失败");
                failure(@"解析失败");
            }
            else
            {
                if(RequestDataDict){
                    if ([RequestDataDict[@"code"] isEqual:@(0)]) {
                        NSLog(@"网络请求成功");
                        Sucessful(RequestDataDict);
                    }
                    else
                    {
                        NSLog(@"请求失败");
                        failure([NSString stringWithFormat:@"%@",RequestDataDict[@"code"]]);
                    }
                }
                else
                {
                    NSLog(@"服务器正在维护");
                    failure(@"服务器正在维护");
                }
            }
        }
    }];
    [task resume];
}

+ (NSString *)serializeToUrlByDicString:(NSDictionary *)dic
{
    NSString *result = @"";
    if (dic == nil || dic.count == 0)
    {
        return result;
    }
    for (id key in dic)
    {
        result = [NSString stringWithFormat:@"%@%@%@%@%@",result,key,@"=",dic[key],@"&"];
    }
    if (result.length > 0)
    {
        result = [result substringToIndex:result.length - 1];
    }
    return result;
}

+ (void)postToUrlStr:(NSString *)urlString
 WithparameterString:(NSString *)parameter
           Sucessful:(void (^)(NSDictionary *))Sucessful
             failure:(void (^)(NSString *))failure
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    NSString *para = parameter;
    //添加请求数据
    [request setHTTPBody:[para dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"网络请求失败");
            failure(@"当前网络不可用，\n请检查您的网络设置");
            return ;
        }
        else
        {
            NSError *error;
            NSDictionary *RequestDataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"解析失败");
                failure(@"解析失败");
            }
            else
            {
                if(RequestDataDict){
                    if ([RequestDataDict[@"code"] isEqual:@(0)]) {
                        NSLog(@"网络请求成功");
                        Sucessful(RequestDataDict);
                    }
                    else
                    {
                        NSLog(@"请求失败");
                        failure([NSString stringWithFormat:@"%@",RequestDataDict[@"code"]]);
                    }
                }
                else
                {
                    NSLog(@"服务器正在维护");
                    failure(@"服务器正在维护");
                }
            }
        }
    }];
    [task resume];
}

@end
