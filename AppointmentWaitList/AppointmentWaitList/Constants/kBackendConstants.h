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
static NSString *const kRESTURLAppointmentSlotsURL = @"https://nexhealth.info/appointment_slots";

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

// header values
static NSString *const kHeaderValueAuthorization = @"d1q9MhixCGZX8lXge1NiTg";
static NSString *const kHeaderValueAcceptLanguage = @"en-US;q=1.0";
static NSString *const kHeaderValueAcceptEncoding = @"gzip;q=1.0,compress;q=0.5";
static NSString *const kHeaderValueUserAgent = @"NexHealth2/nexhealth.nexapp (1; OS Version 9.3 (Build 13E230))";
static NSString *const kHeaderValueContentType = @"application/json";

//////////////////////////////////////
//
// Waitlist data keys
//
//////////////////////////////////////

static NSString *const kBackendWaitlistCodeKey = @"code";
static NSString *const kBackendWaitlistDescriptionKey = @"description";
static NSString *const kBackendWaitlistDataKey = @"data";
static NSString *const kBackendWaitlistErrorKey = @"error";


