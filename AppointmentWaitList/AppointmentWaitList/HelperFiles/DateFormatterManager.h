//
//  DateFormatterManager.h
//  AppointmentWaitList-iOS
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright (c) 2015 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatterManager : NSObject

+ (id)sharedManager;

- (NSDateFormatter *)jsonDateFormatter;
- (NSDateFormatter *)timeDateFormatter;


@end
