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

+ (void)getAppointmentSlotsOfDays:(NSInteger)days offset:(NSInteger)offset providerId:(NSInteger)providerID subdomain:(NSString *)subdomain timezone:(NSString *)timezone {
    
    NSString *paramString = [NSString stringWithFormat:@"?%@=%ld&%@=%ld&%@=%ld&%@=%@&%@=%@",
                             kRESTParamDays, (long)days,
                             kRESTParamOffset, (long)offset,
                             kRESTProviderId, (long)providerID,
                             kRESTSubdomain, subdomain,
                             kRESTtimezone, timezone];
    
    NSString *URLString = [kRESTURLAppointmentSlotsURL stringByAppendingString:paramString];

    // Create manager
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // JSON Body
    NSDictionary* bodyObject = nil;
    
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
            
            
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            NSDictionary *response = (NSDictionary *)responseObject;

        }
    }];
    
    [dataTask resume];
}


@end
