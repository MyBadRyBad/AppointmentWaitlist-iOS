//
//  kColorConstants.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/22/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "kColorConstants.h"

@implementation kColorConstants


// tableView colors
+ (UIColor *)waitlistTableViewSideLabelColor:(CGFloat)alpha {
    return [UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:alpha];
}

+ (UIColor *)waitListTextColorSelected:(BOOL)selected alpha:(CGFloat)alpha {
    if (selected) {
         return [UIColor colorWithRed:67.0/255.0f green:141.0/255.0f blue:202.0/255.0f alpha:alpha];
    } else {
        return [UIColor colorWithRed:30.0/255.0f green:36.0/255.0f blue:70.0/255.0f alpha:alpha];
    }
}

+ (UIColor *)waitListTableViewCellColorSelected:(BOOL)selected alpha:(CGFloat)alpha {
    if (selected) {
        return [UIColor colorWithRed:222.0/255.0f green:240.0/255.0f blue:252.0/255.0f alpha:alpha];
    } else {
        return [UIColor whiteColor];
    }
}

+ (UIColor *)waitListTableViewSeparatorLineColorSelected:(BOOL)selected alpha:(CGFloat)alpha {
    if (selected) {
        return [UIColor colorWithRed:67.0/255.0f green:141.0/255.0f blue:202.0/255.0f alpha:alpha];
    } else {
        return [UIColor colorWithRed:216.0/255.0f green:216.0/255.0f blue:216.0/255.0f alpha:alpha];
    }
}

// Tab bar color
+ (UIColor *)tabBarColor:(CGFloat)alpha {
    return [UIColor colorWithRed:29.0/255.0f green:35.0/255.0f blue:71.0/255.0f alpha:alpha];
}

+ (UIColor *)tabBarItemColorSelected:(CGFloat)alpha {
    return [UIColor whiteColor];
}

+ (UIColor *)tabBarItemColorNotSelected:(CGFloat)alpha {
    return [UIColor colorWithRed:116.0/255.0f green:135.0/255.0f blue:151.0/255.0f alpha:alpha];
}

// NavigationBar color
+ (UIColor *)navigationBarColor:(CGFloat)alpha {
    return [UIColor colorWithRed:30.0/255.0f green:36.0/255.0f blue:70.0/255.0f alpha:alpha];
}

+ (UIColor *)navigationBarBackArrowColor:(CGFloat)alpha {
    return [UIColor colorWithRed:67.0/255.0f green:174.0/255.0f blue:202.0/255.0f alpha:alpha];
}

// action button colors
+ (UIColor *)actionButtonBackgroundColor:(CGFloat)alpha {
    return [UIColor colorWithRed:249.0/255.0f green:79.0/255.0f blue:44.0/255.0f alpha:alpha];
}

+ (UIColor *)actionButtonBackgroundColorHighlighted:(CGFloat)alpha {
    return [UIColor colorWithRed:229.0/255.0f green:59.0/255.0f blue:22.0/255.0f alpha:alpha];
}

// open slot colors
+ (UIColor *)openSlotDayViewBackgroundColorSelected:(CGFloat)alpha {
    return [UIColor colorWithRed:67.0/255.0f green:141.0/255.0f blue:202.0/255.0f alpha:alpha];
}

+ (UIColor *)openSlotDayViewBackgroundColotNotSelected:(CGFloat)alpha {
    return [UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:alpha];
}

+ (UIColor *)openSlotDayTextColor:(CGFloat)alpha {
    return [UIColor colorWithRed:134.0/255.0f green:134.0/255.0f blue:134.0/255.0f alpha:alpha];
}

@end
