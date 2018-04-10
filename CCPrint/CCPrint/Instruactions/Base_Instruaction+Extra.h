//
//  Base_Instruaction+Extra.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/12.
//  Copyright © 2017年 qianye. All rights reserved.
//
//  主要用于定义各指令特有操作

#import "Base_Instruaction.h"

@interface Base_Instruaction (ESC)

@end

@interface Base_Instruaction (CPCL)

@end

@interface Base_Instruaction (TSC)

/**
 定义两张标签纸中间的间隙高度
 
 @param m 两张标签中间的间隙高度
 @param n 间隙偏移量
 @param buffer 打印数据流
 */
- (void)cc_TSCGapM:(int)m n:(int)n buffer:(NSMutableData *)buffer;

/**
 设定打印机速度
 
 @param n 速度值(参数：speed 速度 1.5 2.0 3.0 4.0)
 @param buffer 打印数据流
 */
- (void)cc_TSCSpeed:(float)n buffer:(NSMutableData *)buffer;

/**
 定义打印时的浓度
 
 @param n 0～15
 @param buffer 打印数据流
 */
- (void)cc_TSCDensity:(int)n buffer:(NSMutableData *)buffer;

/**
 设定打印出纸和字体方向
 
 @param n 0或者1
 @param buffer 打印数据流
 */
- (void)cc_TSCDirection:(int)n buffer:(NSMutableData *)buffer;


@end
