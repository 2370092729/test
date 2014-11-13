
//  
//
//  Created by My Mac OS on 14-9-29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (ZZ)


#pragma mark set方法


- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}

- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

- (void)setWidth:(CGFloat)width
{
    CGRect customFrame = self.frame;
    customFrame.size.width = width;
    self.frame = customFrame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect customFrame = self.frame;
    customFrame.size.height = height;
    self.frame = customFrame;
}

- (void)setX:(CGFloat)x
{
    CGRect customFrame = self.frame;
    customFrame.origin.x = x;
    self.frame = customFrame;
}

- (void)setY:(CGFloat)y
{
    CGRect customFrame = self.frame;
    customFrame.origin.y = y;
    self.frame = customFrame;
}

- (void)setSize:(CGSize)size
{
    CGRect customFrame = self.frame;
    customFrame.size = size;
    self.frame = customFrame;
}


- (void)setCenterX:(CGFloat)centerX
{
    CGPoint tempCenter = self.center;
    tempCenter.x = centerX;
    self.center = tempCenter;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint tempCenter = self.center;
    tempCenter.y = centerY;
    self.center = tempCenter;
}


#pragma mark get方法

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}


@end
