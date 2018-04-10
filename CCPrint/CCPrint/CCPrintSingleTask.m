//
//  CCPrintSingleTask.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrintSingleTask.h"
#import "CCPrintManager.h"
#import "CCPrintUtilities.h"

@implementation CCPrintSingleTask {
    CCPrintInstructionType _instructionType;
}

- (instancetype)initWithContent:(NSString *)content taskType:(CCPrintTaskType)taskType instructionType:(CCPrintInstructionType)instructionType {
    if (self = [super init]) {
        _content = content ? : @"";
        _tashType = taskType;
        _instructionType = instructionType;
        
        // 初始化基础任务
        _hasNewLine = YES;
        BOOL updateExisting = NO;
        BOOL useExistion = NO;
        if (taskType == CCPrintTaskInit) {
            // 初始化指令需要更新
            updateExisting = YES;
        } else {
            useExistion = YES;
        }
        CCFont font = {CCPrintFontSizeL, updateExisting, useExistion, NO};
        _font = font;
        CCAlign align = {CCPrintAlignLeft, updateExisting, useExistion, NO};
        _align = align;
        CCBlod blod = {NO, updateExisting, useExistion, NO};
        _blod = blod;
        CCVertical vertical = {NO, updateExisting, useExistion, NO};
        _vertical = vertical;
        CCMarginY marginY = {6, updateExisting, useExistion, NO};
        _marginY = marginY;
    }
    return self;
}

- (void)setCCFont:(CCPrintFontSize)font {
    CCFont tempFont = {font, NO, YES, NO};
    _font = tempFont;
}
- (void)setCCAlign:(CCPrintAlignType)align {
    CCAlign tempAlign = {align, NO, YES, NO};
    _align = tempAlign;
}
- (void)setCCBlod:(BOOL)blod {
    CCBlod tempBlod = {blod, NO, YES, NO};
    _blod = tempBlod;
}
- (void)setCCVertical:(BOOL)vertical {
    CCVertical tempVertical = {vertical, NO, YES, NO};
    _vertical = tempVertical;
}
- (void)setCCMarginY:(CGFloat)marginY {
    CCMarginY tempMarginY = {marginY, NO, YES, NO};
    _marginY = tempMarginY;
}

- (CGSize)getCurrentPrintHeight {
    CGFloat height = 0.0;
    CGFloat width = 0.0;
    if (_height > 0) {
        height = _height;
    } else {
        if (_tashType == CCPrintTaskInit) {
            height = 40;
        } else if (_tashType == CCPrintTaskLine) {
            height = 1;
        } else if (_tashType == CCPrintTaskText) {
            // 获取打印指令
            CGSize textSize = [CCPrintUtilities calculateTextSize:_content fontSize:_font.fontSize instructionType:_instructionType];
            height = textSize.height;
        } else if (_tashType == CCPrintTaskBarcode) {
            height = [CCPrintUtilities calculateBarcodeWidth:_content barcodeType:CCBarcode93 instructionType:_instructionType];
        } else if (_tashType == CCPrintTaskQrcode) {
            height = 160;
        } else if (_tashType == CCPrintTaskSpacing) {
            height = 24;
        } else if (_tashType == CCPrintTaskEnd) {
            height = 40;
        }
    }
    return CGSizeMake(width, height);
}

@end
