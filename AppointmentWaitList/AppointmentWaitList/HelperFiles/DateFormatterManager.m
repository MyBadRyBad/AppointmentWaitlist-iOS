//
//  DateFormatterManager.m
//  AppointmentWaitList-iOS
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright (c) 2016 Newdesto. All rights reserved.
//

#import "DateFormatterManager.h"
#import "kBackendConstants.h"
#import "kConstants.h"

@interface DateFormatterManager()

@property (nonatomic, strong) NSDateFormatter *jsonDateFormatter;
@property (nonatomic, strong) NSDateFormatter *timeDateFormatter;

@end

@implementation DateFormatterManager

+ (id)sharedManager {
    static DateFormatterManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (NSDateFormatter *)jsonDateFormatter
{
    if (!_jsonDateFormatter) {
        _jsonDateFormatter = [[NSDateFormatter alloc] init];
        [_jsonDateFormatter setDateFormat:kDateFormatStringJSON];
    }
    
    return _jsonDateFormatter;
}

- (NSDateFormatter *)timeDateFormatter {
    if (!_timeDateFormatter) {
        _timeDateFormatter = [[NSDateFormatter alloc] init];
        [_timeDateFormatter setDateFormat:@"h:mm"];
    }
    
    return _timeDateFormatter;
}

@end
