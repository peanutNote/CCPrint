//
//  ESCP_Instruaction.m
//  CMM
//
//  Created by qianye on 2018/1/17.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import "ESCP_Instruaction.h"

@implementation ESCP_Instruaction

#pragma mark - 父类打印任务指令

- (void)cc_printerInitDataBuffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerTextData:(NSString *)text x:(int)x y:(int)y width:(int)width buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerLineX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerBarcode:(NSString *)content x:(int)x y:(int)y barcodeType:(CCBarcodeType)barcodeType width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerQRcode:(NSString *)content x:(int)x y:(int)y eccLevel:(NSString *)eccLevel width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    
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
    
}

#pragma mark - 父类共用指令

- (void)cc_printerPageSize:(CGSize)size buffer:(NSMutableData *)buffer {
    
}

- (void)cc_printerFont:(CCPrintFontSize)fontSize buffer:(NSMutableData *)buffer{
    
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
    [self cc_printerPageSize:CGSizeMake(600, 100) buffer:buffer];
    [self cc_printerTextData:@"textsgsadf" x:0 y:10 width:200 buffer:buffer];
    [self cc_printerEndBuffer:buffer];
    return buffer;
}

@end
