//
//  ZZDetailDrugNetwork.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZDetailDrugNetwork.h"
#import "MJExtension.h"
#import "PHNetworkTool.h"
#import "FMDB.h"

@implementation ZZDetailDrugNetwork

static FMDatabase *_db;

+ (void)initialize
{
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"DetailDrug.sqlite"];
    // 得到数据库
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_detailDrug (id integer PRIMARY KEY AUTOINCREMENT, detailDrugDict blob NOT NULL,identifier integer NOT NULL);"];
        
        if (result) {
            MyLog(@"ZZDetailDrugNetwork---成功创表");
        }else
        {
            MyLog(@"ZZDetailDrugNetwork---创表失败");
        }
    }
    
}


+ (void)detailDrugNetworkParmeters:(ZZDetailDrugParmeter *)detailDrugParmeter success:(void(^)(ZZDetailDrugResult *responseObject))success failure:(void(^)(NSError *error))error
{
    // 从数据库中取数据
    ZZDetailDrugMessage *message = [self readCachedDetailDrugWithID:detailDrugParmeter.ID];
    
    if (message.ID) {// 如果数据库没有
        ZZDetailDrugResult *result = [[ZZDetailDrugResult alloc] init];
        result.detailDrugMessage = message;
        MyLog(@"数据库中的数据--detailDrugMessage");
        success(result);
    }else
    {
        // 将参数模型转字典
        NSDictionary *parmeters = detailDrugParmeter.keyValues;
        
        NSString *urlStr = NSStringFormat(@"http://api.yi18.net/drug/show?id=%@",detailDrugParmeter.ID);
        
        [PHNetworkTool getWithUrlString:urlStr parameters:parmeters success:^(id responseObject) {
            MyLog(@"%@",responseObject);
            MyLog(@"网络请求的数据--detailDrugMessage");
            // 存储到数据库
            [self saveDetailDrugWithDict:responseObject[@"yi18"] drugID:detailDrugParmeter.ID];
            
            // 将结果字典转模型
            ZZDetailDrugResult *detailDrugResult = [ZZDetailDrugResult objectWithKeyValues:responseObject];
            
            if (success) {
                success(detailDrugResult);
            }
            
        } failure:^(NSError *err) {
            if (error) {
                error(err);
            }
        }];
    }
    
    
    
}


#pragma mark 读取数据从数据库
+ (ZZDetailDrugMessage *)readCachedDetailDrugWithID:(NSNumber *)ID
{
    ZZDetailDrugMessage *detailDrugMessage = [[ZZDetailDrugMessage alloc] init];
    
    FMResultSet *resultSet =  [_db executeQuery:@"SELECT * FROM t_detailDrug WHERE identifier = ? ;",ID];
    
    
    while (resultSet.next) {
        // 从数据库拿到的为二进制数据
        NSData *data = [resultSet objectForColumnName:@"detailDrugDict"];
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        detailDrugMessage = [ZZDetailDrugMessage objectWithKeyValues:dict];
    }
    
    
    return detailDrugMessage;
}


#pragma mark 保存数据到数据库
+ (void)saveDetailDrugWithDict:(NSDictionary *)dict drugID:(NSNumber *)ID
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    [_db executeUpdate:@"INSERT INTO t_detailDrug (detailDrugDict, identifier) VALUES (?, ?);",data,ID];
}


@end
