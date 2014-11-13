//
//  ZZSearchDrugNetwork.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZSearchDrugNetwork.h"
#import "PHNetworkTool.h"
#import "MJExtension.h"

@implementation ZZSearchDrugNetwork

+ (void)searchDrugNetworkParmeters:(ZZSearchDrugParmeter *)parmeter success:(void(^)(ZZSearchDrugResult *responseObject))success failure:(void(^)(NSError *error))error
{
    // 将参数模型转字典
    NSDictionary *parmeters = parmeter.keyValues;
    
    [PHNetworkTool getWithUrlString:@"http://api.yi18.net/drug/search" parameters:parmeters success:^(id responseObject) {
        
        // 将结果字典转模型
        ZZSearchDrugResult *result = [ZZSearchDrugResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *err) {
        if (error) {
            error(err);
        }
    }];
}

@end
