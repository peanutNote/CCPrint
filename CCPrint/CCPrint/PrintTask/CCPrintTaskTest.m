//
//  CCPrintTaskTest.m
//  CMM
//
//  Created by qianye on 2017/10/12.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrintTaskTest.h"
#import "CCPrintManager.h"

@implementation CCPrintTaskTest {
    CCPeripheral *_appointedPeripheral;
}

- (void)printWithTestModel:(CCPrintTestModelType)testModel appointedPeripheral:(CCPeripheral *)appointedPeripheral {
    _appointedPeripheral = appointedPeripheral;
    switch (testModel) {
        case CCPrintTestModelOne:
            [self printTestModelOne];
            break;
        case CCPrintTestModelTwo:
            [self printTestModelTwo];
            break;
        case CCPrintTestModelThree:
            [self printTestModelThree];
            break;
        case CCPrintTestModelFour:
            [self printTestModelFour];
            break;
        default:
            break;
    }
}

- (void)printTestModelOne {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    [printerManager setInstructionType:CCPrintInstructionESC];
    [printerManager setPeripheral:_appointedPeripheral];
    [printerManager startPrintWithTaskModel:CCPrintTaskModelTest];
    [printerManager addText:@"──────────" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
        }];
    }];
    [printerManager addText:@"车满满让物流更高效" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
        }];
    }];
    [printerManager addText:@"----------" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
        }];
    }];
    [printerManager addBarcode:@"1234567890" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
            maker.size.value(CGSizeMake(200, 50));
        }];
    }];
    [printerManager addPrintSpacing];
    [printerManager endPrint];
}

- (void)printTestModelTwo {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    [printerManager setInstructionType:CCPrintInstructionESC];
    [printerManager setPeripheral:_appointedPeripheral];
    [printerManager startPrintWithTaskModel:CCPrintTaskModelTest];
    [printerManager addText:@"──────────" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
        }];
    }];
    [printerManager addText:@"车满满让物流更高效" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
        }];
    }];
    [printerManager addText:@"----------" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
        }];
    }];
    [printerManager addBarcode:@"1234567890" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
            maker.size.value(CGSizeMake(200, 50));
        }];
    }];
    [printerManager addQRcode:@"http://yundan.chemanman.com" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, -1));
            maker.size.value(CGSizeMake(200, 200));
        }];
    }];
    [printerManager addPrintSpacing];
    [printerManager endPrint];
}

- (void)printTestModelThree {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    printerManager.layoutType = CCSizeLayoutAbsolute;
    printerManager.layoutSize = CGSizeMake(600, 400);
    [printerManager setInstructionType:CCPrintInstructionCPCL];
    [printerManager setPeripheral:_appointedPeripheral];
    [printerManager startPrintWithTaskModel:CCPrintTaskModelTest];
    
    const int xStart = 10;
    const int xEnd = 560;
    const int yStart = 10;
    const int yEnd = 390;
    const int splitArea = 80;
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart));
            maker.size.value(CGSizeMake(xEnd - xStart, 1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart + splitArea));
            maker.size.value(CGSizeMake(xEnd - xStart - splitArea, 1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yEnd));
            maker.size.value(CGSizeMake(xEnd - xStart, 1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - splitArea, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + splitArea, yStart + splitArea));
            maker.size.value(CGSizeMake(1, yEnd - yStart - splitArea));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addText:@"车满满让物流更高效" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(15, 35));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(CCPrintFontSizeXX);
            maker.bold.value(YES);
        }];
    }];
    [printerManager addText:@"车满满测试" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(55, 135));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addBarcode:@"1234567890" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(485, 150));
            maker.size.value(CGSizeMake(200, 50));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addBarcode:@"1234567890" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(100, 100));
            maker.size.value(CGSizeMake(200, 50));
        }];
    }];
    [printerManager addQRcode:@"http://yundan.chemanman.com" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(100, 160));
            maker.size.value(CGSizeMake(200, 200));
        }];
    }];

    [printerManager addPrintSpacing];
    [printerManager endPrint];
}

- (void)printTestModelFour {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    [printerManager setInstructionType:CCPrintInstructionTSC];
    [printerManager setPeripheral:_appointedPeripheral];
    [printerManager startPrintWithTaskModel:CCPrintTaskModelTest];
    
    const int xStart = 10;
    const int xEnd = 560;
    const int yStart = 10;
    const int yEnd = 390;
    const int splitArea = 80;
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart));
            maker.size.value(CGSizeMake(xEnd - xStart, 1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart + splitArea));
            maker.size.value(CGSizeMake(xEnd - xStart - splitArea, 1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yEnd));
            maker.size.value(CGSizeMake(xEnd - xStart, 1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - splitArea, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + splitArea, yStart + splitArea));
            maker.size.value(CGSizeMake(1, yEnd - yStart - splitArea));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addText:@"车满满让物流更高效" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(15, 35));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(CCPrintFontSizeXX);
            maker.bold.value(YES);
        }];
    }];
    [printerManager addText:@"车满满测试" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(55, 135));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addBarcode:@"1234567890" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(485, 150));
            maker.size.value(CGSizeMake(200, 50));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.vertical.value(YES);
        }];
    }];
    [printerManager addBarcode:@"1234567890" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(100, 100));
            maker.size.value(CGSizeMake(200, 50));
        }];
    }];
    [printerManager addQRcode:@"http://yundan.chemanman.com" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(100, 160));
            maker.size.value(CGSizeMake(200, 200));
        }];
    }];
    
    [printerManager addPrintSpacing];
    [printerManager endPrint];
}

@end
