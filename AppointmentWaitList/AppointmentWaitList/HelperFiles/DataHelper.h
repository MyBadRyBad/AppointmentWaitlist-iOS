//
//  DataHelper.h
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/26/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject

- (NSDate *)dateFromJSONString:(NSString *)jsonString;

@end
