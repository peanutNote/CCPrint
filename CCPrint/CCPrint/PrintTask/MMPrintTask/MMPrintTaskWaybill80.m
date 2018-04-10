//
//  MMPrintTaskWaybill80.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/17.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "MMPrintTaskWaybill80.h"
#import "CCPrintManager.h"
#import "CCPrintUtilities.h"

@implementation MMPrintTaskWaybill80

- (void)printWithField:(CCPrintField *)printField {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    [printerManager startPrintWithTaskModel:MMPrintTaskModelWaybill80];

    const int xSecend = 324;          // 一行中第二个内容位置游标
    const int xStart = 0;             // 左间距
    
    // 打印公司名
    [printerManager addText:printField.companyName.content attributeBlock:^(CCPrint *print) {
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
            maker.font.value(CCPrintFontSizeXXX);
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:@"------ 发货存根联 ------" attributeBlock:^(CCPrint *print) {
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    [printerManager addText:printField.orderNumber.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];

    [printerManager addText:printField.billingDate.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
            maker.size.value(CGSizeMake(250, 24));
        }];
    }];
    // 发货人信息
    [printerManager addText:printField.consignee.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:printField.consigneeTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    [printerManager addText:printField.consigneeAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:printField.consignor.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:printField.consignorTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(200, -1));
        }];
    }];
    [printerManager addText:printField.consignorAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    // 货物信息
    [printerManager addText:printField.goodsName.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:printField.goodsNumber.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            
        }];
    }];
    
    [printerManager addText:printField.goodsWeight.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:printField.goodsValue.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:printField.receiptNum.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:printField.consigneeMode.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];

    // 包装方式、运输方式
    [printerManager addText:printField.packMode.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:printField.transMode.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    // 费用
    [printerManager addText:[NSString stringWithFormat:@"运费："] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.freightPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:[NSString stringWithFormat:@"送货费："] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.deliveryFreight.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:[NSString stringWithFormat:@"垫付费："] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元%@", printField.payAdvance.content, @"(已垫付)"] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:[NSString stringWithFormat:@"保险费："] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.insurancePrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:[NSString stringWithFormat:@"提货费："] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.pickGoodsPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:[NSString stringWithFormat:@"其他费："] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.miscPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:[NSString stringWithFormat:@"合计费用：￥%@元", printField.totalPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    
    NSMutableString *payString = [NSMutableString stringWithCapacity:40];
    [payString appendString:@""];
    [payString appendString:[NSString stringWithFormat:@"现付：%@元 ", printField.payBilling.content]];
    [payString appendString:[NSString stringWithFormat:@"到付：%@元 ", printField.payArrival.content]];
    if (![payString isEqualToString:@""]) {
        NSString *printString = [NSString stringWithFormat:@"(%@)", payString];
        NSArray *printArray = [CCPrintUtilities subStringForMultipLine:printString maxLine:3 eachLineSize:24];
        for (NSString *string in printArray) {
            [printerManager addText:string attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
            }];
        }
    }

    [printerManager addText:printField.collectionOnDelivery.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    
    [printerManager addText:printField.coDeliveryFee.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    [printerManager addText:printField.remark.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    NSArray *termSheets = [CCPrintUtilities subStringForMultipLine:printField.termSheet.attachContent maxLine:20 eachLineSize:24];
    for (NSString *term in termSheets) {
        [printerManager addText:term attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
        }];
    }
    [printerManager addText:[NSString stringWithFormat:@"%@地址：%@", printField.srcCity.content, printField.srcAddress.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"联系电话：%@", printField.srcTel.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@地址：%@", printField.desCity.content, printField.desAddress.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"联系电话：%@", printField.desTel.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"打印操作员：%@", @"千叶"] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"经办人签字：%@", printField.operatorName.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
    }];
    [printerManager addText:@"车满满物流协同平台移动端 www.chemanman.com" attributeBlock:^(CCPrint *print) {
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
        }];
    }];
    [printerManager addBarcode:printField.queryNumber.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(300, 50));
        }];
    }];
    [printerManager addQRcode:printField.qRCode.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(200, 200));
        }];
    }];
    [printerManager addPrintSpacing];
    [printerManager endPrint];
}


@end
