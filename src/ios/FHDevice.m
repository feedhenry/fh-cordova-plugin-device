/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "UIDevice+IdentifierAddition.h"

#import <Cordova/CDV.h>
#import "FHDevice.h"

@interface FHDevice () {}
@end

@implementation FHDevice

- (void)getFHDeviceInfo:(CDVInvokedUrlCommand*)command
{
    NSDictionary* deviceProperties = [self deviceProperties];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceProperties];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSDictionary*)deviceProperties
{
    UIDevice* device = [UIDevice currentDevice];
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:4];

    //the change here was to use the category on UIDevice imported above
  
    // Send advertiserId for iOS7+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
      [devProps setObject:[device uniqueDeviceIdentifier] forKey:@"uuid"];
    } else {
      [devProps setObject:[device advertiserId] forKey:@"uuid"];
    }
  
    // Generate cuidMap
    NSMutableArray *cuidMap = [[NSMutableArray alloc] init];
  
    // MAC and BundleID CUID
    // Don't send if iOS7+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
      NSMutableDictionary *macBundleMap = [[NSMutableDictionary alloc] init];
      [macBundleMap setObject:@"macAndBundleId" forKey:@"name"];
      [macBundleMap setObject:[device uniqueDeviceIdentifier] forKey:@"cuid"];
      [cuidMap addObject:macBundleMap];
    }
  
    // advertisingIdentifier - iOS 6+
    // if iOS7+, only send advertisingIdentifier
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
      NSMutableDictionary *advertIdMap = [[NSMutableDictionary alloc] init];
      [advertIdMap setObject:@"advertisingIdentifier" forKey:@"name"];
      [advertIdMap setObject:[device advertiserId] forKey:@"cuid"];
      [advertIdMap setObject:[NSNumber numberWithBool:[device trackingEnabled]] forKey:@"tracking_enabled"];
      [cuidMap addObject:advertIdMap];
    }
  
    // Append to cuidMap
    [devProps setObject:cuidMap forKey:@"cuidMap"];
    //end change

    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end
