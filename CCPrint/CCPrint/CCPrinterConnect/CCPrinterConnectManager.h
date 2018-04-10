//
//  CCPrinterConnectManager.h
//  CMM
//
//  Created by qianye on 2018/1/30.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPrintDefine.h"
@class CCPrinterConnectManager;
@class CCPeripheral;

@protocol CCPrinterConnectManagerDelegate <NSObject>

/// 外设状态发生改变，需要接受方主动刷新
- (void)connectManager:(CCPrinterConnectManager *)connectManager peripheralsDidChange:(NSArray *)peripherals;

@end

@interface CCPrinterConnectManager : NSObject

@property (nonatomic, weak) id<CCPrinterConnectManagerDelegate> delegate;
/// 获取当前状态下的所有扫描外设
- (NSArray *)getCurrentPeripherals;
/// 设置当前打印机
- (void)setCurrentPurposeType:(CCPrinterConnectPurposeType)purposeType connectType:(CCPrinterConnectType)connectType;

- (void)startScanPeripherals;
- (void)stopScanPeripherals;

- (void)connectToPeripheral:(CCPeripheral *)peripheral;

- (void)disconnectToPeripheral:(CCPeripheral *)peripheral;

- (void)disconnectAllPeripheralsConnection;

@end
