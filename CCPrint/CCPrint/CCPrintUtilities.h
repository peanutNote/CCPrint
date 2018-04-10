//
//  CCPrintUtilities.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPrintDefine.h"
@class CCPeripheral;

@interface CCPrintUtilities : NSObject

/**
 计算字体大小，默认字与字之间的间距为4dot

 @param text 需要计算的文本
 @param fontSize 字体格式
 @param instructionType 指令格式
 @return 计算完成后的大小
 */
+ (CGSize)calculateTextSize:(NSString *)text fontSize:(CCPrintFontSize)fontSize instructionType:(CCPrintInstructionType)instructionType;

/**
 处理字符串在指定宽度内可容纳的字符
 
 @param text 需要处理的文本
 @param fontSize 字体格式
 @param instructionType 指令格式
 @param width 指定的宽度
 @return 计算完成后的文字
 */
+ (NSString *)handleText:(NSString *)text withinFontSize:(CCPrintFontSize)fontSize instructionType:(CCPrintInstructionType)instructionType andWidth:(int)width;

/**
 计算条形码宽度

 @param content 条形码内容
 @param barcodeType 条形码编码格式
 @param instructionType 指令格式
 @return 计算完后的宽度
 */
+ (CGFloat)calculateBarcodeWidth:(NSString *)content barcodeType:(CCBarcodeType)barcodeType instructionType:(CCPrintInstructionType)instructionType;

/**
 截取一行字符串

 @param string 要截取的字符串
 @param max 最大个数
 @return 截取后的字符串
 */
+ (NSString *)subStringForOneLine:(NSString *)string max:(int)max;

/**
 截取多行字符串

 @param target 要截取的字符串
 @param maxLine 最大行数
 @param eachLineSize 每行最大个数
 @return 截取后的字符串数组
 */
+ (NSArray *)subStringForMultipLine:(NSString *)target maxLine:(int)maxLine eachLineSize:(int)eachLineSize;

/**
 将CPCL与TSC指令转换为NSData

 @param string 字符串指令
 */
+ (NSData *)dataUsingEncodeingWithString:(NSString *)string;

+ (void)savePeripheral:(CCPeripheral *)peripheral;

+ (NSArray *)getLocalCachePeripherals;
+ (CCPeripheral *)getPeripheralWithUUIDString:(NSString *)uuidString;

@end

/**
 *  Given a scalar or struct value, wraps it in NSValue
 *  Based on EXPObjectify: https://github.com/specta/expecta
 */
static inline id _CCBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGRect)) == 0) {
        CGRect actual = (CGRect)va_arg(v, CGRect);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

#define CCBoxValue(value) _CCBoxValue(@encode(__typeof__((value))), (value))
