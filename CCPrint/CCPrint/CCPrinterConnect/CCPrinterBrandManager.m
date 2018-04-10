//
//  CCPrinterBrandManager.m
//  CMM
//
//  Created by qianye on 2017/9/12.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrinterBrandManager.h"
#import "CCPrintUtilities.h"
#import "CCPeripheral.h"
#import "GCDAsyncSocket.h"
#import "CCModelDefine.h"

@implementation CCPrinterBrandManager {
    // 运单打印-蓝牙连接
    CCPeripheral *_orderPeripheral;
    GCDAsyncSocket *_orderSocket;
    // 标签打印-蓝牙连接
    CCPeripheral *_labelPeripheral;
    // 提货单打印-蓝牙连接
    CCPeripheral *_deliveryPeripheral;
    // 可用的打印设备
    CCPeripheral *_currentPeripheral;
}

#pragma mark - Private Method

- (void)setPeripheralWithPurposeConnectType:(CCPrinterConnectPurposeType)connectType peripheral:(CCPeripheral *)peripheral {
    switch (connectType) {
        case CCPrinterConnectPurposeOrder:
            if (peripheral.peripheralType == CCPrinterPeripheralWifi) {
                _orderSocket = peripheral.socket;
            } else {
                _orderPeripheral = peripheral;
            }
            break;
        case CCPrinterConnectPurposeLabel:
            _labelPeripheral = peripheral;
            break;
        case CCPrinterConnectPurposeDelivery:
            _deliveryPeripheral = peripheral;
            break;
        default:
            break;
    }
}

#pragma mark - Setter&Getter

- (void)setCurrentTaskModel:(CCPrintTaskModelType)currentTaskModel {
    if (_currentTaskModel != currentTaskModel) {
        _currentTaskModel = currentTaskModel;
    }
    [self checkAndConfirmPeripheral];
}

- (CCPrintContentWidthType)getContentWidthType {
    if (_currentTaskModel == CMPrintTaskModelWayBill58 || _currentTaskModel == MMPrintTaskModelWayBill58) {
        return CCPrintContentWidth58m;
    } else {
        return CCPrintContentWidth80m;
    }
}

- (CCPrintInstructionType)getInstructionType {
    if (_appointedinstructionType != CCPrintInstructionNone) {
        return _appointedinstructionType;
    } else {
        if (_appointedPeripheral) {
            return [_appointedPeripheral getInstructionType];
        } else if (_currentPeripheral) {
            return [_currentPeripheral getInstructionType];
        } else if (_orderSocket) {
            if (_currentTaskModel == CCPrintTaskModelCustomOrder) {
                // 只有自定义运单模板支持wifi打印
                return CCPrintInstructionESCP;
            }
        }
        return CCPrintInstructionNone;
    }
}

#pragma mark - Public Method

- (void)printData:(NSData *)data {
    // 蓝牙打印
    if (_appointedPeripheral) {
        [self printSegmentationData:data peripheral:_appointedPeripheral];
    } else {
        if (_currentPeripheral) {
            [self printSegmentationData:data peripheral:_currentPeripheral];
        } else if (_orderSocket) {
            // wifi打印
            [_orderSocket writeData:data withTimeout:-1 tag:0];
        }
    }
}

- (void)printSegmentationData:(NSData *)data peripheral:(CCPeripheral *)peripheral {
    NSInteger MAX_PRINT_STR_LENGTH = 150;
    NSInteger count = 0;
    while (count * MAX_PRINT_STR_LENGTH < data.length) {
        NSUInteger length = data.length - count * MAX_PRINT_STR_LENGTH;
        if (length > MAX_PRINT_STR_LENGTH) {
            length = MAX_PRINT_STR_LENGTH;
        }
        NSData *printData = [data subdataWithRange:NSMakeRange(count * MAX_PRINT_STR_LENGTH, length)];
        [peripheral.per writeValue:printData forCharacteristic:peripheral.chac type:CBCharacteristicWriteWithResponse];
        count++;
    }
}

- (void)clearPeripheralWithPurposeConnectType:(CCPrinterConnectPurposeType)connectType peripheral:(CCPeripheral *)peripheral {
    switch (connectType) {
        case CCPrinterConnectPurposeAll:
            _orderPeripheral = nil;
            _labelPeripheral = nil;
            _deliveryPeripheral = nil;
            _orderSocket = nil;
            break;
        case CCPrinterConnectPurposeOrder:
            if (peripheral.peripheralType == CCPrinterPeripheralWifi) {
                _orderSocket = nil;
            } else {
                _orderPeripheral = nil;
            }
            break;
        case CCPrinterConnectPurposeLabel:
            _labelPeripheral = nil;
            break;
        case CCPrinterConnectPurposeDelivery:
            _deliveryPeripheral = nil;
            break;
        default:
            
            break;
    }
}

- (void)resetBrandManager {
    _appointedinstructionType = CCPrintInstructionNone;
    _appointedPeripheral = nil;
}

- (NSString *)getPeripheralNameWithConnectType:(CCPrinterConnectPurposeType)connectType {
    id object = [self getPeripheralWithConnectType:connectType];
    if (object && [object isKindOfClass:[CCPeripheral class]]) {
        CCPeripheral *peripheral = object;
        return CheckString(peripheral.rename, YES, peripheral.originName);
    } else if (object && [object isKindOfClass:GCDAsyncSocket.class]) {
        return @"WiFi";
    } else {
        return @"";
    }
}

- (id)getPeripheralWithConnectType:(CCPrinterConnectPurposeType)connectType {
    switch (connectType) {
        case CCPrinterConnectPurposeAll:
        {
            NSMutableArray *uuidStrings = [NSMutableArray array];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (_orderPeripheral) {
                [uuidStrings addObject:_orderPeripheral.per.identifier.UUIDString];
                [tempArray addObject:_orderPeripheral];
            }
            if (_labelPeripheral && ![uuidStrings containsObject:_labelPeripheral.per.identifier.UUIDString]) {
                [uuidStrings addObject:_labelPeripheral.per.identifier.UUIDString];
                [tempArray addObject:_labelPeripheral];
            }
            if (_deliveryPeripheral && ![uuidStrings containsObject:_deliveryPeripheral.per.identifier.UUIDString]) {
                [uuidStrings addObject:_deliveryPeripheral.per.identifier.UUIDString];
                [tempArray addObject:_deliveryPeripheral];
            }
            return tempArray;
        }
        case CCPrinterConnectPurposeOrder:
            return _orderSocket ? _orderSocket : _orderPeripheral;
        case CCPrinterConnectPurposeLabel:
            return _labelPeripheral;
        case CCPrinterConnectPurposeDelivery:
            return _deliveryPeripheral;
        default:
            return nil;
            break;
    }
}

- (void)checkAndConfirmPeripheral {
    _currentPeripheral = nil;
    if (_orderPeripheral && (_currentTaskModel & _orderPeripheral.brandType & CCPrinterConnectPurposeOrder)) {
        _currentPeripheral = _orderPeripheral;
    } else if (_labelPeripheral && (_currentTaskModel & _labelPeripheral.brandType & CCPrinterConnectPurposeLabel)) {
        _currentPeripheral = _labelPeripheral;
    } else if (_deliveryPeripheral && (_currentTaskModel & _deliveryPeripheral.brandType & CCPrinterConnectPurposeDelivery)) {
        _currentPeripheral = _deliveryPeripheral;
    }
    // 提货单也可以用运单打印机打印
    if (_currentTaskModel == CMPrintTaskModelDelivery80 || _currentTaskModel == MMPrintTaskModelDelivery80) {
        if (_currentPeripheral == nil && _orderPeripheral) {
            _currentPeripheral = _orderPeripheral;
        }
    }
}

@end
