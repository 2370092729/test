//
//  ZZSearchDrugMessage.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZSearchDrugMessage.h"

@implementation ZZSearchDrugMessage

// 告诉模型里面的ID对应着字典里面的id
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end
