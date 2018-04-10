//
//  CCPrintUtilities.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrintUtilities.h"
#import "CCPeripheral.h"

@implementation CCPrintUtilities

+ (CGFloat)calculateBarcodeWidth:(NSString *)content barcodeType:(CCBarcodeType)barcodeType instructionType:(CCPrintInstructionType)instructionType {
    int tmp = 0;
    int len = content ? (int)content.length : 0;
    int width = 0;
    // 计算宽度的时候会虚高
    if (instructionType == CCPrintInstructionESC) {
        
    } else if (instructionType == CCPrintInstructionTSC) {
        switch (barcodeType) {
            case CCBarcode39:
                width = len * 27 + 50;
                break;
            case CCBarcode93:
                width = len * 19 + 70;
                break;
            case CCBarcode128:
                tmp = len * 19 + 176;
                width = tmp < 88 ? 88 : tmp;
                break;
            default:
                break;
        }
    } else if (instructionType == CCPrintInstructionCPCL) {
        switch (barcodeType) {
            case CCBarcode39:
                width = len * 27 + 50;
                break;
            case CCBarcode93:
                width = len * 19 + 70;
                break;
            case CCBarcode128:
                tmp = len * 19 + 176;
                width = tmp < 88 ? 88 : tmp;
                break;
            default:
                break;
        }
    }
    return width;
}

+ (NSString *)handleText:(NSString *)text withinFontSize:(CCPrintFontSize)fontSize instructionType:(CCPrintInstructionType)instructionType andWidth:(int)width {
    int perTextWidth = [self getPerTextWidthFontSize:fontSize instructionType:instructionType];
    int maxTextLength = width / perTextWidth;
    return [self subStringForOneLine:text max:maxTextLength];
}

+ (CGSize)calculateTextSize:(NSString *)text fontSize:(CCPrintFontSize)fontSize instructionType:(CCPrintInstructionType)instructionType; {
    int perTextWidth = [self getPerTextWidthFontSize:fontSize instructionType:instructionType];
    NSInteger standardLength = [self standardLengthWithText:text];
    return CGSizeMake(standardLength * perTextWidth + (standardLength - 1) * 4, perTextWidth);
}

+ (int)getPerTextWidthFontSize:(CCPrintFontSize)fontSize instructionType:(CCPrintInstructionType)instructionType {
    int perTextWidth = 24;
    if (instructionType == CCPrintInstructionESC) {
        
    } else if (instructionType == CCPrintInstructionTSC) {
        if (fontSize == CCPrintFontSizeM) {
            perTextWidth = 24;
        } else if (fontSize == CCPrintFontSizeL) {
            perTextWidth = 24;
        } else if (fontSize == CCPrintFontSizeX) {
            perTextWidth = 24;
        } else if (fontSize == CCPrintFontSizeXX) {
            perTextWidth = 48;
        } else if (fontSize == CCPrintFontSizeXXX) {
            perTextWidth = 48;
        }
    } else if (instructionType == CCPrintInstructionCPCL) {
        if (fontSize == CCPrintFontSizeM) {
            perTextWidth = 16;
        } else if (fontSize == CCPrintFontSizeL) {
            perTextWidth = 24;
        } else if (fontSize == CCPrintFontSizeX) {
            perTextWidth = 32;
        } else if (fontSize == CCPrintFontSizeXX) {
            perTextWidth = 32;
        } else if (fontSize == CCPrintFontSizeXXX) {
            perTextWidth = 48;
        }
    }
    return perTextWidth;
}

+ (NSData*)dataUsingEncodeingWithString:(NSString *)string {
    return [string dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}

+ (NSInteger)standardLengthWithText:(NSString *)string {
    int count = 0;
    NSInteger specialCount = 0;
    NSInteger standardLength = 0;
    while (count < string.length) {
        unichar ch = [string characterAtIndex:count];
        if (ch == 10) { // 换行
            break;
        }
        if ([[self specialCharacterASCIIForPrint] containsObject:@(ch)]) {
            specialCount++;
            if (specialCount == 2) {
                standardLength++;
                specialCount = 0;
            }
        } else {
            standardLength++;
        }
        count++;
    }
    return standardLength;
}

+ (NSString *)subStringForOneLine:(NSString *)string max:(int)max {
    NSInteger realMax = max > string.length ? string.length : max;
    int count = 0;
    int specialCount = 0;
    NSInteger subLength = 0;
    while (count < string.length && subLength < realMax) {
        unichar ch = [string characterAtIndex:count];
        if (ch == 10) {
            break;
        }
        if ([[self specialCharacterASCIIForPrint] containsObject:@(ch)]) {
            specialCount++;
            if (specialCount == 2) {
                realMax++;
                specialCount = 0;
            }
        }
        subLength++;
        count++;
    }
    subLength = subLength > string.length ? string.length : subLength;
    return string ? [string substringToIndex:subLength] : @"";
}

+ (NSArray *)specialCharacterASCIIForPrint {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 32; i <= 63; i++) {
        [tempArray addObject:@(i)];
    }
    for (int i = 91; i <= 127; i++) {
        [tempArray addObject:@(i)];
    }
    return [tempArray copy];
}

+ (NSArray *)subStringForMultipLine:(NSString *)string maxLine:(int)maxLine eachLineSize:(int)eachLineSize {
    if (string.length) {
        NSString *inputString = [string copy];
        NSMutableArray *arrayList = [NSMutableArray array];
        
        for (int i = 0; i < maxLine; i++) {
            NSString *tmp = [self subStringForOneLine:inputString max:eachLineSize];
            [arrayList addObject:tmp];
            inputString = [inputString substringFromIndex:MIN(inputString.length, tmp.length)];
            if (inputString.length == 0) {
                break;
            }
            if ([[inputString substringToIndex:1] isEqualToString:@"\n"]) {
                inputString = [inputString substringFromIndex:1];
            }
        }
        return [arrayList copy];
    } else {
        return @[];
    }
}

+ (CCPeripheral *)getPeripheralWithUUIDString:(NSString *)uuidString {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:kCCPeripheralsPlist];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSDictionary *peripheralDict = [dict objectForKey:uuidString];
    if (peripheralDict) {
        return [[CCPeripheral alloc] initWithDictionary:peripheralDict];
    }
    return nil;
}

+ (NSArray *)getLocalCachePeripherals {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:kCCPeripheralsPlist];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *peripherals = [dict allValues];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in peripherals) {
        CCPeripheral *peripheral = [[CCPeripheral alloc] initWithDictionary:dict];
        [tempArray addObject:peripheral];
    }
    return [tempArray copy];
}

+ (void)savePeripheral:(CCPeripheral *)peripheral {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:kCCPeripheralsPlist];
    NSMutableDictionary *dict = [[NSDictionary dictionaryWithContentsOfFile:filePath] mutableCopy];
    if (dict == nil) {
        dict = [NSMutableDictionary dictionary];
    }
    [dict setObject:@{
                      @"identifier" : peripheral.identifier,
                      @"customModel" : peripheral.customModel,
                      @"rename" : peripheral.rename,
                      @"originName" : peripheral.originName
                      } forKey:peripheral.identifier];
    // 保存配置
    [dict writeToFile:filePath atomically:YES];
}

@end
