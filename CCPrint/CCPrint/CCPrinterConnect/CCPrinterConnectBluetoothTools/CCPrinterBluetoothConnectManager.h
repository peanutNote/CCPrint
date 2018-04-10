//
//  CCPrinterCentralManager.h
//  CMM
//
//  Created by qianye on 2017/9/30.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@class CCPrinterBluetoothConnectManager;
@class CCPeripheral;

@protocol CCPrinterBluetoothConnectManagerDelegate <NSObject>

- (void)centralManagerDidUpdateState:(CCPrinterBluetoothConnectManager *)centralManager;

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didDiscoverPeripheral:(CCPeripheral *)peripheral;

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didConnectPeripheral:(CCPeripheral *)peripheral;

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didFailToConnectPeripheral:(CCPeripheral *)peripheral error:(NSError *)error;

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didDisconnectPeripheral:(CCPeripheral *)peripheral error:(NSError *)error;

- (void)peripheral:(CCPeripheral *)peripheral didDiscoverServices:(NSError *)error;

- (void)peripheral:(CCPeripheral *)peripheral didDiscoverCharacteristics:(NSArray *)characteristics service:(CBService *)service error:(NSError *)error;

- (BOOL)filterOnDiscoverPeripheral:(CCPeripheral *)peripheral;

@end

@interface CCPrinterBluetoothConnectManager : NSObject
/// 连接中心
@property (nonatomic, strong) CBCentralManager *central;
/// 已经连接的设备
@property (nonatomic, strong) NSMutableArray *connectedPeripherals;
/// 已经扫描出来的设备
@property (nonatomic, strong) NSMutableArray *discoverPeripherals;
/// 蓝牙使用的参数参数
@property(nonatomic,strong) NSDictionary *printerOptions;
/// 过滤蓝牙扫描服务参数
@property (nonatomic, copy) NSArray *filtServices;
/// 过滤蓝牙扫描特征
@property (nonatomic, copy) NSArray *filtCharacteristics;

@property (nonatomic, weak) id<CCPrinterBluetoothConnectManagerDelegate> delegate;

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
