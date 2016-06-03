//
//  kColorConstants.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface kColorConstants : NSObject

// waitlist tableView colors
+ (UIColor *)waitlistTableViewSideLabelColor:(CGFloat)alpha;
+ (UIColor *)waitListTextColorSelected:(BOOL)selected alpha:(CGFloat)alpha;
+ (UIColor *)waitListTableViewCellColorSelected:(BOOL)selected alpha:(CGFloat)alpha;
+ (UIColor *)waitListTableViewSeparatorLineColorSelected:(BOOL)selected alpha:(CGFloat)alpha;

// Tab bar colors
+ (UIColor *)tabBarColor:(CGFloat)alpha;
+ (UIColor *)tabBarItemColorSelected:(CGFloat)alpha;
+ (UIColor *)tabBarItemColorNotSelected:(CGFloat)alpha;

// NavigationBar colors
+ (UIColor *)navigationBarColor:(CGFloat)alpha;
+ (UIColor *)navigationBarBackArrowColor:(CGFloat)alpha;


// Action Button colors
+ (UIColor *)actionButtonBackgroundColor:(CGFloat)alpha;
+ (UIColor *)actionButtonBackgroundColorHighlighted:(CGFloat)alpha;

// Open Slot Collection View colors
+ (UIColor *)openSlotDayViewBackgroundColorSelected:(CGFloat)alpha;
+ (UIColor *)openSlotDayViewBackgroundColotNotSelected:(CGFloat)alpha;
+ (UIColor *)openSlotDayTextColor:(CGFloat)alpha;

@end
