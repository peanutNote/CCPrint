//
//  Base_Instruaction.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "Base_Instruaction.h"
#import "Base_Instruaction+Extra.h"

@implementation Base_Instruaction

- (instancetype)init {
    NSAssert(![self isMemberOfClass:[Base_Instruaction class]], @"该类是一个抽象类，不能直接实例化");
    return [super init];
}

#pragma mark - 打印任务类型

- (void)cc_printerInitDataBuffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerTextData:(NSString *)text
                         x:(int)x
                         y:(int)y
                     width:(int)width
                    buffer:(NSMutableData *)buffer {
    CCInstruactionNotSupport();
};
- (void)cc_printerLineX:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerEndBuffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerBarcode:(NSString *)content x:(int)x y:(int)y barcodeType:(CCBarcodeType)barcodeType width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    CCInstruactionNotSupport();
}
- (void)cc_printerQRcode:(NSString *)content x:(int)x y:(int)y eccLevel:(NSString *)eccLevel width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    CCInstruactionNotSupport();
}
- (void)cc_printerBitmap:(NSData *)imageData x:(int)x y:(int)y width:(int)width height:(int)height buffer:(NSMutableData *)buffer {
    CCInstruactionNotSupport();
}
- (void)cc_printerCutWithBuffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };

- (void)cc_printerGapSenseWithBuffer:(NSMutableArray *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerSpacingWithBuffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };

#pragma mark - 公用指令
- (void)cc_printerPageSize:(CGSize)size buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerFont:(CCPrintFontSize)fontSize buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerMarginY:(int)marginY buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerAlign:(CCPrintAlignType)alignType buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerBlod:(BOOL)isBlod buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_printerVertical:(BOOL)isVertical buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (NSData *)printTest { CCInstruactionNotSupport(); };

#pragma mark - TSC特有指令

- (void)cc_TSCGapM:(int)m n:(int)n buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_TSCSpeed:(float)n buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_TSCDensity:(int)n buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };
- (void)cc_TSCDirection:(int)n buffer:(NSMutableData *)buffer { CCInstruactionNotSupport(); };

@end
