//
//  CCPrintAttribute.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrintAttribute.h"
#import "CCAttribute+Private.h"
#import "CCPrintSingleTask.h"
#import "CCPrintManager.h"

@interface CCPrintAttribute ()

@property (nonatomic, assign) CGFloat valuePrint;
@property (nonatomic, assign) CGPoint valuePostition;
@property (nonatomic, assign) CGSize valueSize;
@property (nonatomic, assign) CGRect valueRect;
@property (nonatomic, assign) CCPrintAttributeType attributeType;

@end

@implementation CCPrintAttribute

- (instancetype)initWithPrintTashType:(CCPrintAttributeType)attributeType {
    if (self = [super init]) {
        _attributeType = attributeType;
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone __unused *)zone {
    CCPrintAttribute *attribute = [[CCPrintAttribute alloc] init];
    attribute.delegate = self.delegate;
    return attribute;
}

#pragma mark - 重写父类方法

- (void)install {
    // 获取当前打印任务
    CCPrint *currentPrinter = [[CCPrintManager sharePrinterManager] getCurrentPrinter];
    if (currentPrinter) {
        CCPrintSingleTask *singleTask = [currentPrinter getCurrentSingleTask];
        if (singleTask) {
            if (_attributeType == CCPrintAttributeFont) {
                CCFont font = {_valuePrint, self.updateExisting, self.useExisting, self.autoExisting};
                singleTask.font = font;
            } else if (_attributeType == CCPrintAttributeBold) {
                CCBlod blod = {_valuePrint, self.updateExisting, self.useExisting, self.autoExisting};
                singleTask.blod = blod;
            } else if (_attributeType == CCPrintAttributeVertical) {
                CCVertical vertical = {_valuePrint, self.updateExisting, self.useExisting, self.autoExisting};
                singleTask.vertical = vertical;
            } else if (_attributeType == CCPrintAttributeAlign) {
                CCAlign align = {_valuePrint, self.updateExisting, self.useExisting, self.autoExisting};
                singleTask.align = align;
            } else if (_attributeType == CCPrintAttributeMarginY) {
                CCMarginY marginY = {_valuePrint, self.updateExisting, self.useExisting, self.autoExisting};
                singleTask.marginY = marginY;
            } else if (_attributeType == CCPrintAttributeHasNewLine) {
                singleTask.hasNewLine = _valuePrint;
            } else if (_attributeType == CCPrintAttributePosition) {
                singleTask.x = _valuePostition.x;
                singleTask.y = _valuePostition.y;
            } else if (_attributeType == CCPrintAttributeSize) {
                singleTask.width = _valueSize.width;
                singleTask.height = _valueSize.height;
            } else if (_attributeType == CCPrintAttributeRect) {
                singleTask.x = _valueRect.origin.x;
                singleTask.y = _valueRect.origin.y;
                singleTask.width = _valueRect.size.width;
                singleTask.height = _valueRect.size.height;
            }
        }
    }
}

- (CCAttribute *)addAttributeWithAttributeType:(CCPrintAttributeType __unused)attributeType {
    return [self.delegate attribute:self addAttributeWithAttributeType:attributeType];
}

- (CCAttribute * (^)(id))valueOfAttribute {
    return ^id(id attribute) {
        id value;
        if ([attribute isKindOfClass:NSArray.class]) {
            value = [attribute firstObject];
        } else {
            value = attribute;
        }
        [self setPrintAttributeWithValue:value];
        return self;
    };
}

- (void)setValuePrint:(CGFloat __unused)valuePrint {
    _valuePrint = valuePrint;
}

- (void)setValuePosition:(CGPoint __unused)valuePointion {
    _valuePostition = valuePointion;
}

- (void)setValueSize:(CGSize __unused)valueSize {
    _valueSize = valueSize;
}

- (void)setValueRect:(CGRect __unused)valueRect {
    _valueRect = valueRect;
}

@end
