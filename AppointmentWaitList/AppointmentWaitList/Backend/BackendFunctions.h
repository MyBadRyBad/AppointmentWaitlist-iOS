//
//  BackendFunctions.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>

/////////////////////////////
// block definitions
/////////////////////////////
typedef void (^CompletionWithErrorBlock)(BOOL success, NSError *error);
typedef void (^CompletionWithDictionaryBlock)(NSDictionary *dictionary, NSError *error);

@interface BackendFunctions : NSObject

+ (void)fetchAppointmentSlotsOfDays:(NSInteger)days offset:(NSInteger)offset providerId:(NSInteger)providerID subdomain:(NSString *)subdomain timezone:(NSString *)timezone onCompletion:(CompletionWithDictionaryBlock)onCompletion;

@end
