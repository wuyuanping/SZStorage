//
//  SZHttpsRequest.h
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZHttpsRequest : NSObject

/**
 *  发送一个POST JSON请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postJSONWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id responseJSON))success
                failure:(void (^)(NSError *error))failure;


/**
 *  发送一个POST JSON请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getJSONWithURL:(NSString *)url
                 params:(id)params
                success:(void (^)(id responseJSON))success
                failure:(void (^)(NSError *error))failure;





/**
 *  发送一个POST HTTP请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postHTTPWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id responseHTTP))success
                failure:(void (^)(NSError *error))failure;

/**
 *  post字典数据方法
 *
 *  @param urlString url字符串
 *  @param dict post请求需要传递的参数
 *  @param Sucessful 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)postToUrlStr:(NSString *)urlString
   WithParameterDic:(NSDictionary *)dict
           Sucessful:(void (^)(NSDictionary *))Sucessful
             failure:(void (^)(NSString *))failure;

/**
 *  post字符串数据方法
 *
 *  @param urlString url字符串
 *  @param parameter post请求需要传递的参数
 *  @param Sucessful 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)postToUrlStr:(NSString *)urlString
 WithparameterString:(NSString*)parameter
           Sucessful:(void (^)(NSDictionary *))Sucessful
             failure:(void (^)(NSString *))failure;



@end
