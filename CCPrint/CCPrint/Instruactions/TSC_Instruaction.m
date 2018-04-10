//
//  TSC_Instruaction.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "TSC_Instruaction.h"
#import "CCPrintUtilities.h"
#import "Base_Instruaction+Extra.h"

@interface TSC_Instruaction ()

@property (nonatomic) CCPrintFontSize fontSize;

@property (nonatomic) CCPrintAlignType alignType;

@property (nonatomic) BOOL isBlod;

@property (nonatomic) int rotation;

@end

@implementation TSC_Instruaction

#pragma mark - Private Method

- (void)cc_TSCInitBuffer:(NSMutableData *)buffer {
    NSString *instruaction = @"INITIALPRINTER\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCGapM:(int)m n:(int)n buffer:(NSMutableData *)buffer {
    NSString *instraction = [NSString stringWithFormat:@"GAP %d dot, %d dot\n", m, n];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instraction]];
}

- (void)cc_TSCDirection:(int)n buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"DIRECTION %d\n", n];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCText:(NSString *)text x:(int)x y:(int)y font:(NSString *)font rotation:(int)rotation xMul:(int)xMul yMul:(int)yMul buffer:(NSMutableData *)buffer {
    NSString *instraction = [NSString stringWithFormat:@"TEXT %d,%d,\"%@\",%d,%d,%d,\"%@\"\n", x, y, font, rotation, xMul, yMul, text];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instraction]];
}

- (void)cc_TSCSpeed:(float)n buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"SPEED %f\n", n];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCDensity:(int)n buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"DENSITY %d\n", n];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCEndNum:(int)num copy:(int)copy buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"PRINT %d,%d\n", num, copy];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCCLSBuffer:(NSMutableData *)buffer {
    NSString *instruaction = @"CLS\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCBOXXStart:(int)xStart yStart:(int)yStart xEnd:(int)xEnd yEnd:(int)yEnd height:(int)height buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"BOX %d,%d,%d,%d,%d\n", xStart, yStart, xEnd, yEnd, height];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
};

- (void)cc_TSCBarX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"BAR %d,%d,%d,%d\n", x, y, width, height];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCEopBuffer:(NSMutableData *)buffer {
    NSString *instruaction = @"EOP\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCReferenceX:(int)x y:(int)y buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"REFERENCE %d,%d\n", x, y];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCBarcode:(NSString *)content
                        x:(int)x
                        y:(int)y
              barcodeType:(NSString *)barcodeType
                   height:(int)height
                    human:(int)human
                 rotation:(int)rotation
                   narrow:(int)narrow
                     wide:(int)wide
                   buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"BARCODE %d,%d,\"%@\",%d,%d,%d,%d,%d,\"%@\"\n", x, y, barcodeType, height, human, rotation, narrow, wide, content];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCQrcode:(NSString *)content
                   x:(int)x
                   y:(int)y
            eccLevel:(NSString *)eccLevel
           cellWidth:(int)cellWidth
                mode:(NSString *)mode
            rotation:(int)rotation
               model:(NSString *)model
                mask:(NSString *)mask
              buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"QRCODE %d,%d,%@,%d,%@,%d,%@,%@,\"%@\"\n", x, y, eccLevel, cellWidth, mode, rotation, model, mask, content];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCBitmap:(NSData *)imageData x:(int)x y:(int)y width:(int)width height:(int)height mode:(int)mode buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"BITMAP %d,%d,%d,%d,%d,%@\n", x, y, width, height, mode, imageData];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCCutWithBuffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"CUT\n"];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCCodePage:(int)codePage buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"CODEPAGE %d\n", codePage];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCShift:(int)y buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"SHIFT %d\n", y];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_TSCSelfTestWithBuffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"SELFTEST\n"];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

#pragma mark - 父类打印任务指令

- (void)cc_printerInitDataBuffer:(NSMutableData *)buffer {
    [self cc_TSCInitBuffer:buffer];
    [self cc_TSCCLSBuffer:buffer];
    [self cc_TSCDirection:0 buffer:buffer];
    [self cc_TSCReferenceX:0 y:0 buffer:buffer];
    [self cc_TSCGapM:2 n:0 buffer:buffer];
    [self cc_TSCShift:0 buffer:buffer];
    [self cc_TSCSpeed:4.0 buffer:buffer];
    [self cc_TSCDensity:3 buffer:buffer];
    [self cc_TSCCodePage:437 buffer:buffer];
}

- (void)cc_printerTextData:(NSString *)text x:(int)x y:(int)y width:(int)width buffer:(NSMutableData *)buffer {
    int handelWidth = width == 0 ? self.printConteWidth : width;
    NSString *handleText = [CCPrintUtilities handleText:text withinFontSize:_fontSize instructionType:CCPrintInstructionTSC andWidth:handelWidth];
    
    int scalXY = 1;
    if (_fontSize == CCPrintFontSizeXXX || _fontSize == CCPrintFontSizeXX) {
        scalXY = 2;
    }
    int offsetX = x;
    if (_alignType == CCPrintAlignCenter) {
        offsetX = MAX((self.printConteWidth - [CCPrintUtilities calculateTextSize:handleText fontSize:_fontSize instructionType:CCPrintInstructionTSC].width) / 2, 0);
    }
    [self cc_TSCText:handleText x:offsetX y:y font:@"TSS24.BF2" rotation:_rotation xMul:scalXY yMul:scalXY buffer:buffer];
}

- (void)cc_printerLineX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    if (_rotation == 0 && width == -1) {
        width = self.printConteWidth - 8 * 8;
    }
    [self cc_TSCBarX:x y:y width:width height:height buffer:buffer];
}

- (void)cc_printerBarcode:(NSString *)content x:(int)x y:(int)y barcodeType:(CCBarcodeType)barcodeType width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    NSString *barcode = @"93";
    if (barcodeType == CCBarcode93) {
        barcode = @"93";
    }
    int offsetX = x;
    if (_rotation == 90) {
        offsetX = x + height;
    } else {
        if (_alignType == CCPrintAlignCenter) {
            offsetX = MAX((self.printConteWidth - [CCPrintUtilities calculateBarcodeWidth:content barcodeType:barcodeType instructionType:CCPrintInstructionTSC]) / 2, 0);
        }
    }
    [self cc_TSCBarcode:content x:offsetX y:y barcodeType:barcode height:height human:0 rotation:_rotation narrow:2 wide:2 buffer:buffer];
}

- (void)cc_printerQRcode:(NSString *)content x:(int)x y:(int)y eccLevel:(NSString *)eccLevel width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    int offsetX = x;
    if (_alignType == CCPrintAlignCenter) {
        offsetX = MAX((self.printConteWidth - width) / 2, 0);
    }
    [self cc_TSCQrcode:content x:offsetX y:y eccLevel:eccLevel cellWidth:4 mode:@"A" rotation:0 model:@"M1" mask:@"S7" buffer:buffer];
}

- (void)cc_printerBitmap:(NSData *)imageData x:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    [self cc_TSCBitmap:imageData x:x y:y width:width height:height mode:1 buffer:buffer];
}

- (void)cc_printerCutWithBuffer:(NSMutableData *)buffer {
    [self cc_TSCCutWithBuffer:buffer];
}

- (void)cc_printerGapSenseWithBuffer:(NSMutableData *)buffer {
    NSLog(@"TSC暂不支持自动走纸");
}

- (void)cc_printerSpacingWithBuffer:(NSMutableData *)buffer {
    NSLog(@"TSC暂不支持换行指令");
}

- (void)cc_printerEndBuffer:(NSMutableData *)buffer {
    [self cc_TSCEndNum:1 copy:1 buffer:buffer];
}

#pragma mark - 父类共用指令

- (void)cc_printerPageSize:(CGSize)size buffer:(NSMutableData *)buffer {
    NSString *instraction = [NSString stringWithFormat:@"SIZE %f mm, %f mm\n", size.width / 8, size.height / 8];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instraction]];
}

- (void)cc_printerFont:(CCPrintFontSize)fontSize buffer:(NSMutableData *)buffer{
    _fontSize = fontSize;
};

- (void)cc_printerAlign:(CCPrintAlignType)alignType buffer:(NSMutableData *)buffer {
    _alignType = alignType;
};

- (void)cc_printerBlod:(BOOL)isBlod buffer:(NSMutableData *)buffer {
    // 由于打印浓度全局设置一次即生效，TSC暂时去掉加粗效果
//    [self cc_TSCDensity:isBlod ? 15 : 0 buffer:buffer];
    NSLog(@"TSC暂不支持加粗");
};

- (void)cc_printerVertical:(BOOL)isVertical buffer:(NSMutableData *)buffer {
    _rotation = isVertical ? 90 : 0;
}

- (NSData *)printTest {
    NSMutableData *buffer = NSMutableData.new;
    [self cc_printerInitDataBuffer:buffer];
    [self cc_printerPageSize:CGSizeMake(600, 100) buffer:buffer];
    [self cc_printerTextData:@"textsgsadf" x:0 y:10 width:200 buffer:buffer];
    [self cc_printerEndBuffer:buffer];
    return buffer;
}

@end
