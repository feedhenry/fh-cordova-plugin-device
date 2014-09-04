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
    [devProps setObject:[device uniqueAppInstanceIdentifier] forKey:@"uuid"];
      
    // Generate cuidMap
    NSMutableArray *cuidMap = [[NSMutableArray alloc] init];

    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
      NSUUID* venderId = [[UIDevice currentDevice] identifierForVendor];
      if(nil != venderId){
        NSMutableDictionary *venderIdMap = [[NSMutableDictionary alloc] init];
        [venderIdMap setObject:@"venderId" forKey:@"name"];
        [venderIdMap setObject:[venderId UUIDString] forKey:@"cuid"];
        [cuidMap addObject:venderIdMap];
      }
    }
  
    // Append to cuidMap
    [devProps setObject:cuidMap forKey:@"cuidMap"];
    //end change

    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end
