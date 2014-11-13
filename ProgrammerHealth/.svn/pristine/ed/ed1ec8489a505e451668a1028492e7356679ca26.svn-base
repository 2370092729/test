//
//  PHNetworkTool.m
//  ProgrammerHealth
//
//  Created by David on 11/7/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "PHNetworkTool.h"
#import "AFNetworking.h"

@implementation PHNetworkTool

+ (void)getWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(successBlock)success failure:(failureBlock)failure
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"网络GET请求失败.%@",error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)postWithUrlString:(NSString *)urlStr parameters:(NSDictionary *)parameter success:(successBlock)success failure:(failureBlock)failure
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:urlStr parameters:(NSDictionary *)parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"网络POST请求失败.%@",error.localizedDescription);
        if (failure) {
            failure(error);
        }
        
    }];
}


@end
