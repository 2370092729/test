//
//  ZZSearchDrugNetwork.h
//  ProgrammerHealth
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZSearchDrugParmeter.h"
#import "ZZSearchDrugResult.h"

@interface ZZSearchDrugNetwork : NSObject


+ (void)searchDrugNetworkParmeters:(ZZSearchDrugParmeter *)parmeter success:(void(^)(ZZSearchDrugResult *responseObject))success failure:(void(^)(NSError *error))error;

@end
