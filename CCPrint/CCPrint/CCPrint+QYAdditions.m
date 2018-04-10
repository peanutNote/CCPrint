//
//  CCPrint+QYAdditions.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrint+QYAdditions.h"

@implementation CCPrint (QYAdditions)

- (NSArray *)cc_aloneAttributes:(CCAttributeConfigBlock)block {
    CCAttributeMaker *attributeMaker = [[CCAttributeMaker alloc] init];
    attributeMaker.useExisting = NO;
    attributeMaker.updateExisting = NO;
    attributeMaker.autoExisting = NO;
    block(attributeMaker);
    return [attributeMaker install];
}

- (NSArray *)cc_updateAttributes:(CCAttributeConfigBlock)block {
    CCAttributeMaker *attributeMaker = [[CCAttributeMaker alloc] init];
    attributeMaker.useExisting = NO;
    attributeMaker.updateExisting = YES;
    attributeMaker.autoExisting = NO;
    block(attributeMaker);
    return [attributeMaker install];
}

- (NSArray *)cc_multiplexAttributes:(CCAttributeConfigBlock)block {
    CCAttributeMaker *attributeMaker = [[CCAttributeMaker alloc] init];
    attributeMaker.useExisting = YES;
    attributeMaker.updateExisting = NO;
    attributeMaker.autoExisting = NO;
    block(attributeMaker);
    return [attributeMaker install];
}

- (NSArray *)cc_automaticAttributes:(CCAttributeConfigBlock)block {
    CCAttributeMaker *attributeMaker = [[CCAttributeMaker alloc] init];
    attributeMaker.useExisting = NO;
    attributeMaker.updateExisting = YES;
    attributeMaker.autoExisting = YES;
    block(attributeMaker);
    return [attributeMaker install];
}

@end
