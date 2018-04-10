//
//  CCPrintDefine.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//
//  打印须知：200DPI:1mm=8dots

#ifndef CCPrintDefine_h
#define CCPrintDefine_h

#define kCCPeripheralsPlist     @"peripherals.plist"

/// 打印机连接类型
typedef NS_ENUM(NSInteger, CCPrinterConnectType) {
    CCPrinterConnectNone = 0,
    CCPrinterConnectBluetooth,     // 蓝牙连接
    CCPrinterConnectWiFi,           // wifi连接
};

/// 打印连接用途
typedef NS_ENUM(NSInteger, CCPrinterConnectPurposeType) {
    CCPrinterConnectPurposeAll = 16,
    CCPrinterConnectPurposeOrder = 0x01 << 16,          // 运单打印
    CCPrinterConnectPurposeLabel = 0x01 << 17,          // 标签打印
//    CCPrinterConnectPurposeLoadList = 0x01 << 18,       // 装车清单
    CCPrinterConnectPurposeDelivery = 0x01 << 19        // 提货单打印
};

/// 打印机打印指令
typedef NS_ENUM(NSInteger, CCPrintInstructionType) {
    CCPrintInstructionNone = 8,  // 指令集
    CCPrintInstructionESC = 0x01 << 8, // esc指令集
    CCPrintInstructionTSC = 0x01 << 9,  // tsc指令集
    CCPrintInstructionCPCL = 0x01 << 10,  // cpcl指令集
    CCPrintInstructionESCP = 0x01 << 11,    // wifi打印
};

/// 打印机类型 低8位用于表示模板支持的指令，高8位用于表示模板对应用途打印机
typedef NS_ENUM(NSInteger, CCPrinterBrandType) {
    // 未知打印机名
    CCPrinterBrandUnkown,
    // 芝柯打印机
    CCPrinterBrandZICOX = (1 | CCPrinterConnectPurposeDelivery | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel | CCPrintInstructionCPCL),
    // 支持TSC指令的Xprinter
    CCPrinterBrandXprinter_TSC = (2 | CCPrinterConnectPurposeDelivery | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC),
    // 支持ESC指令的Xprinter
    CCPrinterBrandXprinter_ESC = (3 | CCPrinterConnectPurposeDelivery | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel | CCPrintInstructionESC),
    // 汉印打印机
    CCPrinterBrandHanYin = (4 | CCPrintInstructionCPCL | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery),
    // 瑞共打印机
    CCPrinterBrandRego = (5 | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery | CCPrintInstructionESC),
    // 映美打印机
    CCPrinterBrandJolimark = (6 | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery | CCPrintInstructionESCP),
    
    // ESC不含二维码
    CCPrinterBrandESC_DEFAULT = (7 | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery | CCPrintInstructionESC),
    // ESC含二维码
    CCPrinterBrandESC_WITH_QR = (8 | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery | CCPrintInstructionESC),
    // TSC类打印机
    CCPrinterBrandTSC = (9 | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery | CCPrintInstructionTSC),
    // CPCL
    CCPrinterBrandCPCL = (10 | CCPrinterConnectPurposeOrder | CCPrinterConnectPurposeLabel  | CCPrinterConnectPurposeDelivery | CCPrintInstructionCPCL)
};

/// 打印模版 低8位用于表示模板支持的指令，高8位用于表示模板对应用途打印机
typedef NS_ENUM(NSInteger, CCPrintTaskModelType) {
    // 自检页模板
    CMPrintTaskModelSELFTEST = (CCPrinterConnectPurposeAll | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL | CCPrintInstructionESCP),
    // 专业版提货单
    CMPrintTaskModelDelivery80 = (1 | CCPrinterConnectPurposeDelivery | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版快递专用标签(标签)
    CMPrintTaskModelExpressLabel = (2 | CCPrinterConnectPurposeLabel | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版快递专用标签(运单)
    CMPrintTaskModelExpressWaybill = (3 | CCPrinterConnectPurposeLabel | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版普通标签
    CMPrintTaskModelNormalLabel = (4 | CCPrinterConnectPurposeLabel | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版预开单小票
    CMPrintTaskModelNote80 = (5 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版一体化标签(标签)
    CMPrintTaskModelOnePieceLabel = (6 | CCPrinterConnectPurposeLabel | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版一体化标签(运单)
    CMPrintTaskModelOnePieceWaybill = (7 | CCPrinterConnectPurposeLabel | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版纵向58运单
    CMPrintTaskModelWayBill58 = (8 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版纵向80运单
    CMPrintTaskModelWayBill80 = (9 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版横向表格
    CMPrintTaskModelWayBill80Hor = (10 | CCPrinterConnectPurposeOrder | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版代收换票
    CMPrintTaskModelCollectionOnDelivery = (11 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionCPCL),
    // 专业版条码杠号离线开单机打印
    CMPrintTaskModelOfflineOrder = (12 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版打印高60标签
    CMPrintTaskModelHeight60Label = (13 | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 专业版自定义运单打印
    CCPrintTaskModelCustomOrder = (14 | CCPrinterConnectPurposeOrder | CCPrintInstructionTSC | CCPrintInstructionCPCL | CCPrintInstructionESC),
    // 专业版自定义标签打印
    CCPrintTaskModelCustomLabel = (15 | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC | CCPrintInstructionCPCL | CCPrintInstructionESC),
    
    // 通用版提货单
    MMPrintTaskModelDelivery80 = (16 | CCPrinterConnectPurposeDelivery | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版表格提货单
    MMPrintTaskModelDelivery80Table = (17 | CCPrinterConnectPurposeDelivery | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版快递专用标签(标签)
    MMPrintTaskModelExpressLabel = (17 | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版快递专用标签(运单)
    MMPrintTaskModelExpressWaybill = (17 | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版普通标签
    MMPrintTaskModelNormalLabel = (17 | CCPrinterConnectPurposeLabel | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版一体化标签(标签)
    MMPrintTaskModelOnePieceLabel = (17 | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版一体化标签(运单)
    MMPrintTaskModelOnePieceWaybill = (17 | CCPrinterConnectPurposeLabel | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版纵向58运单
    MMPrintTaskModelWayBill58 = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版纵向80运单
    MMPrintTaskModelWaybill80 = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版横向表格
    MMPrintTaskModelWayBill80Hor = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版精简表格
    MMPrintTaskModelWaybill80Simple = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版纵向表格
    MMPrintTaskModelWaybill80Ver = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionTSC | CCPrintInstructionCPCL),
    // 通用版代收换票
    MMPrintTaskModelCollectionOnDelivery = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionCPCL),
    // 通用版装车清单
    MMPrintTaskModelLoadDepartureList = (17 | CCPrinterConnectPurposeOrder | CCPrintInstructionESC | CCPrintInstructionCPCL),
    // 打印测试
    CCPrintTaskModelTest = (18 | CCPrinterConnectPurposeAll | CCPrintInstructionESC | CCPrintInstructionTSC | CCPrintInstructionCPCL),
};

/// 打印机支持任务类型定义
typedef NS_ENUM(NSInteger, CCPrintTaskType) {
    CCPrintTaskNone,        // 默认为空
    CCPrintTaskInit,        // 初始化
    CCPrintTaskCutPaper,    // 切纸
    CCPrintTaskSpacing,     // 打印末尾预留间隙
    CCPrintTaskGapSense,    // 自动走纸
    CCPrintTaskLine,        // 线段
    CCPrintTaskText,        // 文本打印
    CCPrintTaskBarcode,     // 条形码
    CCPrintTaskQrcode,      // 二维码
    CCPrintTaskImage,       // 自定义图片
    CCPrintTaskEnd          // 打印结束
};

/// 打印指令
typedef NS_ENUM(NSInteger, CCPrintAttributeType) {
    CCPrintAttributeNone,         // 默认为空
    CCPrintAttributeBold,         // 是否加粗
    CCPrintAttributeFont,         // 字体大小
    CCPrintAttributeAlign,        // 对齐方式
    CCPrintAttributeVertical,     // 是否垂直
    CCPrintAttributeMarginY,      // 行间距
    CCPrintAttributeHasNewLine,   // 换行
    CCPrintAttributePosition,     // 内容位置
    CCPrintAttributeSize,         // 内容大小
    CCPrintAttributeRect,         // 内容位置与大小
};

/// 打印纸张类型
typedef NS_ENUM(NSInteger, CCPrintContentWidthType) {
    CCPrintContentWidth80m,
    CCPrintContentWidth58m
};
#define kPrintContentPageWidth80m  80 * 8
#define kPrintContentPageWidth58m  58 * 8

/// 排版对齐方式
typedef NS_ENUM(Byte, CCPrintAlignType) {
    CCPrintAlignNone,
    CCPrintAlignLeft,
    CCPrintAlignCenter,
    CCPrintAlignRight
};

/// 打印字体设置
typedef NS_ENUM(Byte, CCPrintFont) {
    CCPrintFontType16 = 1 << 1,           // 16点阵字库
    CCPrintFontType24 = 1 << 2,           // 24点阵字库
    CCPrintFontSizeNormal = 1 << 3,       // 普通大小
    CCPrintFontSizeHeightTwice = 1 << 4,  // 高度放大为原来两倍
    CCPrintFontSizeWidthTwice = 1 << 5,   // 宽度放大到原来两倍
    CCPrintFontSizeBothTwice = 1 << 6,    // 宽高都放大到原来两倍
};

/// 打印字体大小，也可以通过CCPrinterFont自定义
typedef NS_ENUM(NSInteger, CCPrintFontSize) {
    CCPrintFontSizeM = (CCPrintFontType16 | CCPrintFontSizeNormal),     // M 16x
    CCPrintFontSizeL = (CCPrintFontType24 | CCPrintFontSizeNormal),     // L 24x
    CCPrintFontSizeX = 100,                                             // X 24x-32x
    CCPrintFontSizeXX = (CCPrintFontType16 | CCPrintFontSizeBothTwice), // XX 32x
    CCPrintFontSizeXXX = (CCPrintFontType24 | CCPrintFontSizeBothTwice) // XXX 48x
};

typedef NS_ENUM(NSInteger, CCBarcodeType) {
    CCBarcode128,
    CCBarcodeUPCA,
    CCBarcodeUPCE,
    CCBarcodeEAN13,
    CCBarcodeEAN8,
    CCBarcode39,
    CCBarcode93
};

typedef NS_ENUM(NSInteger, CCSizeLayoutType) {
    CCSizeLayoutRelative, // 相对布局
    CCSizeLayoutAbsolute  // 绝对布局
};

#pragma mark - 共用基类属性结构体

struct font {
    CCPrintFontSize fontSize;
    BOOL updateExisting;
    BOOL useExisting;
    BOOL autoExisting;
};
typedef struct font CCFont;

struct align {
    CCPrintAlignType alignType;
    BOOL updateExisting;
    BOOL useExisting;
    BOOL autoExisting;
};
typedef struct align CCAlign;

struct blod {
    BOOL isBlod;
    BOOL updateExisting;
    BOOL useExisting;
    BOOL autoExisting;
};
typedef struct blod CCBlod;

struct vertical {
    BOOL isVertical;
    BOOL updateExisting;
    BOOL useExistion;
    BOOL autoExisting;
};
typedef struct vertical CCVertical;

struct marginY {
    int marginY;
    BOOL updateExisting;
    BOOL useExistion;
    BOOL autoExisting;
};
typedef struct marginY CCMarginY;

#define CCMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"你必须在子类中复写%@", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]
#define CCInstruactionNotSupport() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"打印机不支持%@", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

#endif /* CCPrintDefine_h */
