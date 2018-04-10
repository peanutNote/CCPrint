//
//  CCPrinterCentralManager.m
//  CMM
//
//  Created by qianye on 2017/9/30.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrinterBluetoothConnectManager.h"
#import "CCPeripheral.h"

@interface CCPrinterBluetoothConnectManager () <CBCentralManagerDelegate,CBPeripheralDelegate>

@end

@implementation CCPrinterBluetoothConnectManager

- (instancetype)init {
    self = [super init];
    if (self) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_0
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 //蓝牙power没打开时alert提示框
                                 [NSNumber numberWithBool:YES],CBCentralManagerOptionShowPowerAlertKey,
                                 //重设centralManager恢复的IdentifierKey
                                 @"babyBluetoothRestore",CBCentralManagerOptionRestoreIdentifierKey,
                                 nil];
#else
        NSDictionary *options = nil;
#endif
        NSArray *backgroundModes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIBackgroundModes"];
        if ([backgroundModes containsObject:@"bluetooth-central"]) {
            // 后台模式
            _central = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
        } else {
            // 非后台模式
            _central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        }
        _connectedPeripherals = [[NSMutableArray alloc]init];
        _discoverPeripherals = [[NSMutableArray alloc]init];
    }
    return  self;
    
}

// 扫描Peripherals
- (void)startScanPeripherals {
    [_central scanForPeripheralsWithServices:nil options:_printerOptions];
}

// 连接Peripherals
- (void)connectToPeripheral:(CCPeripheral *)peripheral{
    [_central connectPeripheral:peripheral.per options:_printerOptions];
}

// 断开设备连接
- (void)disconnectPeripheralConnection:(CCPeripheral *)peripheral {
    [_central cancelPeripheralConnection:peripheral.per];
}

// 断开所有已连接的设备
- (void)disconnectAllPeripheralsConnection {
    for (CCPeripheral *per in _connectedPeripherals) {
        [_central cancelPeripheralConnection:per.per];
    }
}

// 停止扫描
- (void)stopScanPeripherals {
    [_central stopScan];
}

#pragma mark - CBCentralManagerDelegate委托方法

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            break;
        default:
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(centralManagerDidUpdateState:)]) {
        [_delegate centralManagerDidUpdateState:self];
    }
}

// 扫描到Peripherals
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    CCPeripheral *ccPeripheral = [self findCCPeripheral:peripheral];
    if (ccPeripheral == nil) {
        ccPeripheral = [[CCPeripheral alloc] init];
    }
    ccPeripheral.per = peripheral;
    ccPeripheral.advertisementData = advertisementData;
    if (_delegate && [_delegate respondsToSelector:@selector(filterOnDiscoverPeripheral:)]) {
        if ([_delegate filterOnDiscoverPeripheral:ccPeripheral]) {
            if (_delegate && [_delegate respondsToSelector:@selector(centralManager:didDiscoverPeripheral:)]) {
                [_delegate centralManager:self didDiscoverPeripheral:ccPeripheral];
                [self addDiscoverPeripheral:ccPeripheral];
            }
        }
    }
}

// 连接到Peripheral成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    // 设置委托
    [peripheral setDelegate:self];
    // 扫描服务
    [peripheral discoverServices:_filtServices];
    CCPeripheral *ccPeripheral = [self findCCPeripheral:peripheral];
    [self addPeripheral:ccPeripheral];
    if (_delegate && [_delegate respondsToSelector:@selector(centralManager:didConnectPeripheral:)]) {
        [_delegate centralManager:self didConnectPeripheral:ccPeripheral];
    }
}

// 连接到Peripheral失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if (_delegate && [_delegate respondsToSelector:@selector(centralManager:didFailToConnectPeripheral:error:)]) {
        [_delegate centralManager:self didFailToConnectPeripheral:[self findCCPeripheral:peripheral] error:error];
    }
}

// Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    CCPeripheral *ccPeripheral = [self findCCPeripheral:peripheral];
    [self deletePeripheral:ccPeripheral];
    if (_delegate && [_delegate respondsToSelector:@selector(centralManager:didDisconnectPeripheral:error:)]) {
        [_delegate centralManager:self didDisconnectPeripheral:ccPeripheral error:error];
    }
}

// 扫描到服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (_delegate && [_delegate respondsToSelector:@selector(peripheral:didDiscoverServices:)]) {
        [_delegate peripheral:[self findCCPeripheral:peripheral] didDiscoverServices:error];
    }
}

// 发现服务的Characteristics
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"error didDiscoverCharacteristicsForService for %@ with error: %@", service.UUID, [error localizedDescription]);
    }
    NSMutableArray *characteristics = [NSMutableArray array];
    for (CBCharacteristic *characteristic in service.characteristics) {
        // 判断读写权限
        if (characteristic.properties & CBCharacteristicPropertyWrite ) {
            [characteristics addObject:characteristic];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(peripheral:didDiscoverCharacteristics:service:error:)]) {
        [_delegate peripheral:[self findCCPeripheral:peripheral] didDiscoverCharacteristics:characteristics service:service error:error];
    }
}

#pragma mark - 设备list管理

- (void)addDiscoverPeripheral:(CCPeripheral *)peripheral{
    if (![_discoverPeripherals containsObject:peripheral]) {
        [_discoverPeripherals addObject:peripheral];
    }
}

- (void)addPeripheral:(CCPeripheral *)peripheral {
    if (![_connectedPeripherals containsObject:peripheral]) {
        [_connectedPeripherals addObject:peripheral];
    }
}

- (void)deletePeripheral:(CCPeripheral *)peripheral{
    [_connectedPeripherals removeObject:peripheral];
}

- (CCPeripheral *)findCCPeripheral:(CBPeripheral *)peripheral {
    for (CCPeripheral *p in _discoverPeripherals) {
        if (p.per == peripheral) {
            return p;
        }
    }
    return nil;
}

@end
