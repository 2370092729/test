//
//  UIImage+ZZ.m
//  新浪微博
//
//  Created by My Mac OS on 14-9-29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+ZZ.h"

@implementation UIImage (ZZ)


+ (instancetype)imageWithName:(NSString *)imageName
{
    UIImage *image = nil;
    if (IOS7) {// 判断系统版本
        image = [self imageNamed:[imageName stringByAppendingString:@"_os7"]];
        
    }
   
    // 如果不是以_os7结尾
    if (image == nil) {
        image = [self imageNamed:imageName];
    }
    return image;
    
}
#warning 这个方法有bug，以后调试
/*
+ (UIImage *)resizeableWithImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageWithName:imageName];
//    UIImage *tempImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    UIEdgeInsets edgInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    UIImage *tempImage = [image resizableImageWithCapInsets:edgInsets resizingMode:UIImageResizingModeTile];
    
    return tempImage;
}
*/

+ (UIImage *)resizeableWithImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageWithName:imageName];
    
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    
    UIImage *tempImge = [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    
    return tempImge;
}



@end
