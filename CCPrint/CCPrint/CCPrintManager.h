//
//  CCPrintManager.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPrint.h"
#import "CCPrint+QYAdditions.h"
#import "CCPrintUtilities.h"
#import "CCPrinterBrandManager.h"
@class CBPeripheral;
@class CBCharacteristic;

@interface CCPrintManager : NSObject

#pragma mark -

/// 布局方式，相对布局会自己计算打印内容宽高，绝对布局需要传入printSize，如果不传则依旧使用相对布局
@property (nonatomic, assign) CCSizeLayoutType layoutType;
/// 打印纸张的宽度及高度
@property (nonatomic, assign) CGSize layoutSize;
/// 打印机管理
@property (nonatomic, strong, readonly) CCPrinterBrandManager *printerBrandManager;

#pragma mark -

+ (CCPrintManager *)sharePrinterManager;

- (void)setManagerWithPeripheral:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic connectType:(CCPrinterConnectPurposeType)purposeType;

- (CCPrint *)getCurrentPrinter;

- (BOOL)checkPrinterIsConnect:(CCPrinterConnectPurposeType)connectType;

- (void)setInstructionType:(CCPrintInstructionType)instructionType;
- (void)setPeripheral:(CCPeripheral *)peripheral;

#pragma mark - 打印方法

/**
 开始打印，用于打印机初始化

 @param taskModel 打印模板
 */
- (BOOL)startPrintWithTaskModel:(CCPrintTaskModelType)taskModel;

/**
 向打印机输入一条打印文字指令

 @param block 回传打印对象
 */
- (void)addText:(NSString *)text attributeBlock:(CCAttributeDefineBlock)block;

/**
 打印一条线

 @param block 回传打印对象
 */
- (void)addLineAttributeBlock:(CCAttributeDefineBlock)block;

/**
 打印条形码

 @param content 条形码内容
 @param block 回传打印对象
 */
- (void)addBarcode:(NSString *)content attributeBlock:(CCAttributeDefineBlock)block;

/**
 打印二维码

 @param content 二维码内容
 @param block 回传打印对象
 */
- (void)addQRcode:(NSString *)content attributeBlock:(CCAttributeDefineBlock)block;


/**
 打印自动走纸
 */
- (void)addGapSense;

/**
 打印切纸
 */
- (void)addCutPaper;

/**
 打印末尾间距，方便shizi
 */
- (void)addPrintSpacing;

/**
 结束指令编辑并向打印机发送打印指令
 */
- (void)endPrint;

- (void)printForCustomTemplateWithData:(NSData *)data;

@end
