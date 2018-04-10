//
//  CCPrinterWiFiMacAddress.h
//  CMM
//
//  Created by qianye on 2018/1/30.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPrinterWiFiMacAddress : NSObject

/// 目前在模拟器中可以正确获取到mac地址，在真机上获取不到
+ (NSString *)getMacAddressWithIpAddress:(NSString *)ipAddress;

@end
