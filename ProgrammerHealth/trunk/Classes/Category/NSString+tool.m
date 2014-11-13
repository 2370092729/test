//
//  NSString+tool.m
//
//  Created by My Mac OS on 14-8-26.
//  Copyright (c) 2014年 David. All rights reserved.
//

#import "NSString+tool.h"

@implementation NSString (tool)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}



@end
