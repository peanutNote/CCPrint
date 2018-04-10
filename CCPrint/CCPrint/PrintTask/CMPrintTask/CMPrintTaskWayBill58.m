//
//  CMPrintTaskWayBill58.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/17.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CMPrintTaskWayBill58.h"
#import "CCPrintManager.h"

@implementation CMPrintTaskWayBill58

- (void)printWithField:(CCPrintField *)printField {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    const int xSecend = 200;
    const int xStart = 0;
    if (![printerManager startPrintWithTaskModel:CMPrintTaskModelWayBill58]) {
        return;
    }
    
    [printerManager addText:printField.companyName.content attributeBlock:^(CCPrint *print) {
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
            maker.font.value(CCPrintFontSizeXXX);
        }];
    }];
    [printerManager addText:@"------ 客户存根联 ------" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    
    // 运单号
    [printerManager addText:printField.orderNumber.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.orderNumber.printFontSize);
            maker.bold.value(printField.orderNumber.isBold);
        }];
    }];

    // 发站到站、开单日期
    [printerManager addText:[NSString stringWithFormat:@"%@-%@", printField.srcCity.content, printField.desCity.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.srcCity.printFontSize);
            maker.bold.value(printField.srcCity.isBold);
        }];
    }];
    [printerManager addText:printField.billingDate.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.billingDate.printFontSize);
            maker.bold.value(printField.billingDate.isBold);
        }];
    }];
    
    // 发货人姓名、发货人电话
    [printerManager addText:printField.consignor.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consignor.printFontSize);
            maker.bold.value(printField.consignor.isBold);
        }];
    }];
    [printerManager addText:printField.consignorTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consignor.printFontSize);
            maker.bold.value(printField.consignor.isBold);
        }];
    }];
    
    // 发货人地址
    [printerManager addText:printField.consignorAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consignorAddress.printFontSize);
            maker.bold.value(printField.consignorAddress.isBold);
        }];
    }];
    // 收货人信息
    [printerManager addText:printField.consignee.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consignee.printFontSize);
            maker.bold.value(printField.consignee.isBold);
        }];
    }];
    
    [printerManager addText:printField.consignee.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consignee.printFontSize);
            maker.bold.value(printField.consignee.isBold);
        }];
    }];
    
    // 收货人地址
    [printerManager addText:printField.consigneeAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consigneeAddress.printFontSize);
            maker.bold.value(printField.consigneeAddress.isBold);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    // 货物名称、货物件数
    [printerManager addText:printField.goodsName.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.goodsName.printFontSize);
            maker.bold.value(printField.goodsName.isBold);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"件数:%@", printField.goodsNumber.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.goodsNumber.printFontSize);
            maker.bold.value(printField.goodsNumber.isBold);
        }];
    }];
    // 货物重量、体积
    [printerManager addText:[NSString stringWithFormat:@"重量:%@KG", printField.goodsWeight.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.goodsWeight.printFontSize);
            maker.bold.value(printField.goodsWeight.isBold);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"体积:%@方", printField.goodsVolume.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.goodsVolume.printFontSize);
            maker.bold.value(printField.goodsVolume.isBold);
        }];
    }];
    // 回单、送货方式
    [printerManager addText:printField.receiptNum.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.receiptNum.printFontSize);
            maker.bold.value(printField.receiptNum.isBold);
        }];
    }];
    [printerManager addText:printField.consigneeMode.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.consigneeMode.printFontSize);
            maker.bold.value(printField.consigneeMode.isBold);
        }];
    }];
    // 包装方式、运输方式
    [printerManager addText:printField.packMode.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.packMode.printFontSize);
            maker.bold.value(printField.packMode.isBold);
        }];
    }];
    [printerManager addText:printField.transMode.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.transMode.printFontSize);
            maker.bold.value(printField.transMode.isBold);
        }];
    }];
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    
    // 是否开启省纸模式
    [printerManager addText:@"运费:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.freightPrice.printFontSize);
            maker.bold.value(printField.freightPrice.isBold);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.freightPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    // 送货费
    [printerManager addText:@"送货费:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.deliveryFreight.printFontSize);
            maker.bold.value(printField.deliveryFreight.isBold);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.deliveryFreight.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    // 垫付费
    [printerManager addText:@"垫付费:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.payAdvance.printFontSize);
            maker.bold.value(printField.payAdvance.isBold);
        }];
    }];
    NSString *advancePaid = @"(已垫付)";
    [printerManager addText:[NSString stringWithFormat:@"%@元%@", printField.payAdvance.content, advancePaid] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    [printerManager addText:@"保险费:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.insurancePrice.printFontSize);
            maker.bold.value(printField.insurancePrice.isBold);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.insurancePrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    
    // 其他费
    [printerManager addText:@"其他费:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.hasNewLine.value(NO);
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.miscPrice.printFontSize);
            maker.bold.value(printField.miscPrice.isBold);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"%@元", printField.miscPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xSecend, -1));
        }];
    }];
    // 合计费用
    [printerManager addText:[NSString stringWithFormat:@"合计费用:%@元", printField.totalPrice.content] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.totalPrice.printFontSize);
            maker.bold.value(printField.totalPrice.isBold);
        }];
    }];
    
    [printerManager addText:printField.payBilling.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.payBilling.printFontSize);
            maker.bold.value(printField.payBilling.isBold);
        }];
    }];
    [printerManager addText:printField.payArrival.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.payArrival.printFontSize);
            maker.bold.value(printField.payArrival.isBold);
        }];
    }];
    
    [printerManager addText:printField.collectionOnDelivery.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.collectionOnDelivery.printFontSize);
            maker.bold.value(printField.collectionOnDelivery.isBold);
        }];
    }];
    [printerManager addText:printField.coDeliveryFee.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.coDeliveryFee.printFontSize);
            maker.bold.value(printField.coDeliveryFee.isBold);
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
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.remark.printFontSize);
            maker.bold.value(printField.remark.isBold);
        }];
    }];
    
    NSArray *termSheets = [CCPrintUtilities subStringForMultipLine:printField.termSheet.attachContent maxLine:20 eachLineSize:18];
    for (NSString *termSheet in termSheets) {
        [printerManager addText:termSheet attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
        }];
    }
    [printerManager addText:printField.srcAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.srcAddress.printFontSize);
            maker.bold.value(printField.srcAddress.isBold);
        }];
    }];
    
    [printerManager addText:printField.srcTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.srcTel.printFontSize);
            maker.bold.value(printField.srcTel.isBold);
        }];
    }];
    
    [printerManager addText:printField.desCity.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.desCity.printFontSize);
            maker.bold.value(printField.desCity.isBold);
        }];
    }];
    
    [printerManager addText:printField.desTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.desTel.printFontSize);
            maker.bold.value(printField.desTel.isBold);
        }];
    }];
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    
    [printerManager addText:printField.printOperator.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.printOperator.printFontSize);
            maker.bold.value(printField.printOperator.isBold);
        }];
    }];
    
    [printerManager addText:printField.operatorName.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(printField.operatorName.printFontSize);
            maker.bold.value(printField.operatorName.isBold);
        }];
    }];
    
    [printerManager addText:@"车满满物流协同平台 移动端" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
        }];
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
            maker.font.value(CCPrintFontSizeL);
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.marginY.value(12);
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
