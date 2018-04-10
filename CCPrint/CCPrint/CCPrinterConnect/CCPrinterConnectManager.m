//
//  CCPrinterConnectManager.m
//  CMM
//
//  Created by qianye on 2018/1/30.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import "CCPrinterConnectManager.h"
#import "CCPrinterBluetoothConnectManager.h"
#import "CCPrinterWiFiConnectManager.h"
#import "CCPeripheral.h"
#import "CCPrintManager.h"
#import <SVProgressHUD.h>

@interface CCPrinterConnectManager ()<CCPrinterBluetoothConnectManagerDelegate, CCPrinterWiFiConnectManagerDelegate>

@property (nonatomic, strong) CCPrinterBluetoothConnectManager *orderBluetoothConnect;
@property (nonatomic, strong) CCPrinterBluetoothConnectManager *labelBluetoothConnect;
@property (nonatomic, strong) CCPrinterBluetoothConnectManager *deliveryBluetoothConnect;
@property (nonatomic, strong) CCPrinterWiFiConnectManager *orderWiFiConnect;

@property (nonatomic, assign) CCPrinterConnectPurposeType purposeType;
@property (nonatomic, assign) CCPrinterConnectType connectType;

@end

@implementation CCPrinterConnectManager

- (instancetype)init {
    if (self = [super init]) {
        [self ccInitManager];
    }
    return self;
}

- (void)ccInitManager {
    _orderBluetoothConnect = [[CCPrinterBluetoothConnectManager alloc] init];
    _orderBluetoothConnect.printerOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES};
    _orderBluetoothConnect.delegate = self;
    
    _labelBluetoothConnect = [[CCPrinterBluetoothConnectManager alloc] init];
    _labelBluetoothConnect.printerOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES};
    _labelBluetoothConnect.delegate = self;
    
    _deliveryBluetoothConnect = [[CCPrinterBluetoothConnectManager alloc] init];
    _deliveryBluetoothConnect.printerOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES};
    _deliveryBluetoothConnect.delegate = self;
    
    _orderWiFiConnect = [[CCPrinterWiFiConnectManager alloc] init];
    _orderWiFiConnect.delegate = self;
}

- (void)setCurrentPurposeType:(CCPrinterConnectPurposeType)purposeType connectType:(CCPrinterConnectType)connectType {
    _purposeType = purposeType;
    _connectType = connectType;
}

- (void)connectToPeripheral:(CCPeripheral *)peripheral {
    [SVProgressHUD show];
    if (_connectType == CCPrinterConnectBluetooth) {
        if (_purposeType == CCPrinterConnectPurposeOrder) {
            [_orderBluetoothConnect connectToPeripheral:peripheral];
        } else if (_purposeType == CCPrinterConnectPurposeLabel) {
            [_labelBluetoothConnect connectToPeripheral:peripheral];
        } else if (_purposeType == CCPrinterConnectPurposeDelivery) {
            [_deliveryBluetoothConnect connectToPeripheral:peripheral];
        }
    } else {
        peripheral.connectState = CCPrinterPeripheralConnecting;
        [_orderWiFiConnect connectToPeripheral:peripheral];
    }
}

- (void)disconnectToPeripheral:(CCPeripheral *)peripheral {
    if (_connectType == CCPrinterConnectBluetooth) {
        if (_purposeType == CCPrinterConnectPurposeOrder) {
            [_orderBluetoothConnect disconnectPeripheralConnection:peripheral];
        } else if (_purposeType == CCPrinterConnectPurposeLabel) {
            [_labelBluetoothConnect disconnectPeripheralConnection:peripheral];
        } else if (_purposeType == CCPrinterConnectPurposeDelivery) {
            [_deliveryBluetoothConnect disconnectPeripheralConnection:peripheral];
        }
    } else {
        [_orderWiFiConnect disconnectPeripheralConnection:peripheral];
    }
}

- (NSArray *)getCurrentPeripherals {
    if (_connectType == CCPrinterConnectBluetooth) {
        if (_purposeType == CCPrinterConnectPurposeOrder) {
            return _orderBluetoothConnect.discoverPeripherals;
        } else if (_purposeType == CCPrinterConnectPurposeLabel) {
            return _labelBluetoothConnect.discoverPeripherals;
        } else if (_purposeType == CCPrinterConnectPurposeDelivery) {
            return _deliveryBluetoothConnect.discoverPeripherals;
        }
    } else {
        return _orderWiFiConnect.discoverPeripherals;
    }
    return @[];
}

- (void)startScanPeripherals {
    [_orderBluetoothConnect startScanPeripherals];
    [_labelBluetoothConnect startScanPeripherals];
    [_deliveryBluetoothConnect startScanPeripherals];
    [_orderWiFiConnect startScanPeripherals];
}

- (void)stopScanPeripherals {
    [_orderBluetoothConnect stopScanPeripherals];
    [_labelBluetoothConnect stopScanPeripherals];
    [_deliveryBluetoothConnect stopScanPeripherals];
    [_orderWiFiConnect stopScanPeripherals];
}

- (void)savePeripheral:(CCPeripheral *)peripheral {
    CCPeripheral *per = [CCPrintUtilities getPeripheralWithUUIDString:peripheral.identifier];
    if (per == nil) {
        [CCPrintUtilities savePeripheral:peripheral];
    }
}

- (void)disconnectAllPeripheralsConnection {
    [_orderBluetoothConnect disconnectAllPeripheralsConnection];
    [_labelBluetoothConnect disconnectAllPeripheralsConnection];
    [_deliveryBluetoothConnect disconnectAllPeripheralsConnection];
    [_orderWiFiConnect disconnectAllPeripheralsConnection];
}

#pragma mark - CCPrinterBluetoothConnectManagerDelegate

- (void)centralManagerDidUpdateState:(CCPrinterBluetoothConnectManager *)centralManager {
    if (centralManager.central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"设备打开成功，开始扫描设备");
    }
}

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didDiscoverPeripheral:(CCPeripheral *)peripheral {
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didConnectPeripheral:(CCPeripheral *)peripheral {
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didFailToConnectPeripheral:(CCPeripheral *)peripheral error:(NSError *)error {
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)centralManager:(CCPrinterBluetoothConnectManager *)centralManager didDisconnectPeripheral:(CCPeripheral *)peripheral error:(NSError *)error {
    CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
    [printManager.printerBrandManager clearPeripheralWithPurposeConnectType:_purposeType peripheral:peripheral];
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)peripheral:(CCPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    // 可用服务UUIDString
    NSArray *availabelServices = @[@"FFF0", @"18F0", @"49535343-FE7D-4AE5-8FA9-9FAFD205E455"];
    
    // 可用特征
    NSMutableArray *characteristics = [NSMutableArray array];
    NSArray *availabelCharacteristics = @[@"FFF2", @"2AF1", @"BEF8D6C9-9C21-4C9E-B632-BD58C1009F9F", @"49535343-8841-43F4-A8D4-ECBE34729BB3"];
    for (NSString *filterString in availabelCharacteristics) {
        CBUUID *uuid = [CBUUID UUIDWithString:filterString];
        [characteristics addObject:uuid];
    }
    
    BOOL haveCharacteristics = NO;
    for (CBService *service in peripheral.per.services) {
        if ([availabelServices containsObject:service.UUID.UUIDString]) {
            // 扫描并过滤特征
            [peripheral.per discoverCharacteristics:characteristics forService:service];
            haveCharacteristics = YES;
            break;
        }
    }
    if (!haveCharacteristics) {
        [SVProgressHUD dismiss];
        [self disconnectToPeripheral:peripheral];
        [SVProgressHUD showErrorWithStatus:@"该设备不支持APP打印"];
    }
}

- (void)peripheral:(CCPeripheral *)peripheral didDiscoverCharacteristics:(NSArray *)characteristics service:(CBService *)service error:(NSError *)error {
    [SVProgressHUD dismiss];
    if (characteristics.count) {
        peripheral.chac = [characteristics firstObject];
        CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
        [printManager.printerBrandManager setPeripheralWithPurposeConnectType:_purposeType peripheral:peripheral];
        if (_purposeType == CCPrinterConnectPurposeOrder) {
            // 已经连接上蓝牙需要断开wifi连接
            [_orderWiFiConnect disconnectAllPeripheralsConnection];
        }
        [self savePeripheral:peripheral];
    } else {
        [self disconnectToPeripheral:peripheral];
        [SVProgressHUD showErrorWithStatus:@"该设备不支持APP打印"];
    }
}

- (BOOL)filterOnDiscoverPeripheral:(CCPeripheral *)peripheral {
    return [peripheral checkPeripheral];
}

#pragma mark - CCPrinterWiFiConnectManagerDelegate

- (void)connectManager:(CCPrinterWiFiConnectManager *)manager didConnectedWithPeripheral:(CCPeripheral *)peripheral {
    peripheral.connectState = CCPrinterPeripheralConnected;
    [self savePeripheral:peripheral];
    [_orderBluetoothConnect disconnectAllPeripheralsConnection];
    
    [SVProgressHUD dismiss];
    CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
    [printManager.printerBrandManager setPeripheralWithPurposeConnectType:_purposeType peripheral:peripheral];
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)connectManager:(CCPrinterWiFiConnectManager *)manager didDisconnectedWithPeripheral:(CCPeripheral *)peripheral {
    peripheral.connectState = CCPrinterPeripheralUnconnect;
    CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
    [printManager.printerBrandManager clearPeripheralWithPurposeConnectType:_purposeType peripheral:peripheral];
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)connectManager:(CCPrinterWiFiConnectManager *)manager failureConnectedWithPeripheral:(CCPeripheral *)peripheral {
    peripheral.connectState = CCPrinterPeripheralUnconnect;
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:@"打印机无法连接，请确认打印机是否已连接网络或者稍后再试"];
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

- (void)connectManager:(CCPrinterWiFiConnectManager *)manager didDiscoverPeripheral:(CCPeripheral *)peripheral {
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:peripheralsDidChange:)]) {
        [_delegate connectManager:self peripheralsDidChange:[self getCurrentPeripherals]];
    }
}

@end
