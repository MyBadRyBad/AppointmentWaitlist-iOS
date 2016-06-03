//
//  HelperFile.m
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 6/3/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "HelperFile.h"

@implementation HelperFile

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
