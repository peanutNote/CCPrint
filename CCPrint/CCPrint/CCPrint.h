//
//  CCPrint.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//
//  打印指令处理类，最终所有打印指令都会到此处转化为二进制数据最后传到打印机

#import <Foundation/Foundation.h>
#import "CCPrintDefine.h"
#import "CCPrintSingleTask.h"

@interface CCPrint : NSObject

#pragma mark - 基础功用指令、目前仅仅涉及字体与条码，后期可完善
/**
 字体大小
 */
@property (nonatomic) CCPrintFontSize fontSize;
/**
 排版对齐方式
 */
@property (nonatomic) CCPrintAlignType alignType;
/**
 是否加粗
 */
@property (nonatomic) BOOL isBold;
/**
 是否是垂直打印
 */
@property (nonatomic) BOOL isVertical;
/**
 距离上一行间距 dot
 */
@property (nonatomic) CGFloat marginY;

/// 打印的范围宽度
@property (nonatomic) int printConteWidth;

#pragma mark - 

/**
 初始化方法

 @param instructionType 当前需要使用的指令
 */
- (instancetype)initWithInstructionType:(CCPrintInstructionType)instructionType
                             layoutType:(CCSizeLayoutType)layoutType
                             layoutSize:(CGSize)layoutSize
                      printContentWidth:(CCPrintContentWidthType)printContentWidth;
- (void)singleTaskEndEditing;
- (CCPrintSingleTask *)getCurrentSingleTask;
- (NSData *)getPrintData;
- (NSData *)printTest;
- (void)setSingleTaskWithContent:(NSString *)content taskType:(CCPrintTaskType)taskType;

@end

typedef void(^CCAttributeDefineBlock)(CCPrint *print);
