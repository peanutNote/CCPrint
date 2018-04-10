//
//  MMPrintTaskNormalLabel.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/18.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "MMPrintTaskNormalLabel.h"
#import "CCPrintManager.h"

@implementation MMPrintTaskNormalLabel

- (void)printWithField:(CCPrintField *)printField {
    const int col_offset = 350;
    const int lineSpacing = 16;
    const int text_padding = 6;
    const int xStart = 11;
    const int yStart = 40;
    const int text_common_height = 8;
    int yCursor = yStart;
    
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    printerManager.layoutType = CCSizeLayoutAbsolute;
    printerManager.layoutSize = CGSizeMake(600, 400);
    [printerManager startPrintWithTaskModel:MMPrintTaskModelNormalLabel];
    [printerManager addText:@"1/5件" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
        }];
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.bold.value(YES);
        }];
    }];
    [printerManager addText:printField.companyName.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
        }];
    }];
    yCursor += text_common_height * 3 + lineSpacing;
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, yCursor));
            maker.size.value(CGSizeMake(print.printConteWidth, 1));
        }];
    }];
    yCursor += lineSpacing;
    [printerManager addText:printField.goodsName.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
            maker.size.value(CGSizeMake(col_offset, 24));
        }];
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.bold.value(NO);
        }];
    }];
    [printerManager addText:printField.consignorTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + col_offset, yCursor));
            maker.size.value(CGSizeMake(print.printConteWidth - col_offset, 24));
        }];
    }];
    yCursor += text_common_height * 3 + text_padding;
    [printerManager addText:printField.orderNumber.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
            maker.size.value(CGSizeMake(col_offset, 24));
        }];
    }];
    [printerManager addText:printField.billingDate.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + col_offset, yCursor));
            maker.size.value(CGSizeMake(print.printConteWidth - col_offset, 24));
        }];
    }];
    yCursor += text_common_height * 3 + text_padding;
    [printerManager addText:[NSString stringWithFormat:@"%@-%@", printField.srcCity.content, printField.desCity.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
            maker.size.value(CGSizeMake(col_offset, 24));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.bold.value(YES);
            maker.font.value(CCPrintFontSizeXX);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@件", printField.goodsNumber.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + col_offset, yCursor));
            maker.size.value(CGSizeMake(print.printConteWidth - col_offset, 24));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.bold.value(YES);
            maker.font.value(CCPrintFontSizeXX);
        }];
    }];
    yCursor += text_common_height * 6 + text_padding;
    [printerManager addText:[NSString stringWithFormat:@"%@电话：%@\n", printField.srcCity.content, printField.srcTel.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
        }];
    }];
    yCursor += text_common_height * 3 + text_padding;
    [printerManager addText:[NSString stringWithFormat:@"%@电话：%@\n", printField.desCity.content, printField.desTel.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
        }];
    }];
    yCursor += text_common_height * 3 + lineSpacing;
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, yCursor));
            maker.size.value(CGSizeMake(print.printConteWidth, 1));
        }];
    }];
    yCursor += lineSpacing;
    [printerManager addText:@"车满满物流协同平台移动端 www.chemanman.com" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yCursor));
        }];
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
        }];
    }];
    yCursor += text_common_height * 3 + lineSpacing;
    [printerManager addBarcode:printField.queryNumber.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(0, yCursor));
            maker.size.value(CGSizeMake(350, 50));
        }];
    }];
    [printerManager addGapSense];
    [printerManager endPrint];
}

@end
