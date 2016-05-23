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
static NSString *const kRESTURLAppointmentSlotsURL = @"XXXXXXXXXXXXXXXXXXXXX";

// params
static NSString *const kRESTParamDays = @"days";
static NSString *const kRESTParamOffset = @"offset";
static NSString *const kRESTProviderId = @"provider_id";
static NSString *const kRESTSubdomain = @"subdomain";
static NSString *const kRESTtimezone = @"timezone";

// HTTP Verbs
static NSString *const kHttpGET = @"GET";
static NSString *const kHttpPOST = @"POST";
static NSString *const kHttpPUT = @"PUT";
static NSString* const kHttpPATCH = @"PATCH";
static NSString *const kHttpDELETE = @"DELETE";

// header fields
static NSString *const kHeaderFieldAuthorization = @"Authorization";
static NSString *const kHeaderFieldAcceptLanguage = @"Accept-Language";
static NSString *const kHeaderFieldAcceptEncoding = @"Accept-Encoding";
static NSString *const kHeaderFieldUserAgent = @"User-Agent";
static NSString *const kHeaderFieldContentType = @"Content-Type";

// header values
static NSString *const kHeaderValueAuthorization = @"XXXXXXXXXXXXXXXXXXXXX";
static NSString *const kHeaderValueAcceptLanguage = @"XXXXXXXXXXXXXXXXXXXXX";
static NSString *const kHeaderValueAcceptEncoding = @"XXXXXXXXXXXXXXXXXXXXX";
static NSString *const kHeaderValueUserAgent = @"XXXXXXXXXXXXXXXXXXXXX";
static NSString *const kHeaderValueContentType = @"XXXXXXXXXXXXXXXXXXXXX";

//////////////////////////////////////
//
// Waitlist data keys
//
//////////////////////////////////////

static NSString *const kBackendWaitlistCodeKey = @"code";
static NSString *const kBackendWaitlistDescriptionKey = @"description";
static NSString *const kBackendWaitlistDataKey = @"data";
static NSString *const kBackendWaitlistErrorKey = @"error";


