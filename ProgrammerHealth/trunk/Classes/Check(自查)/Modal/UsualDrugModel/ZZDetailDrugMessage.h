//
//  ZZDetailDrugMessage.h
//  ProgrammerHealth
//
//  Created by Mac on 14-11-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZDetailDrugMessage : NSObject
/**
 *  long 药品ID
 */
@property (nonatomic,strong) NSNumber *ID;

/**
 *  string 药品标题
 */
@property (nonatomic,copy) NSString *name;

/**
 *  string 药品标签Tag
 */
@property (nonatomic,copy) NSString *tag;

/**
 *  string/text 药品详细内容
 */
@property (nonatomic,copy) NSString *message;

/**
 *  string 图片
 */
@property (nonatomic,copy) NSString *image;

/**
 *  int 浏览次数
 */
@property (nonatomic,strong) NSNumber *count;

/**
 *  string 编号
 */
@property (nonatomic,copy) NSString *ANumber;

/**
 *  string 药品类型
 */
@property (nonatomic,copy) NSString *PType;

/**
 *  string 药品分类
 */
@property (nonatomic,copy) NSString *categoryName;

/**
 *  long 分类ID
 */
@property (nonatomic,strong) NSNumber *category;

/**
 *  float 药品价格
 */
@property (nonatomic,strong) NSNumber *price;

/**
 *  string 药品厂商
 */
@property (nonatomic,copy) NSString *factory;


@end
