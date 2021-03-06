//
//  ZZSearchDrugMessage.h
//  ProgrammerHealth
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZSearchDrugMessage : NSObject

/**
 *  药品ID
 */
@property (nonatomic,strong) NSNumber *ID;

/**
 *  药品标题
 */
@property (nonatomic,copy) NSString *title;

/**
 *  图片URL
 */
@property (nonatomic,copy) NSString *img;

/**
 *  药品介绍
 */
@property (nonatomic,copy) NSString *content;

/**
 *  类型
 */
@property (nonatomic,copy) NSString *type;


@end
