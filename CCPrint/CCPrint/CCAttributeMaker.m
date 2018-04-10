//
//  CCAttributeMaker.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCAttributeMaker.h"
#import "CCAttribute+Private.h"
#import "CCPrintAttribute.h"
#import "CCCompositeAttribute.h"

@interface CCAttributeMaker ()<CCAttributeDelegate>

@property (nonatomic, strong) NSMutableArray<CCAttribute *> *attributes;

@end

@implementation CCAttributeMaker

- (instancetype)init {
    if (self = [super init]) {
        _attributes = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)install {
    NSArray *attributes = self.attributes.copy;
    for (CCAttribute *attribute in attributes) {
        attribute.updateExisting = self.updateExisting;
        attribute.useExisting = self.useExisting;
        attribute.autoExisting = self.autoExisting;
        [attribute install];
    }
    [self.attributes removeAllObjects];
    return attributes;
}

#pragma mark - CCAttributeDelegate

- (void)attribute:(CCAttribute *)attribute shouldBeReplacedWithAttribute:(CCAttribute *)replacementAttribute {
    NSUInteger index = [self.attributes indexOfObject:attribute];
    NSAssert(index != NSNotFound, @"Could not find attribute %@", attribute);
    [self.attributes replaceObjectAtIndex:index withObject:replacementAttribute];
}

- (__kindof CCAttribute *)attribute:(CCAttribute *)attribute addAttributeWithAttributeType:(CCPrintAttributeType)attributeType {
    //创建printAttribute
    CCPrintAttribute *newPrintAttribute = [[CCPrintAttribute alloc] initWithPrintTashType:attributeType];
    
    //attribute不为nil是，就和newPrintAttribute合并组合成CCCompositeAttribute对象
    if ([attribute isKindOfClass:CCPrintAttribute.class]) {
        NSArray *attributes = @[attribute, newPrintAttribute];
        CCCompositeAttribute *compositeAttribute = [[CCCompositeAttribute alloc] initWithAttributes:attributes];
        compositeAttribute.delegate = self;
        [self attribute:attribute shouldBeReplacedWithAttribute:compositeAttribute];
        return compositeAttribute;
    }
    
    if (!attribute) {
        //设置代理-CCAttributeDelegate，为了CCPrintAttribute也可以调用该方法
        newPrintAttribute.delegate = self;
        [self.attributes addObject:newPrintAttribute];
    }
    return newPrintAttribute;
}

#pragma mark - standard Attributes

- (CCAttribute *)addAttributeWithAttributeType:(CCPrintAttributeType)attributeType {
    return [self attribute:nil addAttributeWithAttributeType:attributeType];
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
