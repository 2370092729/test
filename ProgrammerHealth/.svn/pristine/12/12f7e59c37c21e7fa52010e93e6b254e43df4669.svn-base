//
//  ZZUsualDrugNetwork.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZUsualDrugNetwork.h"
#import "PHNetworkTool.h"
#import "MJExtension.h"
#import "FMDB.h"
#import "ZZDrugMessage.h"

@implementation ZZUsualDrugNetwork

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"UsualDrug.sqlite"];
    // 得到数据库
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open]) {
        // 创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_usualDrug (id integer PRIMARY KEY AUTOINCREMENT, usualDrugDict blob NOT NULL,page integer NOT NULL);"];
        
        if (result) {
            MyLog(@"ZZUsualDrugNetwork---成功创表");
        } else {
            MyLog(@"ZZUsualDrugNetwork---创表失败");
        }
    }
}


+ (void)usualDrugNetworkParmeters:(ZZUsualDrugParmeter *)usualDrugParmeter success:(void(^)(ZZUsualDrugResult *responseObject))success failure:(void(^)(NSError *error))error
{
    // 首先从数据库中取数据
    NSArray *yi18 = [self readCachedUsualDrugDictPage:usualDrugParmeter.page];
    if (yi18.count != 0) { // 有数据
        
        ZZUsualDrugResult *usualDrugResult = [[ZZUsualDrugResult alloc] init];
        usualDrugResult.yi18 = yi18;
        MyLog(@"数据库中的数据--detailDrugMessage");
        
        // 模拟延迟加载
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            success(usualDrugResult);
        });
        
    }else // 没有数据
    {
        // 将参数模型转字典
        NSDictionary *parmeters = usualDrugParmeter.keyValues;
        
        [PHNetworkTool getWithUrlString:@"http://api.yi18.net/drug/list" parameters:parmeters success:^(id responseObject) {
            MyLog(@"网络请求的数据--detailDrugMessage");
            NSArray *array = responseObject[@"yi18"];
            
            // 存储到数据库
            [self saveUsualDrugDictArray:array page:usualDrugParmeter.page];
            
            // 将结果字典转模型
            ZZUsualDrugResult *usualDrugResult = [ZZUsualDrugResult objectWithKeyValues:responseObject];
            
            if (success) {
                success(usualDrugResult);
            }
            
        } failure:^(NSError *err) {
            if (error) {
                error(err);
            }
        }];
    }
    
    
    
    
}
#pragma mark 读取从数据库
+ (NSArray *)readCachedUsualDrugDictPage:(NSNumber *)page
{
    // 新建一个存放模型的数组
    NSMutableArray *modelArrM = [NSMutableArray array];
    
    FMResultSet *resultset = nil;
    
    resultset = [_db executeQuery:@"SELECT * FROM t_usualDrug WHERE page = ? ;",page];
    
    while (resultset.next) {
        NSData *data = [resultset objectForColumnName:@"usualDrugDict"];
        
        NSDictionary *usualDrugDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        // 字典转模型
        ZZDrugMessage *drugMessage = [ZZDrugMessage objectWithKeyValues:usualDrugDict];
        
        [modelArrM addObject:drugMessage];
    }
    
    return modelArrM;
}


#pragma mark 存储到数据库
+ (void)saveUsualDrugDictArray:(NSArray *)array page:(NSNumber *)page
{
    for (NSDictionary *dict in array) {
        // 将字典序列化成二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        [_db executeUpdate:@"INSERT INTO t_usualDrug (usualDrugDict, page) VALUES (?, ?);",data,page];
    }
}


@end
