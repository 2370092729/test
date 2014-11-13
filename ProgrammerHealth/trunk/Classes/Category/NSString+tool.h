
//
//  Created by My Mac OS on 14-8-26.
//  Copyright (c) 2014年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (tool)

/**
 *  根据字符串的字体和size限制返回计算好的size
 *
 *  @param font    字体大小
 *  @param maxSize 某个方向上的size限制
 *
 *  @return 返回一个根据限制要求算出来的size
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

@end
