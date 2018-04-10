//
//  CCAttribute.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCAttribute.h"
#import "CCAttribute+Private.h"
#import "CCPrintDefine.h"

@implementation CCAttribute

- (id)init {
    NSAssert(![self isMemberOfClass:[CCAttribute class]], @"该类是一个抽象类，不能直接实例化");
    return [super init];
}

- (CCAttribute *(^)(id))value {
    return ^id(id value) {
        return self.valueOfAttribute(value);
    };
}

- (CCAttribute * (^)(CGFloat printVvaluePrintalue))valuePrint {
    return ^id(CGFloat valuePrint) {
        self.valuePrint = valuePrint;
        return self;
    };
}

- (CCAttribute * (^)(CGPoint position))valuePosition {
    return ^id(CGPoint valuePosition) {
        self.valuePosition = valuePosition;
        return self;
    };
}

- (CCAttribute * (^)(CGSize size))valueSize {
    return ^id(CGSize valueSize) {
        self.valueSize = valueSize;
        return self;
    };
}

- (CCAttribute * (^)(CGRect rect))valueRect {
    return ^id(CGRect valueRect) {
        self.valueRect = valueRect;
        return self;
    };
}

- (void)setPrintAttributeWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.valuePrint = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.valuePosition = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.valueSize = size;
    } else if (strcmp(value.objCType, @encode(CGRect)) == 0) {
        CGRect rect;
        [value getValue:&rect];
        self.valueRect = rect;
    } else {
        NSAssert(NO, @"该属性不支持此类数值: %@", value);
    }
}

#pragma mark - Abstract

- (void)install { CCMethodNotImplemented(); }

- (CCAttribute * (^)(id))valueOfAttribute { CCMethodNotImplemented(); }
- (void)setValuePrint:(CGFloat __unused)valuePrint { CCMethodNotImplemented(); }
- (void)setValuePosition:(CGPoint __unused)valuePointion { CCMethodNotImplemented(); }
- (void)setValueSize:(CGSize __unused)valueSize { CCMethodNotImplemented(); }
- (void)setValueRect:(CGRect __unused)valueRect { CCMethodNotImplemented(); }

#pragma mark - Chaining

- (CCAttribute *)addAttributeWithAttributeType:(CCPrintAttributeType __unused)attributeType {
    CCMethodNotImplemented();
}

- (CCAttribute *)font {
    return [self addAttributeWithAttributeType:CCPrintAttributeFont];
}

- (CCAttribute *)bold {
    return [self addAttributeWithAttributeType:CCPrintAttributeBold];
}

- (CCAttribute *)align {
    return [self addAttributeWithAttributeType:CCPrintAttributeAlign];
}

- (CCAttribute *)position {
    return [self addAttributeWithAttributeType:CCPrintAttributePosition];
}

- (CCAttribute *)size {
    return [self addAttributeWithAttributeType:CCPrintAttributeSize];
}

- (CCAttribute *)rect {
    return [self addAttributeWithAttributeType:CCPrintAttributeRect];
}

- (CCAttribute *)vertical {
    return [self addAttributeWithAttributeType:CCPrintAttributeVertical];
}

- (CCAttribute *)marginY {
    return [self addAttributeWithAttributeType:CCPrintAttributeMarginY];
}

- (CCAttribute *)hasNewLine {
    return [self addAttributeWithAttributeType:CCPrintAttributeHasNewLine];
}

@end
