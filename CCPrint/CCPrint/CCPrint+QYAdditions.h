//
//  CCPrint+QYAdditions.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrint.h"
#import "CCAttributeMaker.h"

@interface CCPrint (QYAdditions)

/**
 不使用已定义的基础指令添加约束，添加完以后也不改变原基础指令的内容
 
 @param block 包含CCAttributeMaker对象的回调
 @return 打印属性数组
 */
- (NSArray *)cc_aloneAttributes:(CCAttributeConfigBlock)block;

/**
 不使用已定义的基础指令添加约束，添加完以后改变原基础指令的内容

 @param block 包含CCAttributeMaker对象的回调
 @return 打印属性数组
 */
- (NSArray *)cc_updateAttributes:(CCAttributeConfigBlock)block;

/**
 使用已定义的基础指令添加约束，添加完以后也不改变原基础指令的内容
 
 @param block 包含CCAttributeMaker对象的回调
 @return 打印属性数组
 */
- (NSArray *)cc_multiplexAttributes:(CCAttributeConfigBlock)block;

/**
 自动判断如果跟已定义基础指令相同则使用否则不使用，添加完以后改变原基础指令的内容
 
 @param block 包含CCAttributeMaker对象的回调
 @return 打印属性数组
 */
- (NSArray *)cc_automaticAttributes:(CCAttributeConfigBlock)block;

@end
