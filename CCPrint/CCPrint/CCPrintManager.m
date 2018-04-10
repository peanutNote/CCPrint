//
//  CCPrintManager.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrintManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CCPeripheral.h"
#import <SVProgressHUD.h>

@interface CCPrintManager ()
/// 打印参数定义对象，定义了不同指令下字体大小、对齐方式、字体样式、条形码编码格式等，还包括基础指令
@property (nonatomic, strong) CCPrint *print;

@end

static CCPrintManager *printerManager;

@implementation CCPrintManager

#pragma mark - Init Method

+ (CCPrintManager *)sharePrinterManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        printerManager = [[CCPrintManager alloc] init];
    });
    return printerManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        printerManager = [super allocWithZone:zone];
    });
    return printerManager;
    
}

- (instancetype)init {
    if (self = [super init]) {
        _printerBrandManager = [[CCPrinterBrandManager alloc] init];
        [self resetManager];
    }
    return self;
}

- (void)setInstructionType:(CCPrintInstructionType)instructionType {
    _printerBrandManager.appointedinstructionType = instructionType;
}

- (void)setPeripheral:(CCPeripheral *)peripheral {
    _printerBrandManager.appointedPeripheral = peripheral;
}

#pragma mark - Private Method


- (CCPrint *)getCurrentPrinter {
    return self.print;
}

- (void)resetManager {
    _layoutType = CCSizeLayoutRelative;
    [_printerBrandManager resetBrandManager];
}

- (void)setManagerWithPeripheral:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic connectType:(CCPrinterConnectPurposeType)purposeType {
    if (!peripheral && ![peripheral isKindOfClass:CBPeripheral.class]) {
        return;
    }
    if (!characteristic && ![characteristic isKindOfClass:CBCharacteristic.class]) {
        return;
    }
    CCPrinterConnectPurposeType type = CCPrinterConnectPurposeOrder;
    if (purposeType == CCPrinterConnectPurposeLabel) {
        type = CCPrinterConnectPurposeLabel;
    }
    CCPeripheral *ccPeripheral = [[CCPeripheral alloc] init];
    ccPeripheral.per = peripheral;
    ccPeripheral.chac = characteristic;
    ccPeripheral.isPrinterQ200 = NO;
    [_printerBrandManager setPeripheralWithPurposeConnectType:type peripheral:ccPeripheral];
}

- (BOOL)checkPrinterIsConnect:(CCPrinterConnectPurposeType)connectType {
    id object = [_printerBrandManager getPeripheralWithConnectType:connectType];
    return object ? YES : NO;
    return YES;
}

- (void)checkForPrinterManager {
    if (_layoutType == CCSizeLayoutAbsolute) {
        if (_layoutSize.height <= 0 || _layoutSize.width <= 0) {
            NSAssert(NO, @"当前布局方式需要传入有效的layoutSize");
        }
    }
}

#pragma mark - Public Method

- (BOOL)startPrintWithTaskModel:(CCPrintTaskModelType)taskModel {
    [_printerBrandManager setCurrentTaskModel:taskModel];
    CCPrintInstructionType instructionType = [_printerBrandManager getInstructionType];
    if (instructionType != CCPrintInstructionNone) {
        [self checkForPrinterManager];
        // 初始化打印指令处理类
        _print = [[CCPrint alloc] initWithInstructionType:instructionType layoutType:_layoutType layoutSize:_layoutSize printContentWidth:[_printerBrandManager getContentWidthType]];
        [self addInitInstruction];
        return YES;
    } else {
        [SVProgressHUD showErrorWithStatus:@"请正确连接打印机后重试"];
        return NO;
    }
}

- (void)addInitInstruction {
    [_print setSingleTaskWithContent:nil taskType:CCPrintTaskInit];
    [_print singleTaskEndEditing];
}

- (void)addText:(NSString *)text attributeBlock:(CCAttributeDefineBlock)block {
    [_print setSingleTaskWithContent:text taskType:CCPrintTaskText];
    block(_print);
    [_print singleTaskEndEditing];
}

- (void)addLineAttributeBlock:(CCAttributeDefineBlock)block {
    [_print setSingleTaskWithContent:nil taskType:CCPrintTaskLine];
    block(_print);
    [_print singleTaskEndEditing];
}

- (void)addBarcode:(NSString *)content attributeBlock:(CCAttributeDefineBlock)block {
    [_print setSingleTaskWithContent:content taskType:CCPrintTaskBarcode];
    block(_print);
    [_print singleTaskEndEditing];
}

- (void)addQRcode:(NSString *)content attributeBlock:(CCAttributeDefineBlock)block {
    [_print setSingleTaskWithContent:content taskType:CCPrintTaskQrcode];
    block(_print);
    [_print singleTaskEndEditing];
}

- (void)addGapSense {
    [_print setSingleTaskWithContent:nil taskType:CCPrintTaskGapSense];
    [_print singleTaskEndEditing];
}

- (void)addCutPaper {
    [_print setSingleTaskWithContent:nil taskType:CCPrintTaskCutPaper];
    [_print singleTaskEndEditing];
}

- (void)addPrintSpacing {
    [_print setSingleTaskWithContent:nil taskType:CCPrintTaskSpacing];
    [_print singleTaskEndEditing];
}

- (void)endPrint {
    [_print setSingleTaskWithContent:nil taskType:CCPrintTaskEnd];
    [_print singleTaskEndEditing];
    
    // 打印指令
    NSData *data = [_print getPrintData];
    [_printerBrandManager printData:data];
    // 还原打印设置
    [self resetManager];
}

- (void)printForCustomTemplateWithData:(NSData *)data {
    [_printerBrandManager printData:data];
}

@end
