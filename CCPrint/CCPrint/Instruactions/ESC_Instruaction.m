//
//  ESC_Instruaction.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "ESC_Instruaction.h"

@implementation ESC_Instruaction

#pragma mark - Private Method

- (void)cc_ESCInitBuffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x40};
    [buffer appendBytes:bytes length:2];
}

- (void)cc_ESCnewLineBuffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x0A};
    [buffer appendBytes:bytes length:1];
}

- (void)cc_ESCBold:(BOOL)enabled buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x45,enabled ? 0x01 : 0x00};
    [buffer appendBytes:bytes length:3];
}

- (void)cc_ESClineSpace:(Byte)lineSpace buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x33,lineSpace};
    [buffer appendBytes:bytes length:3];
}

- (void)cc_ESCRightMargin:(Byte)rightMargin buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x20,rightMargin};
    [buffer appendBytes:bytes length:3];
}

- (void)cc_ESCLeftMargin:(Byte)leftMargin buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x6C,leftMargin};
    [buffer appendBytes:bytes length:3];
}

- (void)cc_ESCAbsolutePostionWithL:(Byte)l h:(Byte)h buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x24,l,h};
    [buffer appendBytes:bytes length:4];
}

/**
 *  选择字符字体。
 *
 *  @param fontType 0x00 选择24点阵字库;0x01 选择16点阵字库;0x02 选择32点阵字库
 *
 *  @return 指令数据
 */
- (void)cc_ESCFontType:(Byte)fontType buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x4D,fontType};
    [buffer appendBytes:bytes length:3];
}
/**
 *  用位0~3位选择字符高度,用位4~7位选择字符宽度(也就是0xHW，H高度，W表示宽)
 *
 *  @param fontSize 0≤n≤255
 *
 *  @return 指令数据
 */
- (void)cc_ESCFontSize:(Byte)fontSize buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1D,0x21,fontSize};
    [buffer appendBytes:bytes length:3];
}
/**
 *  将一行数据按照 n 指定的位置对齐
 *
 *  @param alignType 0x00 左对齐; 0x01 居中;0x02 右对齐
 *
 *  @return 指令数据
 */
- (void)cc_ESCAlignType:(Byte)alignType buffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1B,0x61,alignType};
    [buffer appendBytes:bytes length:3];
}

- (void)cc_ESCcutPaperBuffer:(NSMutableData *)buffer {
    Byte bytes[] = {0x1D,0x56,0x42,0x20};
    [buffer appendBytes:bytes length:3];
}

#pragma mark - 父类打印任务指令

- (void)cc_printerInitDataBuffer:(NSMutableData *)buffer {
    [self cc_ESCInitBuffer:buffer];
}

- (void)cc_printerTextData:(NSString *)text x:(int)x y:(int)y width:(int)width buffer:(NSMutableData *)buffer {
    [buffer appendData:[text dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
    [self cc_ESCnewLineBuffer:buffer];
}

- (void)cc_printerLineX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerBarcode:(NSString *)content x:(int)x y:(int)y barcodeType:(CCBarcodeType)barcodeType width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    Byte bytes_wn[] = {0x1D, 0x77, 0x02};  // 条码宽度
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_wn length:3]];
    Byte bytes_hn[] = {0x1D, 0x68, height};  // 条码高度
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_hn length:3]];
    Byte bytes_fn[] = {0x1D, 0x66, 0x00};  // 条码字体
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_fn length:3]];
    Byte bytes_hhn[] = {0x1D, 0x48, 0x00};  // 可识读字符的打印位置
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_hhn length:3]];
    NSData *stringData = [content dataUsingEncoding:NSUTF8StringEncoding];
    Byte bytes_kmn[] = {0x1D, 0x6B, 0x49, stringData.length};  // 打印一维条码code128
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_kmn length:4]];
    [buffer appendData:stringData];
    [self cc_ESCnewLineBuffer:buffer];
}

- (void)cc_printerQRcode:(NSString *)content x:(int)x y:(int)y eccLevel:(NSString *)eccLevel width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    Byte bytes_qrcode_type[] = {0x1D, 0x5A, 0x02};    //  二维码类型
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_qrcode_type length:3]];
    
    Byte bytes_qrcode_width[] = {0x1D, 0x77, 0x06};    //  宽度
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_qrcode_width length:3]];
    
    NSData *stringData = [content dataUsingEncoding:NSUTF8StringEncoding];
    Byte bytes_kmn[] = {0x1B, 0x5A, 0x00, 0x02, 0x00, (stringData.length & 0xff), ((stringData.length & 0xff00) >> 8)};  // 打印二维条码
    [buffer appendData:[[NSData alloc] initWithBytes:bytes_kmn length:7]];
    [buffer appendData:stringData];
}

- (void)cc_printerBitmap:(NSData *)imageData x:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerCutWithBuffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerGapSenseWithBuffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerSpacingWithBuffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerEndBuffer:(NSMutableData *)buffer {
    [self cc_ESCnewLineBuffer:buffer];
}

#pragma mark - 父类共用指令

- (void)cc_printerPageSize:(CGSize)size buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerFont:(CCPrintFontSize)fontSize buffer:(NSMutableData *)buffer {
    
};

- (void)cc_printerAlign:(CCPrintAlignType)alignType buffer:(NSMutableData *)buffer {
    
};

- (void)cc_printerBlod:(BOOL)isBlod buffer:(NSMutableData *)buffer {
    
};

- (void)cc_printerVertical:(BOOL)isVertical buffer:(NSMutableData *)buffer {
    
}

- (NSData *)printTest {
    NSMutableData *buffer = NSMutableData.new;
    [self cc_printerInitDataBuffer:buffer];
    [self cc_printerPageSize:CGSizeMake(500, 300) buffer:buffer];
    [self cc_printerInitDataBuffer:buffer];
    [self cc_printerFont:CCPrintFontSizeL buffer:buffer];
    [self cc_printerTextData:@"textsgsadf" x:0 y:10 width:200 buffer:buffer];
    [self cc_printerTextData:@"tsgsadgdsg" x:0 y:80 width:200 buffer:buffer];
    [self cc_printerEndBuffer:buffer];
    return buffer;
}

@end
