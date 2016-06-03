//
//  kColorConstants.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/22/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "kColorConstants.h"

@implementation kColorConstants

+ (UIColor *)openSlotDayViewBackgroundColorSelected:(CGFloat)alpha {
    return [UIColor colorWithRed:67.0/255.0f green:141.0/255.0f blue:202.0/255.0f alpha:alpha];
}

+ (UIColor *)openSlotDayViewBackgroundColotNotSelected:(CGFloat)alpha {
    return [UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:alpha];
}

+ (UIColor *)openSlotDayTextColor:(CGFloat)alpha {
    return [UIColor colorWithRed:161.0/255.0f green:161.0/255.0f blue:161.0/255.0f alpha:alpha];
}

@end
