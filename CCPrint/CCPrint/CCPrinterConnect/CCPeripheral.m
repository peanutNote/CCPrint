//
//  CCPeripheral.m
//  CMM
//
//  Created by qianye on 2017/10/12.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPeripheral.h"
#import "CCPrintUtilities.h"
#import "GCDAsyncSocket.h"

@interface CCPeripheral()

@end

@implementation CCPeripheral

- (BOOL)checkPeripheral {
    if (_per.name.length) {
        return YES;
    }
    return NO;
}

- (void)setPer:(CBPeripheral<CCIgnore> *)per {
    _per = per;
    // 初始默认值
    self.rename = @"";
    self.originName = _per.name;
    self.identifier = _per.identifier.UUIDString;
    self.customModel = @0;
    [self setBrandTypeWithName:self.originName];
    
    // 确认打印机
    CCPeripheral *localPeripheral = [CCPrintUtilities getPeripheralWithUUIDString:_identifier];
    if (localPeripheral) {
        self.rename = localPeripheral.rename;
        self.customModel = localPeripheral.customModel;
        [self updateBrandType];
    }
}

- (void)setSocket:(GCDAsyncSocket<CCIgnore> *)socket {
    _socket = socket;
    CCPeripheral *localPeripheral = [CCPrintUtilities getPeripheralWithUUIDString:_identifier];
    if (localPeripheral) {
        self.rename = localPeripheral.rename;
        self.customModel = localPeripheral.customModel;
        [self updateBrandType];
    }
}

- (CCPrinterPeripheralConnectState)connectState {
    if (_peripheralType == CCPrinterPeripheralBluetooth) {
        if (_per.state == CBPeripheralStateConnected) {
            return CCPrinterPeripheralConnected;
        } else if (_per.state == CBPeripheralStateDisconnected) {
            return CCPrinterPeripheralUnconnect;
        } else if (_per.state == CBPeripheralStateConnecting) {
            return CCPrinterPeripheralConnecting;
        }
    } else {
        if (_socket.isConnected) {
            return CCPrinterPeripheralConnected;
        } else {
            return _connectState;
        }
    }
    return CCPrinterPeripheralUnconnect;
}

/// 通过打印机名字确认打印机类型，优先级较低
- (void)setBrandTypeWithName:(NSString *)name {
    if ([name isEqualToString:@"XT4131A"]) {
        self.brandType = CCPrinterBrandZICOX;
    } else if ([name isEqualToString:@"Printer001"]) {
        if (_isPrinterQ200) {
            self.brandType = CCPrinterBrandXprinter_ESC;
        } else {
            self.brandType = CCPrinterBrandXprinter_TSC;
        }
    } else if ([name isEqualToString:@"Printer_3B62"]) {
        self.brandType = CCPrinterBrandXprinter_TSC;
    } else if ([name isEqualToString:@"QR380A"]) {
        self.brandType = CCPrinterBrandHanYin;
    } else if ([name isEqualToString:@"HM-A300"]) {
        self.brandType = CCPrinterBrandHanYin;
    } else if ([name isEqualToString:@"RG-MTP80B"]) {
        self.brandType = CCPrinterBrandRego;
    }  else if ([name isEqualToString:@"RG-MTP80A"]) {
        self.brandType = CCPrinterBrandRego;
    } else {
        self.brandType = CCPrinterBrandUnkown;
    }
}

/// 通过打印机自定mode合名称后缀确定打印机类型，优先级高
- (void)updateBrandType {
    NSInteger customModel = [self.customModel integerValue];
    if (customModel == 1) {
        self.brandType = CCPrinterBrandESC_DEFAULT;
    } else if (customModel == 2) {
        self.brandType = CCPrinterBrandESC_WITH_QR;
    } else if (customModel == 3) {
        self.brandType = CCPrinterBrandCPCL;
    } else if (customModel == 4) {
        self.brandType = CCPrinterBrandTSC;
    } else {
        // 判断打印机名字
        if (self.rename.length) {
            NSString *rename = [self.rename uppercaseString];
            if ([rename hasSuffix:@"__MP_E"]) {
                self.brandType = CCPrinterBrandESC_DEFAULT;
            } else if ([rename hasSuffix:@"__MP_EQ"]) {
                self.brandType = CCPrinterBrandESC_WITH_QR;
            } else if ([rename hasSuffix:@"__MP_T"] || [rename hasSuffix:@"_GP_T"]) {
                self.brandType = CCPrinterBrandTSC;
            } else if ([rename hasSuffix:@"__MP_Z"] || [rename hasSuffix:@"_HP_C"]) {
                self.brandType = CCPrinterBrandCPCL;
            }
        }
    }
}

- (CCPrintInstructionType)getInstructionType {
    switch (_brandType) {
        case CCPrinterBrandUnkown:
            return CCPrintInstructionNone;
            break;
        case CCPrinterBrandZICOX:
            return CCPrintInstructionCPCL;
            break;
        case CCPrinterBrandXprinter_TSC:
            return CCPrintInstructionTSC;
            break;
        case CCPrinterBrandXprinter_ESC:
            return CCPrintInstructionESC;
            break;
        case CCPrinterBrandHanYin:
            return CCPrintInstructionCPCL;
            break;
        case CCPrinterBrandRego:
            return CCPrintInstructionESC;
            break;
        case CCPrinterBrandJolimark:
            return CCPrintInstructionESCP;
            break;
        case CCPrinterBrandESC_DEFAULT:
            return CCPrintInstructionESC;
            break;
        case CCPrinterBrandESC_WITH_QR:
            return CCPrintInstructionESC;
            break;
        case CCPrinterBrandTSC:
            return CCPrintInstructionTSC;
            break;
        case CCPrinterBrandCPCL:
            return CCPrintInstructionCPCL;
            break;
        default:
            break;
    }
    return CCPrintInstructionNone;
}

@end
