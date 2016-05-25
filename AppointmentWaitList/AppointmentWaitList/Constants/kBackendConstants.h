//
//  kBackendConstants.h
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <Foundation/Foundation.h>


//////////////////////////////////////
//
// HTTP Request Constants
//
//////////////////////////////////////

// rest url
static NSString *const kRESTURLAppointmentSlotsURL = @"xxxxxxx_URL_GOES_HERE_xxxxxxx";

// header values
static NSString *const kHeaderValueAuthorization = @"xxxxxxx_VALUE_GOES_HERE_xxxxxxx";
static NSString *const kHeaderValueAcceptLanguage = @"xxxxxxx_VALUE_GOES_HERE_xxxxxxx";
static NSString *const kHeaderValueAcceptEncoding = @"xxxxxxx_VALUE_GOES_HERE_xxxxxxx";
static NSString *const kHeaderValueUserAgent = @"xxxxxxx_VALUE_GOES_HERE_xxxxxxx";
static NSString *const kHeaderValueContentType = @"xxxxxxx_VALUE_GOES_HERE_xxxxxxx";

// params
static NSString *const kRESTParamDaysKey = @"days";
static NSString *const kRESTParamOffsetKey = @"offset";
static NSString *const kRESTProviderIdKey = @"provider_id";
static NSString *const kRESTSubdomainKey = @"subdomain";
static NSString *const kRESTtimezoneKey = @"timezone";

// HTTP Verbs
static NSString *const kHttpGET = @"GET";
static NSString *const kHttpPOST = @"POST";
static NSString *const kHttpPUT = @"PUT";
static NSString * const kHttpPATCH = @"PATCH";
static NSString *const kHttpDELETE = @"DELETE";

// header fields
static NSString *const kHeaderFieldAuthorization = @"Authorization";
static NSString *const kHeaderFieldAcceptLanguage = @"Accept-Language";
static NSString *const kHeaderFieldAcceptEncoding = @"Accept-Encoding";
static NSString *const kHeaderFieldUserAgent = @"User-Agent";
static NSString *const kHeaderFieldContentType = @"Content-Type";


//////////////////////////////////////
//
// Waitlist data keys
//
//////////////////////////////////////

static NSString *const kBackendWaitlistCodeKey = @"code";
static NSString *const kBackendWaitlistDescriptionKey = @"description";
static NSString *const kBackendWaitlistDataKey = @"data";
static NSString *const kBackendWaitlistErrorKey = @"error";


