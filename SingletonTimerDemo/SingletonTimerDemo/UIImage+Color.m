//
//  UIImage+Color.m
//  PNCMobileBank
//
//  Created by YLG on 15/7/4.
//  Copyright (c) 2015年 YLG. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(id)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
