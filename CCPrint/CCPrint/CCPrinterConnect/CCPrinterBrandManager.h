//
//  CCPrinterBrandManager.h
//  CMM
//
//  Created by qianye on 2017/9/12.
//  Copyright © 2017年 chemanman. All rights reserved.
//
//  以连接的品牌打印

#import <Foundation/Foundation.h>
#import "CCPrintDefine.h"
@class CBPeripheral;
@class CBCharacteristic;
@class CCPeripheral;
@class GCDAsyncSocket;

@interface CCPrinterBrandManager : NSObject

/// 打印模板，每次打印机开始需要设置打印模板
@property (nonatomic, assign) CCPrintTaskModelType currentTaskModel;
/// 根据打印模板返回打印张纸宽度
@property (nonatomic, assign, getter=getContentWidthType) CCPrintContentWidthType contentWidthType;
/// 指定打印机，后续打印机处理全以此打印机为准
@property (nonatomic, strong) CCPeripheral *appointedPeripheral;
/// 指定打印机指令，后续指令处理全以此指令为准
@property (nonatomic, assign) CCPrintInstructionType appointedinstructionType;

/// 根据传入的连接类型返回对应连接上的打印机
- (id)getPeripheralWithConnectType:(CCPrinterConnectPurposeType)connectType;
/// 设置打印机模板以后就可以调用此方法获取打印机指令
- (CCPrintInstructionType)getInstructionType;
/// 根据传入的连接类型返回对应打印机的名字
- (NSString *)getPeripheralNameWithConnectType:(CCPrinterConnectPurposeType)connectType;
/// 打印数据
- (void)printData:(NSData *)data;
/// 重制对象，准备下次打印
- (void)resetBrandManager;
/**
 设置不同连接的打印机品牌

 @param connectType 打印机连接类型
 @param peripheral 要连接的外设
 */
- (void)setPeripheralWithPurposeConnectType:(CCPrinterConnectPurposeType)connectType peripheral:(CCPeripheral *)peripheral;
/**
 清除打印机连接

 @param connectType 打印机连接类型
 @param peripheral 已连接的外设
 */
- (void)clearPeripheralWithPurposeConnectType:(CCPrinterConnectPurposeType)connectType peripheral:(CCPeripheral *)peripheral;
@end
