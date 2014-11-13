//
//  ZZUsualDrugNetwork.h
//  ProgrammerHealth
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZUsualDrugParmeter.h"
#import "ZZUsualDrugResult.h"


@interface ZZUsualDrugNetwork : NSObject

+ (void)usualDrugNetworkParmeters:(ZZUsualDrugParmeter *)parameter success:(void(^)(ZZUsualDrugResult *responseObject))success failure:(void(^)(NSError *error))error;

@end
