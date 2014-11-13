//
//  PHNetworkTool.h
//  ProgrammerHealth
//
//  Created by David on 11/7/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//  封装的网络请求工具类。

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

@interface PHNetworkTool : NSObject

/**
 *  工具类GET方法
 *
 *  @param urlStr    请求url的字符串
 *  @param parameter 请求参数,GET方法基本为空
 *  @param success   请求成功后执行的block
 *  @param failure   请求失败时执行的block
 */
+ (void)getWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(successBlock)success failure:(failureBlock)failure;

/**
 *  POST请求
 */
+ (void)postWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(successBlock)success failure:(failureBlock)failure;



@end
