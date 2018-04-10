//
//  CMPrintTaskWayBill80.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/13.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CMPrintTaskWayBill80.h"
#import "CCPrintManager.h"

@implementation CMPrintTaskWayBill80

- (void)printWithField:(CCPrintField *)printField {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    const int xSecend = 288;
    const int xStart = 0;
    // 启动打印
    if (![printerManager startPrintWithTaskModel:CMPrintTaskModelWayBill80]) {
        return;
    }
    /*
    NSDictionary *orgUseStartDepartment = printSetting.orgUseStartDepartment;
    NSString *companyName = kApplicationHelper.companyName;
    if ([printSetting.companyName[@"value"] length]) {
        companyName = printSetting.companyName[@"value"];
    }
    if ([orgUseStartDepartment[@"value"] boolValue]) {
        companyName = orderModel.departmentName;
    }
    // 打印公司名
    [printerManager addText:companyName attributeBlock:^(CCPrint *print) {
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.align.value(CCPrintAlignCenter);
            maker.font.value(CCPrintFontSizeXXX);
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"------ %@ ------", type] attributeBlock:^(CCPrint *print) {
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
    
    NSDictionary *printConfigModelDict = [self cmGetOrderFieldConfigWithDict:printSetting.orderFieldConfig];
    // 运单号
    CMPrintModel *isOrderNo = [printConfigModelDict objectForKey:@"isOrderNo"];
    if (isOrderNo.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"运单号:%@", orderModel.orderNum] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isOrderNo.printFontSize);
                maker.bold.value(isOrderNo.isBold.boolValue);
            }];
        }];
    }
    // 委托单号
    CMPrintModel *isCustomNum = [printConfigModelDict objectForKey:@"isCustomNum"];
    if (isCustomNum.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"委托单号:%@", orderModel.entrustNum] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isCustomNum.printFontSize);
                maker.bold.value(isCustomNum.isBold.boolValue);
            }];
        }];
    }
    // 货号
    CMPrintModel *isGoodsSerialNo = [printConfigModelDict objectForKey:@"isGoodsSerialNo"];
    if (isGoodsSerialNo.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"货号:%@", orderModel.goodsNum] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isGoodsSerialNo.printFontSize);
                maker.bold.value(isGoodsSerialNo.isBold.boolValue);
            }];
        }];
    }
    // 发站到站、开单日期
    CMPrintModel *startDst = [printConfigModelDict objectForKey:@"isStartPointNet"];
    CMPrintModel *isBillingDate = [printConfigModelDict objectForKey:@"isBillingDate"];
    if (startDst.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"%@-%@", orderModel.start, orderModel.dst] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.size.value(CGSizeMake(xSecend - xStart, 24));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(startDst.printFontSize);
                maker.bold.value(startDst.isBold.boolValue);
            }];
        }];
    }
    if (isBillingDate.check.boolValue) {
        NSString *billingDate = @"";
        if (orderModel.billingDate.length > 10) {
            billingDate = [orderModel.billingDate substringToIndex:10];
        }
        [printerManager addText:[NSString stringWithFormat:@"开票日期:%@", billingDate] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isBillingDate.printFontSize);
                maker.bold.value(isBillingDate.isBold.boolValue);
            }];
        }];
    }
    
    // 发货人姓名、发货人电话
    CMPrintModel *isConsignorName = [printConfigModelDict objectForKey:@"isConsignorName"];
    CMPrintModel *isConsignorTel = [printConfigModelDict objectForKey:@"isConsignorTel"];
    if (isConsignorName.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"发货人:%@", orderModel.corName] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsignorName.printFontSize);
                maker.bold.value(isConsignorName.isBold.boolValue);
            }];
        }];
    }
    if (isConsignorTel.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"电话:%@", orderModel.corMobile] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsignorTel.printFontSize);
                maker.bold.value(isConsignorTel.isBold.boolValue);
            }];
        }];
    }
    // 发货人地址
    CMPrintModel *isConsignorAddress = [printConfigModelDict objectForKey:@"isConsignorAddress"];
    if (isConsignorAddress.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"发货地址:%@", orderModel.corAddr] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsignorAddress.printFontSize);
                maker.bold.value(isConsignorAddress.isBold.boolValue);
            }];
        }];
    }
    // 收货人信息
    CMPrintModel *isConsigneeName = [printConfigModelDict objectForKey:@"isConsigneeName"];
    CMPrintModel *isConsigneeTel = [printConfigModelDict objectForKey:@"isConsigneeTel"];
    if (isConsigneeName.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"收货人:%@", orderModel.ceeName] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsigneeName.printFontSize);
                maker.bold.value(isConsigneeName.isBold.boolValue);
            }];
        }];
    }
    if (isConsigneeTel.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"电话:%@", orderModel.ceeMobile] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsigneeTel.printFontSize);
                maker.bold.value(isConsigneeTel.isBold.boolValue);
            }];
        }];
    }
    // 收货人地址
    CMPrintModel *isConsigneeAddress = [printConfigModelDict objectForKey:@"isConsigneeAddress"];
    if (isConsigneeAddress.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"收货地址:%@", orderModel.ceeAddr] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsigneeAddress.printFontSize);
                maker.bold.value(isConsigneeAddress.isBold.boolValue);
            }];
        }];
    }
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    // 货物名称、货物件数
    CMPrintModel *isGoodsName = [printConfigModelDict objectForKey:@"isGoodsName"];
    CMPrintModel *isGoodsNumber = [printConfigModelDict objectForKey:@"isGoodsNumber"];
    if (isGoodsName.check.boolValue) {
        [printerManager addText:orderModel.goodsModel.goodsName attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isGoodsName.printFontSize);
                maker.bold.value(isGoodsName.isBold.boolValue);
            }];
        }];
    }
    if (isGoodsNumber.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"件数:%@", orderModel.goodsModel.goodsNum] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isGoodsNumber.printFontSize);
                maker.bold.value(isGoodsNumber.isBold.boolValue);
            }];
        }];
    }
    // 货物重量、体积
    CMPrintModel *isGoodsWeight = [printConfigModelDict objectForKey:@"isGoodsWeight"];
    CMPrintModel *isGoodsVolume = [printConfigModelDict objectForKey:@"isGoodsVolume"];
    if (isGoodsWeight.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"重量:%@%@", orderModel.goodsModel.goodsWeight, orderModel.weightUnit] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isGoodsWeight.printFontSize);
                maker.bold.value(isGoodsWeight.isBold.boolValue);
            }];
        }];
    }
    if (isGoodsVolume.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"体积:%@%@", orderModel.goodsModel.goodsVolume, orderModel.volumeUnit] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isGoodsVolume.printFontSize);
                maker.bold.value(isGoodsVolume.isBold.boolValue);
            }];
        }];
    }
    // 回单、送货方式
    CMPrintModel *isReceiptNum = [printConfigModelDict objectForKey:@"isReceiptNum"];
    CMPrintModel *isConsigneeMode = [printConfigModelDict objectForKey:@"isConsigneeMode"];
    if (isReceiptNum.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"回单:%@份", orderModel.receiptN] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isReceiptNum.printFontSize);
                maker.bold.value(isReceiptNum.isBold.boolValue);
            }];
        }];
    }
    if (isConsigneeMode.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"送货方式:%@", orderModel.deliveryMode] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isConsigneeMode.printFontSize);
                maker.bold.value(isConsigneeMode.isBold.boolValue);
            }];
        }];
    }
    // 包装方式、运输方式
    CMPrintModel *isPacketMode = [printConfigModelDict objectForKey:@"isPacketMode"];
    CMPrintModel *isTransMode = [printConfigModelDict objectForKey:@"isTransMode"];
    if (isPacketMode.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"包装:%@", orderModel.goodsModel.goodsPkg] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.hasNewLine.value(NO);
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isPacketMode.printFontSize);
                maker.bold.value(isPacketMode.isBold.boolValue);
            }];
        }];
    }
    if (isTransMode.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"运输方式：%@\n", orderModel.transportMode] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xSecend, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isTransMode.printFontSize);
                maker.bold.value(isTransMode.isBold.boolValue);
            }];
        }];
        [printerManager addLineAttributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.size.value(CGSizeMake(-1, 1));
            }];
        }];
    }
    
    // 是否开启省纸模式
    CMPrintModel *isFixedHeightModel = [printConfigModelDict objectForKey:@"isFixedHeight"];
    BOOL isFixedHeight = [isFixedHeightModel.check boolValue];
    // 运费
    if (orderModel.coFreight.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isFreightPrice = [printConfigModelDict objectForKey:@"isFreightPrice"];
        if (isFreightPrice.check.boolValue) {
            [printerManager addText:@"运费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isFreightPrice.printFontSize);
                    maker.bold.value(isFreightPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coFreight] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 送货费
    if (orderModel.dlbfee.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isDeliveryPrice = [printConfigModelDict objectForKey:@"isDeliveryPrice"];
        if (isDeliveryPrice.check.boolValue) {
            [printerManager addText:@"送货费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isDeliveryPrice.printFontSize);
                    maker.bold.value(isDeliveryPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.dlbfee] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 垫付费
    if (orderModel.coPayAdv.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isPayAdvance = [printConfigModelDict objectForKey:@"isPayAdvance"];
        if (isPayAdvance.check.boolValue) {
            [printerManager addText:@"垫付费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayAdvance.printFontSize);
                    maker.bold.value(isPayAdvance.isBold.boolValue);
                }];
            }];
            NSString *advancePaid = @"";
            if ([orderModel.coPayAdvPaid isEqualToString:@"1"]) {
                advancePaid = @"(已垫付)";
            } else if ([orderModel.coPayAdvPaid isEqualToString:@"0"]) {
                advancePaid = @"(未垫付)";
            }
            [printerManager addText:[NSString stringWithFormat:@"%@元%@", orderModel.coPayAdv, advancePaid] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 垫付货款
    if (orderModel.coDeliveryAdv.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isCoDeliveryAdvance = [printConfigModelDict objectForKey:@"isCoDeliveryAdvance"];
        if (isCoDeliveryAdvance.check.boolValue) {
            [printerManager addText:@"垫付货款:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isCoDeliveryAdvance.printFontSize);
                    maker.bold.value(isCoDeliveryAdvance.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coDeliveryAdv] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 声明价值
    if (orderModel.declaredValue.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isGoodsValue = [printConfigModelDict objectForKey:@"isGoodsValue"];
        if (isGoodsValue.check.boolValue) {
            [printerManager addText:@"声明价值:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isGoodsValue.printFontSize);
                    maker.bold.value(isGoodsVolume.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.declaredValue] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 保险费
    if (orderModel.coInsurance.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isInsurancePrice = [printConfigModelDict objectForKey:@"isInsurancePrice"];
        if (isInsurancePrice.check.boolValue) {
            [printerManager addText:@"保险费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isInsurancePrice.printFontSize);
                    maker.bold.value(isInsurancePrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coInsurance] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 提货费
    if (orderModel.coPickup.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetPickGoodsPrice = [printConfigModelDict objectForKey:@"isBudgetPickGoodsPrice"];
        if (isBudgetPickGoodsPrice.check.boolValue) {
            [printerManager addText:@"提货费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetPickGoodsPrice.printFontSize);
                    maker.bold.value(isBudgetPickGoodsPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coPickup] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 装卸费
    if (orderModel.coHandling.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetHandlingPrice = [printConfigModelDict objectForKey:@"isBudgetHandlingPrice"];
        if (isBudgetHandlingPrice.check.boolValue) {
            [printerManager addText:@"装卸费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetHandlingPrice.printFontSize);
                    maker.bold.value(isBudgetHandlingPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coHandling] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 上楼费
    if (orderModel.coUpstair.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetUpstairsPrice = [printConfigModelDict objectForKey:@"isBudgetUpstairsPrice"];
        if (isBudgetUpstairsPrice.check.boolValue) {
            [printerManager addText:@"上楼费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetUpstairsPrice.printFontSize);
                    maker.bold.value(isBudgetUpstairsPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coUpstair] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 包装费
    if (orderModel.coPkg.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetPackagePrice = [printConfigModelDict objectForKey:@"isBudgetPackagePrice"];
        if (isBudgetPackagePrice.check.boolValue) {
            [printerManager addText:@"包装费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetPackagePrice.printFontSize);
                    maker.bold.value(isBudgetPackagePrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coPkg] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 安装费
    if (orderModel.coInstall.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetInstallPrice = [printConfigModelDict objectForKey:@"isBudgetInstallPrice"];
        if (isBudgetInstallPrice.check.boolValue) {
            [printerManager addText:@"安装费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetInstallPrice.printFontSize);
                    maker.bold.value(isBudgetInstallPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coInstall] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 中转费
    if (orderModel.budgetTransPrice.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetTransPrice = [printConfigModelDict objectForKey:@"isBudgetTransPrice"];
        if (isBudgetTransPrice.check.boolValue) {
            [printerManager addText:@"中转费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetTransPrice.printFontSize);
                    maker.bold.value(isBudgetTransPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.budgetTransPrice] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 保管费
    if (orderModel.budgetCustodianPrice.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetCustodianPrice = [printConfigModelDict objectForKey:@"isBudgetCustodianPrice"];
        if (isBudgetCustodianPrice.check.boolValue) {
            [printerManager addText:@"保管费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetCustodianPrice.printFontSize);
                    maker.bold.value(isBudgetCustodianPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.budgetCustodianPrice] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 进仓费
    if (orderModel.budgetWarehousingPrice.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetWarehousingPrice = [printConfigModelDict objectForKey:@"isBudgetWarehousingPrice"];
        if (isBudgetWarehousingPrice.check.boolValue) {
            [printerManager addText:@"进仓费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetWarehousingPrice.printFontSize);
                    maker.bold.value(isBudgetWarehousingPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.budgetWarehousingPrice] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 其他费
    if (orderModel.coInstall.floatValue > 0.001 || !isFixedHeight) {
        CMPrintModel *isBudgetMiscPrice = [printConfigModelDict objectForKey:@"isBudgetMiscPrice"];
        if (isBudgetMiscPrice.check.boolValue) {
            [printerManager addText:@"其他费:" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.hasNewLine.value(NO);
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isBudgetMiscPrice.printFontSize);
                    maker.bold.value(isBudgetMiscPrice.isBold.boolValue);
                }];
            }];
            [printerManager addText:[NSString stringWithFormat:@"%@元", orderModel.coMisc] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xSecend, -1));
                }];
            }];
        }
    }
    // 合计费用
    CMPrintModel *isTotalPrice = [printConfigModelDict objectForKey:@"isTotalPrice"];
    if (isTotalPrice.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"合计费用:%@元", orderModel.totalCost] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isTotalPrice.printFontSize);
                maker.bold.value(isTotalPrice.isBold.boolValue);
            }];
        }];
    }
    
    if (orderModel.payBilling.floatValue > 0.001) {
        CMPrintModel *isPayBilling = [printConfigModelDict objectForKey:@"isPayBilling"];
        if (isPayBilling.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"现付:%@元", orderModel.payBilling] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayBilling.printFontSize);
                    maker.bold.value(isPayBilling.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.payArrival.floatValue > 0.001) {
        CMPrintModel *isPayArrival = [printConfigModelDict objectForKey:@"isPayArrival"];
        if (isPayArrival.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"到付:%ld元", orderModel.payArrival.longValue] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayArrival.printFontSize);
                    maker.bold.value(isPayArrival.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.payOwed.floatValue > 0.001) {
        CMPrintModel *isPayOwed = [printConfigModelDict objectForKey:@"isPayOwed"];
        if (isPayOwed.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"欠付:%@元", orderModel.payOwed] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayOwed.printFontSize);
                    maker.bold.value(isPayOwed.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.payMonthly.floatValue > 0.001) {
        CMPrintModel *isPayMonth = [printConfigModelDict objectForKey:@"isPayMonth"];
        if (isPayMonth.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"月结:%@元", orderModel.payMonthly] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayMonth.printFontSize);
                    maker.bold.value(isPayMonth.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.payReceipt.floatValue > 0.001) {
        CMPrintModel *isPayBack = [printConfigModelDict objectForKey:@"isPayBack"];
        if (isPayBack.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"回付:%@元", orderModel.payReceipt] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayBack.printFontSize);
                    maker.bold.value(isPayBack.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.payCoDelivery.floatValue > 0.001) {
        CMPrintModel *isPayCoDelivery = [printConfigModelDict objectForKey:@"isPayCoDelivery"];
        if (isPayCoDelivery.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"货款扣:%@元", orderModel.payCoDelivery] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isPayCoDelivery.printFontSize);
                    maker.bold.value(isPayCoDelivery.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.payCredit.floatValue > 0.001) {
        CMPrintModel *isArrivalPayByCredit = [printConfigModelDict objectForKey:@"isArrivalPayByCredit"];
        if (isArrivalPayByCredit.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"货到打卡:%@元", orderModel.payCredit] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isArrivalPayByCredit.printFontSize);
                    maker.bold.value(isArrivalPayByCredit.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.coDelivery.floatValue > 0.001) {
        CMPrintModel *isCoDelivery = [printConfigModelDict objectForKey:@"isCoDelivery"];
        if (isCoDelivery.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"代收货款:%@元", orderModel.coDelivery] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isCoDelivery.printFontSize);
                    maker.bold.value(isCoDelivery.isBold.boolValue);
                }];
            }];
        }
    }
    if (orderModel.coDeliveryFee.floatValue > 0.001) {
        CMPrintModel *isCoDeliveryFee = [printConfigModelDict objectForKey:@"isCoDeliveryFee"];
        if (isCoDeliveryFee.check.boolValue) {
            [printerManager addText:[NSString stringWithFormat:@"货款手续费:%@元", orderModel.coDeliveryFee] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
                [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                    maker.font.value(isCoDeliveryFee.printFontSize);
                    maker.bold.value(isCoDeliveryFee.isBold.boolValue);
                }];
            }];
        }
    }
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, -1));
            maker.size.value(CGSizeMake(-1, 1));
        }];
    }];
    
    CMPrintModel *isRemark = [printConfigModelDict objectForKey:@"isRemark"];
    if (isRemark.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"备注:%@", orderModel.remark] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isRemark.printFontSize);
                maker.bold.value(isRemark.isBold.boolValue);
            }];
        }];
    }
    
    if ([self cmCheckTermSheetNeedToPrint:printSetting type:type]) {
        NSArray *termSheets = [CCPrintUtilities subStringForMultipLine:[NSString stringWithFormat:@"运输条款:%@", [self cmGetTermSheet:printSetting]] maxLine:20 eachLineSize:24];
        for (NSString *termSheet in termSheets) {
            [printerManager addText:termSheet attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                }];
            }];
        }
    }
    NSString *srcAddres = orderModel.startAddr;
    NSString *srcPhone = orderModel.startPhone;
    if (([orgUseStartDepartment[@"value"] boolValue])) {
        srcAddres = orderModel.departmentAddr;
        srcPhone = orderModel.departmentPhone;
    }
    CMPrintModel *isSrcAddress = [printConfigModelDict objectForKey:@"isSrcAddress"];
    if (isSrcAddress.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"发站地址:%@", srcAddres] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isSrcAddress.printFontSize);
                maker.bold.value(isSrcAddress.isBold.boolValue);
            }];
        }];
    }
    
    CMPrintModel *isSrcPhone = [printConfigModelDict objectForKey:@"isSrcPhone"];
    if (isSrcPhone.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"联系电话:%@", srcPhone] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isSrcPhone.printFontSize);
                maker.bold.value(isSrcPhone.isBold.boolValue);
            }];
        }];
    }
    
    CMPrintModel *isDstAddress = [printConfigModelDict objectForKey:@"isDstAddress"];
    if (isDstAddress.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"到站地址:%@", orderModel.dstAddr] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isDstAddress.printFontSize);
                maker.bold.value(isDstAddress.isBold.boolValue);
            }];
        }];
    }
    
    CMPrintModel *isDstPhone = [printConfigModelDict objectForKey:@"isDstPhone"];
    if (isDstPhone.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"联系电话:%@", orderModel.dstPhone] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isDstPhone.printFontSize);
                maker.bold.value(isDstPhone.isBold.boolValue);
            }];
        }];
    }
    
    if ([isRemark.check boolValue] || [isSrcAddress.check boolValue]|| [isSrcPhone.check boolValue] || [self cmCheckTermSheetNeedToPrint:printSetting type:type]) {
        [printerManager addLineAttributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
                maker.size.value(CGSizeMake(-1, 1));
            }];
        }];
    }
    
    CMPrintModel *isPrintOperator = [printConfigModelDict objectForKey:@"isPrintOperator"];
    if (isPrintOperator.check.boolValue) {
        NSString *str = [kApplicationHelper.userDefaults objectForKey:@"prof_userName"] ? : @"";
        [printerManager addText:[NSString stringWithFormat:@"打印操作员:%@", str] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isPrintOperator.printFontSize);
                maker.bold.value(isPrintOperator.isBold.boolValue);
            }];
        }];
    }
    
    CMPrintModel *isOperatorSign = [printConfigModelDict objectForKey:@"isOperatorSign"];
    if (isOperatorSign.check.boolValue) {
        [printerManager addText:[NSString stringWithFormat:@"经办人签字:%@", orderModel.mgrName] attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xStart, -1));
            }];
            [print cc_automaticAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(isOperatorSign.printFontSize);
                maker.bold.value(isOperatorSign.isBold.boolValue);
            }];
        }];
    }
    
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
    
    CMPrintModel *barcodeModel = [self cmGetBarcodeConfig:printSetting type:type];
    if (barcodeModel) {
        if ([barcodeModel.barcode boolValue]) {
            [printerManager addBarcode:[NSString stringWithFormat:@"%@", orderModel.queryNum] attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.size.value(CGSizeMake(300, 50));
                }];
            }];
        }
        if ([barcodeModel.qrcode boolValue]) {
            [printerManager addQRcode:orderModel.qrcode ? : @"" attributeBlock:^(CCPrint *print) {
                [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                    maker.position.value(CGPointMake(xStart, -1));
                    maker.size.value(CGSizeMake(200, 200));
                }];
            }];
        }
    }
    [printerManager addPrintSpacing];
    [printerManager endPrint];
     */
}

@end
