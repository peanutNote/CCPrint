//
//  CCPrinterWiFiConnectManager.h
//  CMM
//
//  Created by qianye on 2018/1/16.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCPrinterWiFiConnectManager;
@class GCDAsyncSocket;
@class CCPeripheral;

@protocol CCPrinterWiFiConnectManagerDelegate <NSObject>

- (void)connectManager:(CCPrinterWiFiConnectManager *)manager didConnectedWithPeripheral:(CCPeripheral *)peripheral;
- (void)connectManager:(CCPrinterWiFiConnectManager *)manager failureConnectedWithPeripheral:(CCPeripheral *)peripheral;
- (void)connectManager:(CCPrinterWiFiConnectManager *)manager didDisconnectedWithPeripheral:(CCPeripheral *)peripheral;
- (void)connectManager:(CCPrinterWiFiConnectManager *)manager didDiscoverPeripheral:(CCPeripheral *)peripheral;

@end

@interface CCPrinterWiFiConnectManager : NSObject
/// 已经连接的设备
@property (nonatomic, strong) NSMutableArray *connectedPeripherals;
/// 已经扫描出来的设备
@property (nonatomic, strong) NSMutableArray *discoverPeripherals;

@property (nonatomic, weak) id<CCPrinterWiFiConnectManagerDelegate> delegate;

/// 扫描Peripherals
- (void)startScanPeripherals;
/// 连接Peripherals
- (void)connectToPeripheral:(CCPeripheral *)peripheral;
/// 断开设备连接
- (void)disconnectPeripheralConnection:(CCPeripheral *)peripheral;
/// 断开所有已连接的设备
- (void)disconnectAllPeripheralsConnection;
/// 停止扫描
- (void)stopScanPeripherals;

@end
