//
//  CCPrint.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrint.h"
#import "Base_Instruaction.h"
#import "ESC_Instruaction.h"
#import "CPCL_Instruaction.h"
#import "TSC_Instruaction.h"
#import "ESCP_Instruaction.h"
#import "CCPrintDefine.h"

@interface CCPrint ()

@property (nonatomic, strong) NSMutableArray *printTasks;
@property (nonatomic, strong) Base_Instruaction *instruaction;
@property (nonatomic, strong) CCPrintSingleTask *singleTask;
/**
 打印指令
 */
@property (nonatomic, strong) NSMutableData *printBuffer;
@property (nonatomic) CCPrintInstructionType instructionType;

/**
 当前指令已打印的高度 针对纵向打印
 */
@property (nonatomic) CGFloat printedHeight;
/**
 记录临时打印高度
 */
@property (nonatomic) CGFloat tempPrintedHeight;
/**
 当前指令已打印的高度 针对横向打印
 */
@property (nonatomic) CGFloat printedWidth;
@property (nonatomic) CCSizeLayoutType layoutType;
@property (nonatomic) CGSize layoutSize;

@end

@implementation CCPrint

#pragma mark - Private Method

- (instancetype)initWithInstructionType:(CCPrintInstructionType)instructionType
                             layoutType:(CCSizeLayoutType)layoutType
                             layoutSize:(CGSize)layoutSize
                      printContentWidth:(CCPrintContentWidthType)printContentWidth {
    if (self = [super init]) {
        _instructionType = instructionType;
        // 确定布局
        _layoutSize = layoutSize;
        _layoutType = layoutSize.height > 0 ? layoutType : CCSizeLayoutRelative;
        // 初始化指令对象
        if (instructionType == CCPrintInstructionESC) {
            _instruaction = [[ESC_Instruaction alloc] init];
        } else if (instructionType == CCPrintInstructionTSC) {
            _instruaction = [[TSC_Instruaction alloc] init];
        } else if (instructionType == CCPrintInstructionCPCL) {
            _instruaction = [[CPCL_Instruaction alloc] init];
        } else if (instructionType == CCPrintInstructionESCP) {
            _instruaction = [[ESCP_Instruaction alloc] init];
        } else {
            NSAssert(NO, @"打印指令有误，请重新尝试");
        }
        // 确定打印纸张宽度
        if (printContentWidth == CCPrintContentWidth80m) {
            _printConteWidth = _instruaction.printConteWidth = kPrintContentPageWidth80m;
        } else {
            _printConteWidth = _instruaction.printConteWidth = kPrintContentPageWidth58m;
        }
        _printedWidth = 0;
        _printedHeight = 0;
        // 初始化存储类
        _printBuffer = NSMutableData.new;
        _printTasks = NSMutableArray.new;
    }
    return self;
}

- (void)setSingleTaskWithContent:(NSString *)content taskType:(CCPrintTaskType)taskType {
    self.singleTask = [[CCPrintSingleTask alloc] initWithContent:content taskType:taskType instructionType:_instructionType];
}

- (void)singleTaskEndEditing {
    if (_singleTask) {
        // 将打印任务添加到任务列表
        [_printTasks addObject:_singleTask];
    }
}

- (CCPrintSingleTask *)getCurrentSingleTask {
    if (_singleTask) {
        return _singleTask;
    }
    return nil;
}

- (NSData *)printTest {
    return [_instruaction printTest];
}

- (void)calculatePrintHeightWithSingleTask:(CCPrintSingleTask *)singleTask {
    // 计算当前高度
    CGFloat lineHeight = [singleTask getCurrentPrintHeight].height + [self getMarginYWithSingleTask:singleTask];
    if (singleTask.hasNewLine == NO) {
        if (_tempPrintedHeight < lineHeight) {
            _tempPrintedHeight = lineHeight;
        }
    } else {
        if (_tempPrintedHeight < lineHeight) {
            _tempPrintedHeight = lineHeight;
        }
        _printedHeight += _tempPrintedHeight;
        _tempPrintedHeight = 0;
    }
}

- (CGFloat)getMarginYWithSingleTask:(CCPrintSingleTask *)singleTask {
    CGFloat marginY = _marginY;
    if (singleTask.marginY.useExistion == NO) {
        marginY = singleTask.marginY.marginY;
    }
    return marginY;
}

- (CGSize)getPrintContentSize {
    if (_layoutType == CCSizeLayoutAbsolute) {
        return _layoutSize;
    } else {
        CGFloat printHeight = 0.0;
        CGFloat tempPrintHeight = 0.0;
        CCPrintFontSize fontSize = CCPrintFontSizeL;
        CCPrintAlignType alignType = CCPrintAlignLeft;
        BOOL isBold = NO;
        BOOL isVertical = NO;
        CGFloat marginY = 6;
        
        for (CCPrintSingleTask *singleTask in _printTasks) {
            if (singleTask.font.useExisting) {
                [singleTask setCCFont:fontSize];
            }
            if (singleTask.align.useExisting) {
                [singleTask setCCAlign:alignType];
            }
            if (singleTask.blod.useExisting) {
                [singleTask setCCBlod:isBold];
            }
            if (singleTask.vertical.useExistion) {
                [singleTask setCCVertical:isVertical];
            }
            if (singleTask.marginY.useExistion) {
                [singleTask setCCMarginY:marginY];
            }
            
            if (singleTask.font.updateExisting) {
                fontSize = singleTask.font.fontSize;
            }
            if (singleTask.align.updateExisting) {
                alignType = singleTask.align.alignType;
            }
            if (singleTask.blod.updateExisting) {
                isBold = singleTask.blod.isBlod;
            }
            if (singleTask.vertical.updateExisting) {
                isVertical = singleTask.vertical.isVertical;
            }
            if (singleTask.marginY.updateExisting) {
                marginY = singleTask.marginY.marginY;
            }
            
            CGFloat lineHeight = [singleTask getCurrentPrintHeight].height + (singleTask.marginY.useExistion ? marginY : singleTask.marginY.marginY);
            if (singleTask.hasNewLine == NO) {
                if (tempPrintHeight < lineHeight) {
                    tempPrintHeight = lineHeight;
                }
            } else {
                if (tempPrintHeight < lineHeight) {
                    tempPrintHeight = lineHeight;
                }
                printHeight += tempPrintHeight;
                tempPrintHeight = 0;
            }
        }
        return CGSizeMake(kPrintContentPageWidth80m, printHeight);
    }
}

#pragma mark - Setter&Getter

- (void)setPrintConteWidth:(int)printConteWidth {
    NSLog(@"只能在初始化打印前设置打印纸张宽度");
}

#pragma mark -

- (NSData *)getPrintData {
    CGSize printSize = [self getPrintContentSize];
    for (CCPrintSingleTask *singleTask in _printTasks) {
        // 添加打印任务
        if (singleTask.tashType == CCPrintTaskInit) {
            [_instruaction cc_printerInitDataBuffer:_printBuffer];
            [_instruaction cc_printerPageSize:printSize buffer:_printBuffer];
            [self setDefinedInstruaction:singleTask];
        } else {
            [self setDefinedInstruaction:singleTask];
            CGFloat yCursor = singleTask.y;
            if (_layoutType == CCSizeLayoutRelative) {
                yCursor = _printedHeight + [self getMarginYWithSingleTask:singleTask];
            }
            if (singleTask.tashType == CCPrintTaskText) {
                [_instruaction cc_printerTextData:singleTask.content x:singleTask.x y:yCursor width:singleTask.width buffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskLine) {
                [_instruaction cc_printerLineX:singleTask.x y:yCursor width:singleTask.width height:singleTask.height buffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskBarcode) {
                [_instruaction cc_printerBarcode:singleTask.content x:singleTask.x y:yCursor barcodeType:CCBarcode93 width:singleTask.width height:singleTask.height buffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskQrcode) {
                [_instruaction cc_printerQRcode:singleTask.content x:singleTask.x y:yCursor eccLevel:@"M" width:singleTask.width height:singleTask.height buffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskGapSense) {
                [_instruaction cc_printerGapSenseWithBuffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskCutPaper) {
                [_instruaction cc_printerCutWithBuffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskSpacing) {
                [_instruaction cc_printerSpacingWithBuffer:_printBuffer];
            } else if (singleTask.tashType == CCPrintTaskEnd)  {
                [_instruaction cc_printerEndBuffer:_printBuffer];
            }
        }
        // 更新附加属性指令
        [self updateDefinedInstruaction:singleTask];
        // 计算高度
        [self calculatePrintHeightWithSingleTask:singleTask];
    }
    return _printBuffer;
}

- (void)setDefinedInstruaction:(CCPrintSingleTask *)singleTask {
    // 确定字体大小
    if (singleTask.font.autoExisting) {
        if (singleTask.font.fontSize != _fontSize) {
            [_instruaction cc_printerFont:singleTask.font.fontSize buffer:_printBuffer];
        }
    } else if (!singleTask.font.useExisting) {
        [_instruaction cc_printerFont:singleTask.font.fontSize buffer:_printBuffer];
    }
    // 确定排版方式
    if (singleTask.align.autoExisting) {
        if (singleTask.align.alignType != _alignType) {
            [_instruaction cc_printerAlign:singleTask.align.alignType buffer:_printBuffer];
        }
    } else if (!singleTask.align.useExisting) {
        [_instruaction cc_printerAlign:singleTask.align.alignType buffer:_printBuffer];
    }
    // 确定是否加粗
    if (singleTask.blod.autoExisting) {
        if (singleTask.blod.isBlod != _isBold) {
            [_instruaction cc_printerBlod:singleTask.blod.isBlod buffer:_printBuffer];
        }
    } else if (!singleTask.blod.useExisting) {
        [_instruaction cc_printerBlod:singleTask.blod.isBlod buffer:_printBuffer];
    }
    // 确定是否垂直打印
    if (singleTask.vertical.autoExisting) {
        if (singleTask.vertical.isVertical != _isVertical) {
            [_instruaction cc_printerVertical:singleTask.vertical.isVertical buffer:_printBuffer];
        }
    } else if (!singleTask.vertical.useExistion) {
        [_instruaction cc_printerVertical:singleTask.vertical.isVertical buffer:_printBuffer];
    }
    // 确定行间距
    if (singleTask.marginY.autoExisting) {
        if (singleTask.marginY.marginY != _marginY) {

        }
    } else if (!singleTask.marginY.useExistion) {
        
    }
}

- (void)updateDefinedInstruaction:(CCPrintSingleTask *)singleTask {
    // 更新字体大小
    if (singleTask.font.updateExisting) {
        _fontSize = singleTask.font.fontSize;
    } else {
        if (!singleTask.font.useExisting) {
            [_instruaction cc_printerFont:_fontSize buffer:_printBuffer];
        }
    }
    // 更新排版方式
    if (singleTask.align.updateExisting) {
        _alignType = singleTask.align.alignType;
    } else {
        if (!singleTask.align.useExisting) {
            [_instruaction cc_printerAlign:_alignType buffer:_printBuffer];
        }
    }
    // 更新是否加粗
    if (singleTask.blod.updateExisting) {
        _isBold = singleTask.blod.isBlod;
    } else {
        if (!singleTask.blod.useExisting) {
            [_instruaction cc_printerBlod:_isBold buffer:_printBuffer];
        }
    }
    // 更新是否垂直
    if (singleTask.vertical.updateExisting) {
        _isVertical = singleTask.vertical.isVertical;
    } else {
        if (!singleTask.vertical.useExistion) {
            [_instruaction cc_printerVertical:_isVertical buffer:_printBuffer];
        }
    }
    // 更新行间距
    if (singleTask.marginY.updateExisting) {
        _marginY = singleTask.marginY.marginY;
    } else {
        if (!singleTask.marginY.useExistion) {
            // ESC需要用指令
        }
    }
}

@end
