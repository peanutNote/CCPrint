//
//  CPCL_Instruaction.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CPCL_Instruaction.h"
#import "CCPrintUtilities.h"
#import "Base_Instruaction+Extra.h"

@interface CPCL_Instruaction ()

@property (nonatomic) BOOL isVertical;
@property (nonatomic) CCPrintFontSize fontSize;
@property (nonatomic) CCPrintAlignType alignType;

@end

@implementation CPCL_Instruaction

#pragma mark - Private Method

- (void)cc_CPCLInitBuffer:(NSMutableData *)buffer {
    [self cc_CPCLContrast:3 buffer:buffer];
    [self cc_CPCLSpeed:5 buffer:buffer];
    // 汉印打印机的奇特bug
    [self cc_printerTextData:@"" x:0 y:0 width:0 buffer:buffer];
    [self cc_printerTextData:@"" x:0 y:0 width:0 buffer:buffer];
    [self cc_printerTextData:@"" x:0 y:0 width:0 buffer:buffer];
}

- (void)cc_CPCLText:(NSString *)text isVertical:(BOOL)isVertical font:(int)font size:(int)size x:(int)x y:(int)y buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"%@ %d %d %d %d %@\r\n", isVertical ? @"T270" : @"T", font, size, x, y, text];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLLineX0:(int)x0 y0:(int)y0 x1:(int)x1 y1:(int)y1 width:(int)width buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"LINE %d %d %d %d %d\r\n", x0, y0, x1, y1, width];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLBOXX0:(int)x0 y0:(int)y0 x1:(int)x1 y1:(int)y1 width:(int)width buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"BOX %d %d %d %d %d\r\n", x0, y0, x1, y1, width];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLSpeed:(int)level buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"SPEED %d\r\n", level];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLContrast:(int)level buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"CONSTRAST %d\r\n", level];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLBold:(int)apply buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"SETBOLD %d\r\n", apply];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLMAG:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"SETMAG %d %d\r\n", width, height];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLBarCode:(BOOL)isVertical height:(int)height x:(int)x y:(int)y content:(NSString *)content buffer:(NSMutableData *)buffer {
    NSString *instruaction = [NSString stringWithFormat:@"%@ 128 1 1 %d %d %d %@\r\n", isVertical ? @"VB" : @"B", height, x, y, content];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLQRCode:(BOOL)isVertical x:(int)x y:(int)y content:(NSString *)content buffer:(NSMutableData *)buffer {
    NSString *instruaction1 = [NSString stringWithFormat:@"%@ QR %d %d M 2 U 4\r\n", isVertical ? @"VB" : @"B", x , y];
    NSString *instruaction2 = [NSString stringWithFormat:@"MA,%@\r\n", content];
    NSString *instruaction3 = @"ENDQR\r\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction1]];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction2]];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction3]];
}

- (void)cc_CPCLFormBuffer:(NSMutableData *)buffer {
    NSString *instruaction = @"FORM\r\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLGapSenseBuffer:(NSMutableData *)buffer {
    NSString *instruaction = @"GAP-SENSE\r\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

- (void)cc_CPCLEndBuffer:(NSMutableData *)buffer {
    NSString *instruaction = @"PRINT\r\n";
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruaction]];
}

#pragma mark - 父类打印任务指令

- (void)cc_printerInitDataBuffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerTextData:(NSString *)text x:(int)x y:(int)y width:(int)width buffer:(NSMutableData *)buffer {
    int handelWidth = width <= 0 ? self.printConteWidth : width;
    NSString *handleText = [CCPrintUtilities handleText:text withinFontSize:_fontSize instructionType:CCPrintInstructionCPCL andWidth:handelWidth];
    int offsetX = x;
    if (_alignType == CCPrintAlignCenter) {
        offsetX = MAX((self.printConteWidth - [CCPrintUtilities calculateTextSize:handleText fontSize:_fontSize instructionType:CCPrintInstructionTSC].width) / 2, 0);
    }
    
    // 确定字体大小
    int font = 55;
    int size = 0;
    int scal = 1;
    switch (_fontSize) {
        case CCPrintFontSizeM:
            font = 55;
            size = 0;
            break;
        case CCPrintFontSizeL:
            font = 56;
            size = 0;
            break;
        case CCPrintFontSizeX:
            font = 55;
            size = 0;
            scal = 2;
            break;
        case CCPrintFontSizeXX:
            font = 55;
            size = 0;
            scal = 2;
            break;
        case CCPrintFontSizeXXX:
            font = 56;
            size = 0;
            scal = 2;
            break;
        default:
            break;
    }
    if (scal > 0) {
        [self cc_CPCLMAG:scal height:scal buffer:buffer];
    }
    [self cc_CPCLText:handleText isVertical:_isVertical font:font size:size x:offsetX y:y buffer:buffer];
    if (scal > 0) {
        [self cc_CPCLMAG:0 height:0 buffer:buffer];
    }
}

- (void)cc_printerLineX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    int x0 = x;
    int y0 = y;
    int x1 = 0;
    int y1 = 0;
    if (_isVertical == NO) {
        if (width == -1) {
            x1 = x + self.printConteWidth - 8 * 8;
        } else {
            x1 = x + width;
        }
        y1 = y;
    } else {
        x1 = x;
        y1 = y + height;
    }
    [self cc_CPCLLineX0:x0 y0:y0 x1:x1 y1:y1 width:1 buffer:buffer];
}

- (void)cc_printerBarcode:(NSString *)content x:(int)x y:(int)y barcodeType:(CCBarcodeType)barcodeType width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    int offsetX = x;
    int offsetY = y;
    if (_isVertical == YES) {
        offsetY = y + width;
    } else {
        if (_alignType == CCPrintAlignCenter) {
            offsetX = MAX((self.printConteWidth - [CCPrintUtilities calculateBarcodeWidth:content barcodeType:barcodeType instructionType:CCPrintInstructionCPCL]) / 2, 0);
        }
    }
    [self cc_CPCLBarCode:_isVertical height:height x:offsetX y:offsetY content:content buffer:buffer];
}

- (void)cc_printerQRcode:(NSString *)content x:(int)x y:(int)y eccLevel:(NSString *)eccLevel width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    int offsetX = x;
    if (_alignType == CCPrintAlignCenter) {
        offsetX = MAX((self.printConteWidth - width) / 2, 0);
    }
    [self cc_CPCLQRCode:NO x:offsetX y:y content:content buffer:buffer];
}

- (void)cc_printerBitmap:(NSData *)imageData x:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    NSLog(@"CPCL暂不支持位图打印");
}

- (void)cc_printerCutWithBuffer:(NSMutableData *)buffer {
    NSLog(@"CPCL暂不支持切纸指令");
}

- (void)cc_printerGapSenseWithBuffer:(NSMutableData *)buffer {
    [self cc_CPCLGapSenseBuffer:buffer];
    [self cc_CPCLFormBuffer:buffer];
}

- (void)cc_printerSpacingWithBuffer:(NSMutableData *)buffer {
    NSLog(@"CPCL暂不支持换行指令");
}

- (void)cc_printerEndBuffer:(NSMutableData *)buffer {
    [self cc_CPCLEndBuffer:buffer];
}

#pragma mark - 父类共用指令

- (void)cc_printerPageSize:(CGSize)size buffer:(NSMutableData *)buffer {
    NSString *instruactionHeight = [NSString stringWithFormat:@"! 0 200 200 %.f 1\r\n", size.height];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruactionHeight]];
    NSString *instruactionWidth = [NSString stringWithFormat:@"PAGE-WIDTH %.f\r\n", size.width];
    [buffer appendData:[CCPrintUtilities dataUsingEncodeingWithString:instruactionWidth]];
    [self cc_CPCLInitBuffer:buffer];
}

- (void)cc_printerFont:(CCPrintFontSize)fontSize buffer:(NSMutableData *)buffer {
    _fontSize = fontSize;
};

- (void)cc_printerAlign:(CCPrintAlignType)alignType buffer:(NSMutableData *)buffer {
    _alignType = alignType;
};

- (void)cc_printerBlod:(BOOL)isBlod buffer:(NSMutableData *)buffer {
    [self cc_CPCLBold:isBlod buffer:buffer];
};

- (void)cc_printerVertical:(BOOL)isVertical buffer:(NSMutableData *)buffer {
    _isVertical = isVertical;
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
