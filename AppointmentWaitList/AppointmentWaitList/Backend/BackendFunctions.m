//
//  BackendFunctions.m
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "BackendFunctions.h"
#import "kBackendConstants.h"
#import <AFNetworking.h>

//////////////////////////////////////
//
// Implementation
//
//////////////////////////////////////
@implementation BackendFunctions

+ (void)getAppointmentSlotsOfDays:(NSInteger)days offset:(NSInteger)offset providerId:(NSInteger)providerID subdomain:(NSString *)subdomain timezone:(NSString *)timezone onCompletion:(CompletionWithDictionaryBlock)onCompletion {
    
    NSString *URLString = kRESTURLAppointmentSlotsURL;

    // Create manager
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // JSON Body
    NSDictionary* bodyObject = @{kRESTParamDaysKey : @(days),
                                 kRESTParamOffsetKey : @(offset),
                                 kRESTProviderIdKey : @(providerID),
                                 kRESTSubdomainKey : subdomain,
                                 kRESTtimezoneKey : timezone};
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:kHttpGET URLString:URLString parameters:bodyObject error:NULL];
    
    // Add Headers
    [request setValue:kHeaderValueAuthorization forHTTPHeaderField:kHeaderFieldAuthorization];
    [request setValue:kHeaderValueAcceptLanguage forHTTPHeaderField:kHeaderFieldAcceptLanguage];
    [request setValue:kHeaderValueAcceptEncoding forHTTPHeaderField:kHeaderFieldAcceptEncoding];
    [request setValue:kHeaderValueUserAgent forHTTPHeaderField:kHeaderFieldUserAgent];
    [request setValue:kHeaderValueContentType forHTTPHeaderField:kHeaderFieldContentType];
    
    // Fetch Request
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            NSLog(@"NSURLSessionDataTask Error: %@", error);
            onCompletion(nil, error);
            
        } else {
            NSLog(@"%@ %@", response, responseObject);
        
            NSDictionary *response = (NSDictionary *)responseObject;
            onCompletion(response, nil);
        }
    }];
    
    [dataTask resume];
}


@end
