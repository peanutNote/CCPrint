//
//  CCCompositeAttribute.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCCompositeAttribute.h"
#import "CCAttribute.h"
#import "CCAttribute+Private.h"

@interface CCCompositeAttribute ()<CCAttributeDelegate>

@property (nonatomic, strong) NSMutableArray *attributes;

@end

@implementation CCCompositeAttribute

- (instancetype)initWithAttributes:(NSArray *)attributes {
    if (self = [super init]) {
        _attributes = [attributes mutableCopy];
        for (CCAttribute *attribute in _attributes) {
            attribute.delegate = self;
        }
    }
    return self;
}

#pragma mark - CCAttributeDelegate

- (void)attribute:(CCAttribute *)attribute shouldBeReplacedWithAttribute:(CCAttribute *)replacementAttribute {
    NSUInteger index = [self.attributes indexOfObject:attribute];
    NSAssert(index != NSNotFound, @"Could not find attribute %@", attribute);
    [self.attributes replaceObjectAtIndex:index withObject:replacementAttribute];
}

- (CCAttribute *)attribute:(CCAttribute *)attribute addAttributeWithAttributeType:(CCPrintAttributeType)attributeType {
    id<CCAttributeDelegate> strongDelegate = self.delegate;
    CCAttribute *newAttribute = [strongDelegate attribute:self addAttributeWithAttributeType:attributeType];
    newAttribute.delegate = self;
    [self.attributes addObject:newAttribute];
    return newAttribute;
}

#pragma mark - 重写父类方法

- (void)install {
    for (CCAttribute *attribute in self.attributes) {
        attribute.updateExisting = self.updateExisting;
        attribute.useExisting = self.useExisting;
        attribute.autoExisting = self.autoExisting;
        [attribute install];
    }
}

- (CCAttribute * (^)(id))valueOfAttribute {
    return ^id(id attr) {
        for (CCAttribute *attribute in self.attributes) {
            attribute.valueOfAttribute(attr);
        }
        return self;
    };
}

- (void)setValuePrint:(CGFloat __unused)valuePrint {
    for (CCAttribute *attribute in _attributes) {
        attribute.valuePrint = valuePrint;
    }
}

- (void)setValuePosition:(CGPoint __unused)valuePointion {
    for (CCAttribute *attribute in _attributes) {
        attribute.valuePosition = valuePointion;
    }
}

- (void)setValueSize:(CGSize __unused)valueSize {
    for (CCAttribute *attribute in _attributes) {
        attribute.valueSize = valueSize;
    }
}

- (void)setValueRect:(CGRect __unused)valueRect {
    for (CCAttribute *attribute in _attributes) {
        attribute.valueRect = valueRect;
    }
}

@end
