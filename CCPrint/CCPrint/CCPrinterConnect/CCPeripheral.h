//
//  CCPeripheral.h
//  CMM
//
//  Created by qianye on 2017/10/12.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCModel.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CCPrintDefine.h"
@class GCDAsyncSocket;

typedef NS_ENUM(NSInteger, CCPrinterPeripheralType) {
    CCPrinterPeripheralBluetooth,
    CCPrinterPeripheralWifi
};

typedef NS_ENUM(NSInteger, CCPrinterPeripheralConnectState) {
    CCPrinterPeripheralUnconnect,
    CCPrinterPeripheralConnecting,
    CCPrinterPeripheralConnected
};

@interface CCPeripheral : CCModel

/// 打印机连接状态
@property (nonatomic, assign) CCPrinterPeripheralConnectState connectState;
/// 外设类型，默认为蓝牙打印机
@property (nonatomic, assign) CCPrinterPeripheralType peripheralType;
/// 重命名
@property (nonatomic, copy) NSString *rename;
/// 原始名字
@property (nonatomic, copy) NSString *originName;
/// 打印机类型(决定打印机指令)
@property (nonatomic, assign) CCPrinterBrandType brandType;
/// 外设唯一标识
@property (nonatomic, copy) NSString *identifier;

#pragma mark - bluetooth

@property (nonatomic, strong) CBPeripheral<CCIgnore> *per;
@property (nonatomic, strong) CBCharacteristic<CCIgnore> *chac;
/// 外设信息
@property (nonatomic, strong) NSDictionary<CCIgnore> *advertisementData;
/// 自定义打印类型
@property (nonatomic, copy) NSNumber *customModel;
/// 只有在连接Xprinter时生效
@property (nonatomic, assign) BOOL isPrinterQ200;

#pragma mark - wifi

/// wifi socket连接对象
@property (nonatomic, strong) GCDAsyncSocket<CCIgnore> *socket;

- (CCPrintInstructionType)getInstructionType;
- (void)updateBrandType;
- (BOOL)checkPeripheral;

@end
