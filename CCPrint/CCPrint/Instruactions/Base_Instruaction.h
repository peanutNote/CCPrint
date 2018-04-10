//
//  Base_Instruaction.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//
//  打印基类抽象类

#import <UIKit/UIKit.h>
#import "CCPrintDefine.h"

@interface Base_Instruaction : NSObject

/// 打印的范围宽度 mm
@property (nonatomic) int printConteWidth;

#pragma mark - 打印任务类型

/**
 初始化打印机
 
 @param buffer 打印数据流
 */
- (void)cc_printerInitDataBuffer:(NSMutableData *)buffer;

/**
 打印一段文字

 @param text 打印内容
 @param x x起始坐标
 @param y y起始坐标
 @param width 内容宽度
 @param buffer 打印数据流
 */
- (void)cc_printerTextData:(NSString *)text x:(int)x y:(int)y width:(int)width buffer:(NSMutableData *)buffer;

/**
 打印一条线

 @param x x起始坐标
 @param y y起始坐标
 @param height 线粗
 @param buffer 打印数据流
 */
- (void)cc_printerLineX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer;

/**
 切纸指令

 @param buffer 打印数据流
 */
- (void)cc_printerCutWithBuffer:(NSMutableData *)buffer;

/**
 自动走纸指令

 @param buffer 打印数据流
 */
- (void)cc_printerGapSenseWithBuffer:(NSMutableData *)buffer;

/**
 打印结束预留间距

 @param buffer 打印数据流
 */
- (void)cc_printerSpacingWithBuffer:(NSMutableData *)buffer;

/**
 打印条形码

 @param content 条形码内容
 @param x x起始坐标
 @param y y起始坐标
 @param barcodeType 条码编码
 @param height 条码高度
 @param buffer 打印数据流
 */
- (void)cc_printerBarcode:(NSString *)content x:(int)x y:(int)y barcodeType:(CCBarcodeType)barcodeType width:(int)width height:(int)height buffer:(NSMutableData *)buffer;

- (void)cc_printerQRcode:(NSString *)content x:(int)x y:(int)y eccLevel:(NSString *)eccLevel width:(int)width height:(int)height buffer:(NSMutableData *)buffer;

/**
 打印位图

 @param imageData 位图数据
 @param x x起始坐标
 @param y y起始坐标
 @param width 图片宽度
 @param height 图片高度
 @param buffer 打印数据流
 */
- (void)cc_printerBitmap:(NSData *)imageData x:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer;

/**
 打印结束

 @param buffer 打印数据流
 */
- (void)cc_printerEndBuffer:(NSMutableData *)buffer;

#pragma mark - 公用指令

/**
 设定标签纸的宽度和高度
 
 @param size 纸张宽高
 @param buffer 打印数据流
 */
- (void)cc_printerPageSize:(CGSize)size buffer:(NSMutableData *)buffer;

/**
 设定打印字体大小
 
 @param fontSize 字体大小
 */
- (void)cc_printerFont:(CCPrintFontSize)fontSize buffer:(NSMutableData *)buffer;

/**
 设定打印对齐方式,优先级高于x，y
 
 @param alignType 字体大小
 */
- (void)cc_printerAlign:(CCPrintAlignType)alignType buffer:(NSMutableData *)buffer;

/**
 设定打印加粗
 
 @param isBlod 字体大小
 */
- (void)cc_printerBlod:(BOOL)isBlod buffer:(NSMutableData *)buffer;;

/**
 设定是否垂直打印

 @param isVertical 是否是垂直打印
 */
- (void)cc_printerVertical:(BOOL)isVertical buffer:(NSMutableData *)buffer;


/**
 打印测试
 */
- (NSData *)printTest;

@end
