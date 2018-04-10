//
//  CMPrintTaskWayBill80Hor.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/14.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CMPrintTaskWayBill80Hor.h"
#import "CCPrintManager.h"

@implementation CMPrintTaskWayBill80Hor

- (void)printWithField:(CCPrintField *)printField {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    printerManager.layoutType = CCSizeLayoutAbsolute;
    printerManager.layoutSize = CGSizeMake(600, 1500);
    if (![printerManager startPrintWithTaskModel:CMPrintTaskModelWayBill80Hor]) {
        return;
    }
    int text_common_height = 8;             // 字高公倍数
    int text_padding = 6;                   // 行间距
    int xStart = 40;                        // 表格x起点
    int xEnd = 456;                         // 表格x终点
    int xCursor = xEnd;                     // x游标
    int yStart = 40;                        // 表格y起点
    int yEnd = 1376;                        // 表格y起点
    int yCursor = yStart + text_padding;    // y游标
    int line_height = 1;                    // 线高
    int cell_height = 32;                   // 单元格高度
    int cell_width = 123;                   // 单元格高度
    
    // 画表格
    // 第1行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
            maker.vertical.value(YES);
        }];
    }];
    // 第2行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake((int)(xEnd - cell_height), yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第3行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 2, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第4行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 3, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第5行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第6行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 6, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第7行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    
    // 第1列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart));
            maker.size.value(CGSizeMake(xEnd - xStart, 1));
            maker.vertical.value(NO);
        }];
    }];
    // 第2列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width * 2.6));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第3列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width * 3));
            maker.size.value(CGSizeMake(cell_height * 4, 1));
        }];
    }];
    // 第4列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width * 4));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第5列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart + cell_width * 5));
            maker.size.value(CGSizeMake(xEnd - xStart - cell_height * 2, 1));
        }];
    }];
    // 第6列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width * 6));
            maker.size.value(CGSizeMake(cell_height * 4, 1));
        }];
    }];
    // 第7列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width * 7));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第8列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart + cell_width * 8));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第9列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart + cell_width * 9));
            maker.size.value(CGSizeMake(xEnd - xStart - cell_height * 2, 1));
        }];
    }];
    // 第10列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 6, yStart + cell_width * 10));
            maker.size.value(CGSizeMake(cell_height * 4, 1));
        }];
    }];
    // 第11列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yEnd));
            maker.size.value(CGSizeMake(xEnd - xStart, 1));
        }];
    }];
    
    
    // 填充内容
    // 打印公司名
    NSString *title = [NSString stringWithFormat:@"%@(%@)", printField.companyName.content, @"客户存根联"];
    [printerManager addText:title attributeBlock:^(CCPrint *print) {
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor + line_height + text_padding * 2 + text_common_height * 3 + text_padding * 2 + text_common_height * 3, yStart + cell_width));
            maker.size.value(CGSizeMake(cell_width * 6, 24));
            maker.vertical.value(YES);
        }];
    }];
    // 开单时间
    [printerManager addText:printField.billingDate.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor + line_height + text_padding * 2 + text_common_height * 3, yCursor));
            maker.size.value(CGSizeMake((yEnd - yStart) / 4, 24));
        }];
    }];
    // 发站
    [printerManager addText:printField.srcCity.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor + line_height + text_padding * 2 + text_common_height * 3, yCursor + (yEnd - yStart) / 4));
            maker.size.value(CGSizeMake((yEnd - yStart) / 4, 24));
        }];
    }];
    // 到站
    [printerManager addText:printField.desCity.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor + line_height + text_padding * 2 + text_common_height * 3, yCursor + (yEnd - yStart) / 2));
            maker.size.value(CGSizeMake((yEnd - yStart) / 4, 24));
        }];
    }];
    // 运单号
    [printerManager addText:printField.orderNumber.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor + line_height + text_padding * 2 + text_common_height * 3, yCursor + (yEnd - yStart) * 3 / 4));
            maker.size.value(CGSizeMake((yEnd - yStart) / 4, 24));
        }];
    }];
    /*
    // 收货人信息
    [printerManager addText:[NSString stringWithFormat:@"收货人:%@", orderModel.ceeName] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"电话:%@", orderModel.ceeMobile] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 3));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"地址:%@", orderModel.ceeAddr] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 6));
            maker.size.value(CGSizeMake(cell_width * 4, 24));
        }];
    }];
    // 移动x游标
    xCursor -= cell_height;
    // 发货人信息
    [printerManager addText:[NSString stringWithFormat:@"发货人:%@", orderModel.corName] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"电话:%@", orderModel.corMobile] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 3));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:[NSString stringWithFormat:@"地址:%@", orderModel.corAddr] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 6));
            maker.size.value(CGSizeMake(cell_width * 4, 24));
        }];
    }];
    // 移动x游标
    xCursor -= cell_height;
    // 打印货物信息
    NSMutableArray *goodsInfo = [NSMutableArray arrayWithObjects:@"货物名称", @"货号", @"件数", @"包装", @"重量体积", @"回单", @"运费", nil];
    NSMutableArray *goodsValue = [NSMutableArray arrayWithObjects:orderModel.goodsModel.goodsName ? : @"",
                                  [NSString stringWithFormat:@"%@", orderModel.goodsNum ? : @""],
                                  [NSString stringWithFormat:@"%@", orderModel.goodsModel.goodsNum ? : @""],
                                  [NSString stringWithFormat:@"%@", orderModel.goodsModel.goodsPkg ? : @""],
                                  [NSString stringWithFormat:@"%@%@/%@%@", orderModel.goodsModel.goodsWeight, orderModel.weightUnit, orderModel.goodsModel.goodsVolume, orderModel.volumeUnit],
                                  [NSString stringWithFormat:@"%@份", orderModel.receiptN ? : @""],
                                  [NSString stringWithFormat:@"%@", orderModel.coFreight ? : @""], nil];
    // 添加其他费用（按照价格大小取前4个费用）
    NSMutableDictionary *goodsInfoDict = [NSMutableDictionary dictionary];
    [goodsInfoDict setObject:orderModel.coInstall ? : @"" forKey:@"安装费"];
    [goodsInfoDict setObject:orderModel.coDeliveryAdv ? : @"" forKey:@"垫付货款"];
    [goodsInfoDict setObject:orderModel.dlbfee ? : @"" forKey:@"送货费"];
    [goodsInfoDict setObject:orderModel.coPkg ? : @"" forKey:@"包装费"];
    [goodsInfoDict setObject:orderModel.cashreturn ? : @"" forKey:@"现返"];
    [goodsInfoDict setObject:orderModel.discount ? : @"" forKey:@"欠返"];
    [goodsInfoDict setObject:orderModel.coTrans ? : @"" forKey:@"转交费"];
    [goodsInfoDict setObject:orderModel.coDeliveryFee ? : @"" forKey:@"货款手续费"];
    if ([orderModel.coPayAdvPaid isEqualToString:@"1"]) {
        [goodsInfoDict setObject:orderModel.coPayAdv ? : @"" forKey:@"垫付费(√)"];
    } else if ([orderModel.coPayAdvPaid isEqualToString:@"0"]) {
        [goodsInfoDict setObject:orderModel.coPayAdv ? : @"" forKey:@"垫付费(×)"];
    }
    [goodsInfoDict setObject:orderModel.declaredValue ? : @"" forKey:@"声明价值"];
    [goodsInfoDict setObject:orderModel.coInsurance ? : @"" forKey:@"保险费"];
    [goodsInfoDict setObject:orderModel.coPickup ? : @"" forKey:@"提货费"];
    [goodsInfoDict setObject:orderModel.coHandling ? : @"" forKey:@"装卸费"];
    [goodsInfoDict setObject:orderModel.coUpstair ? : @"" forKey:@"上楼费"];
    [goodsInfoDict setObject:orderModel.budgetTransPrice forKey:@"中转费"];
    [goodsInfoDict setObject:orderModel.budgetCustodianPrice forKey:@"保管费"];
    [goodsInfoDict setObject:orderModel.budgetWarehousingPrice forKey:@"进仓费"];
    [goodsInfoDict setObject:orderModel.coDeliveryAdv forKey:@"垫付货款"];
    [goodsInfoDict setObject:orderModel.coMisc ? : @"" forKey:@"其他费"];
    
    NSMutableArray *goodsInfoArray = [NSMutableArray array];
    for (NSString *key in goodsInfoDict) {
        MMGoodsInfoModel *model = [[MMGoodsInfoModel alloc] init];
        model.name = key;
        model.price = [[goodsInfoDict objectForKey:key] floatValue];
        [goodsInfoArray addObject:model];
    }
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:NO];
    [goodsInfoArray sortUsingDescriptors:@[sd]];
    for (int i =0; i < 4; i++) {
        MMGoodsInfoModel *model = [goodsInfoArray objectAtIndex:i];
        [goodsInfo addObject:model.name];
        [goodsValue addObject:[NSString stringWithFormat:@"%.2f", model.price]];
    }
    // 打印费用详情
    for (int i = 0; i < 11; i++) {
        NSString *title = goodsInfo[i];
        [printerManager addText:title attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * (i == 2 ? 2.6 : i)));
                maker.size.value(CGSizeMake(cell_width, 24));
                maker.font.value(CCPrintFontSizeL);
            }];
        }];
        
        NSString *value = goodsValue[i];
        [printerManager addText:value attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height * 2 + text_common_height * 3 + text_padding, yCursor + cell_width * (i == 2 ? 2.6 : i)));
                maker.size.value(CGSizeMake(cell_width * 1.6, 24));
            }];
        }];
    }
    xCursor -= cell_height * 2;
    // 打印合计
    NSMutableArray *payModeList = [NSMutableArray array];
    if ([orderModel.payBilling floatValue] > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"现付:%@", orderModel.payBilling]];
    }
    if (orderModel.payArrival.longValue > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"到付:%ld", orderModel.payArrival.longValue]];
    }
    if ([orderModel.payMonthly floatValue] > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"月结:%@", orderModel.payMonthly]];
    }
    if ([orderModel.payReceipt floatValue] > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"回付:%@", orderModel.payReceipt]];
    }
    if ([orderModel.payOwed floatValue] > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"欠付:%@", orderModel.payOwed]];
    }
    if ([orderModel.payCoDelivery floatValue] > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"货款扣:%@", orderModel.payCoDelivery]];
    }
    if ([orderModel.payCredit floatValue] > 0) {
        [payModeList addObject:[NSString stringWithFormat:@"货到打卡:%@", orderModel.payCredit]];
    }
    NSString *totalPrice = [NSString stringWithFormat:@"%@", orderModel.totalCost];
    if (payModeList.count) {
        totalPrice = [NSString stringWithFormat:@"%@(%@)", totalPrice, [payModeList componentsJoinedByString:@","]];
    }
    
    [printerManager addText:[NSString stringWithFormat:@"运费合计:%@", totalPrice] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height * 2 + text_common_height * 5, yCursor));
            maker.size.value(CGSizeMake(cell_width * 5, cell_height * 2));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(CCPrintFontSizeX);
        }];
    }];
    
    // 代收货款
    [printerManager addText:[NSString stringWithFormat:@"代收货款:%@元", orderModel.coDelivery] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height * 2 + text_common_height * 5, yCursor + cell_width * 5));
            maker.size.value(CGSizeMake(cell_width * 3, cell_height * 2));
        }];
        [print cc_aloneAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(CCPrintFontSizeX);
        }];
    }];
    // 送货方式&付款方式
    [printerManager addText:@"送货方式" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 9));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    [printerManager addText:@"付款方式" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 10));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    xCursor -= cell_height;
    
    [printerManager addText:orderModel.deliveryMode attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 9));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    [printerManager addText:orderModel.payModeDisp attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 10));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    xCursor -= cell_height;
    
    int line7YPoint = xCursor;
    // 运输协议
    NSArray *termSheets = [CCPrintUtilities subStringForMultipLine:[NSString stringWithFormat:@"运输协议:%@", printSetting.termSheetConfig[@"termSheet"] ? : @""] maxLine:7 eachLineSize:28];
    for (NSString *term in termSheets) {
        [printerManager addText:term attributeBlock:^(CCPrint *print) {
            [print cc_updateAttributes:^(CCAttributeMaker *maker) {
                maker.font.value(CCPrintFontSizeL);
            }];
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor));
                maker.size.value(CGSizeMake(cell_width * 5, 24));
            }];
        }];
        xCursor -= cell_height;
    }
    
    xCursor = line7YPoint;
    // 备注
    NSArray *remarkArray = [CCPrintUtilities subStringForMultipLine:[NSString stringWithFormat:@"备注:%@", orderModel.remark] maxLine:2 eachLineSize:17];
    for (NSString *remark in remarkArray) {
        [printerManager addText:remark attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
                maker.size.value(CGSizeMake(cell_width * 3, 24));
            }];
        }];
        xCursor -= cell_height;
    }
    
    // 发站
    NSArray *srcAddress = [CCPrintUtilities subStringForMultipLine:[NSString stringWithFormat:@"发站地址:%@", orderModel.startAddr] maxLine:2 eachLineSize:17];
    for (NSString *srcAddr in srcAddress) {
        [printerManager addText:srcAddr attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
                maker.size.value(CGSizeMake(cell_width * 3, 24));
            }];
        }];
        xCursor -= cell_height;
    }
    [printerManager addText:[NSString stringWithFormat:@"发站电话:%@", orderModel.startPhone] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    
    xCursor -= cell_height;
    // 到站
    NSArray *dstAddress = [CCPrintUtilities subStringForMultipLine:[NSString stringWithFormat:@"到站地址:%@", orderModel.dstAddr] maxLine:2 eachLineSize:17];
    for (NSString *dstAddr in dstAddress) {
        [printerManager addText:dstAddr attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
                maker.size.value(CGSizeMake(cell_width * 3, 24));
            }];
        }];
        xCursor -= cell_height;
    }
    [printerManager addText:[NSString stringWithFormat:@"到站电话:%@", orderModel.dstPhone] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    */
    // 条形码、二维码
    [printerManager addBarcode:printField.queryNumber.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd + line_height + text_padding * 2 + text_common_height * 3 + text_padding * 2, yStart + (int)(cell_width * 7.5)));
            maker.size.value(CGSizeMake(300, 50));
        }];
    }];
    [printerManager addQRcode:printField.qRCode.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + line_height + text_common_height * 3 + text_padding * 4, yStart + cell_width * 9 + 65));
            maker.size.value(CGSizeMake(160, 160));
        }];
    }];
    [printerManager addText:@"扫描二维码可以查货" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + text_padding * 2 + text_common_height * 3, yStart + (int)(cell_width * 9)));
        }];
    }];
    [printerManager addText:printField.operatorName.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart - text_padding, yCursor));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:@"发货人签字:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart - text_padding, yCursor + cell_width * 3));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:@"收货人签字:" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart - text_padding, yCursor + cell_width * 6));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addPrintSpacing];
    [printerManager endPrint];
}

@end
