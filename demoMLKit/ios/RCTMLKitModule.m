//
//  RCTMLKitModule.m
//  demoMLKit
//
//  Created by Trinh Thanh Phuong on 21/08/2021.
//

// RCTMLKitModule.m
#import "RCTMLKitModule.h"
#import <React/RCTLog.h>

@implementation RCTMLKitModule

// To export a module named RCTMLKitModule
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(testEvent:(NSString *)name
                  myCallback: (RCTResponseSenderBlock) callback)
{
 RCTLogInfo(@"Pretending to create an event %@", name);
}



RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getName)
{
return [[UIDevice currentDevice] name];
}

@end
