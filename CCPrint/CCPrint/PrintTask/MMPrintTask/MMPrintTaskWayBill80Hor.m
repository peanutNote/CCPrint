//
//  MMPrintTaskWayBill80Hor.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/17.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "MMPrintTaskWayBill80Hor.h"
#import "CCPrintManager.h"

@interface MMGoodsInfoModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat price;

@end

@implementation MMGoodsInfoModel
@end

@implementation MMPrintTaskWayBill80Hor

- (void)printWithField:(CCPrintField *)printField {
    CCPrintManager *printerManager = [CCPrintManager sharePrinterManager];
    printerManager.layoutType = CCSizeLayoutAbsolute;
    printerManager.layoutSize = CGSizeMake(600, 1500);
    [printerManager startPrintWithTaskModel:MMPrintTaskModelWayBill80Hor];
    const int text_common_height = 8;             // 字高公倍数
    const int text_padding = 6;                   // 行间距
    const int xStart = 22;                        // 表格x起点
    const int xEnd = 474;                         // 表格x终点
    int xCursor = xEnd;                     // x游标
    const int yStart = 40;                        // 表格y起点
    const int yEnd = 1376;                        // 表格y起点
    int yCursor = yStart + text_padding;    // y游标
    const int line_height = 1;                    // 线高
    const int cell_height = 32;                   // 单元格高度
    const int cell_width = 133;                   // 单元格高度
    
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
            maker.position.value(CGPointMake((int)(xEnd - cell_height * 1.5), yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第3行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 3, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第4行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 4, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第5行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart));
            maker.size.value(CGSizeMake(1, yEnd - yStart));
        }];
    }];
    // 第6行
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 7, yStart));
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
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart + cell_width));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第3列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart + cell_width * 2));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第4列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart + cell_width * 3));
            maker.size.value(CGSizeMake(cell_height * 5, 1));
        }];
    }];
    // 第5列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart + cell_width * 4));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第6列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart + cell_width * 5));
            maker.size.value(CGSizeMake(xEnd - xStart - cell_height * 3, 1));
        }];
    }];
    // 第7列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart + cell_width * 6));
            maker.size.value(CGSizeMake(cell_height * 5, 1));
        }];
    }];
    // 第8列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 5, yStart + cell_width * 7));
            maker.size.value(CGSizeMake(cell_height * 2, 1));
        }];
    }];
    // 第9列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart, yStart + cell_width * 8));
            maker.size.value(CGSizeMake(xEnd - xStart - cell_height * 3, 1));
        }];
    }];
    // 第10列
    [printerManager addLineAttributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd - cell_height * 7, yStart + cell_width * 9));
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
            maker.bold.value(YES);
            maker.vertical.value(YES);
            maker.font.value(CCPrintFontSizeX);
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
    // 收货人信息
    [printerManager addText:printField.consignee.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:printField.consigneeTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 3));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:printField.consigneeAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 6));
            maker.size.value(CGSizeMake(cell_width * 4, 24));
        }];
    }];
    // 移动x游标
    xCursor -= (cell_height * 1.5);
    // 发货人信息
    NSString *memberCode = [NSString stringWithFormat:@"(VIP:%@)", printField.memberCode.content];
    [printerManager addText:[NSString stringWithFormat:@"发货人:%@%@", printField.consignor.content, memberCode] attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:printField.consignorTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 3));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    [printerManager addText:printField.consignorAddress.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3, yCursor + cell_width * 6));
            maker.size.value(CGSizeMake(cell_width * 4, 24));
        }];
    }];
    // 移动x游标
    xCursor -= (cell_height * 1.5);
    // 打印货物信息
    NSMutableArray *goodsInfo = [NSMutableArray arrayWithObjects:@"货物名称", @"件数", @"包装", @"重量体积", @"回单", @"运费", nil];
    NSMutableArray *goodsValue = [NSMutableArray arrayWithObjects:printField.goodsName.content,
                                  printField.goodsNumber.content,
                                  printField.packMode.content,
                                  [NSString stringWithFormat:@"%@，%@", printField.goodsWeight.content, printField.goodsValue.content],
                                  [NSString stringWithFormat:@"%@", printField.receiptNum.content],
                                  [NSString stringWithFormat:@"%@", printField.freightPrice.content], nil];
    // 添加其他费用（按照价格大小取前4个费用）
    NSMutableDictionary *goodsInfoDict = [NSMutableDictionary dictionary];
    [goodsInfoDict setObject:printField.deliveryFreight.content forKey:@"送货费"];
    NSString *advancePaid = @"(已垫付)";
    [goodsInfoDict setObject:[NSString stringWithFormat:@"%@%@", printField.payAdvance.content, advancePaid] forKey:@"垫付费"];
    [goodsInfoDict setObject:printField.goodsValue.content forKey:@"声明价值"];
    [goodsInfoDict setObject:printField.insurancePrice.content forKey:@"保险费"];
    [goodsInfoDict setObject:printField.miscPrice.content forKey:@"其他费"];
    
    
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
    for (int i = 0; i < 10; i++) {
        NSString *title = goodsInfo[i];
        [printerManager addText:title attributeBlock:^(CCPrint *print) {
            [print cc_updateAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * i));
                maker.size.value(CGSizeMake(cell_width, 24));
                maker.bold.value(NO);
                maker.font.value(CCPrintFontSizeL);
            }];
        }];
        
        NSString *value = goodsValue[i];
        [printerManager addText:value attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height * 2 + text_common_height * 3 + text_padding, yCursor + cell_width * i));
                maker.size.value(CGSizeMake(cell_width, 24));
            }];
        }];
    }
    xCursor -= cell_height * 2;
    // 打印合计
    NSMutableArray *payModeList = [NSMutableArray array];
    [payModeList addObject:printField.payBilling.attachContent];
    [payModeList addObject:printField.payArrival.attachContent];
    
    
    NSString *totalPrice = printField.totalPrice.content;
    totalPrice = [NSString stringWithFormat:@"%@(%@)", totalPrice, [payModeList componentsJoinedByString:@","]];
    
    [printerManager addText:[NSString stringWithFormat:@"运费合计:%@", totalPrice] attributeBlock:^(CCPrint *print) {
       [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
           maker.position.value(CGPointMake(xCursor - cell_height * 2 + text_common_height * 5, yCursor));
           maker.size.value(CGSizeMake(cell_width * 5, cell_height * 2));
       }];
        [print cc_updateAttributes:^(CCAttributeMaker *maker) {
            maker.font.value(CCPrintFontSizeX);
        }];
    }];
    
    // 代收货款
    [printerManager addText:printField.collectionOnDelivery.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height * 2 + text_common_height * 5, yCursor + cell_width * 5));
            maker.size.value(CGSizeMake(cell_width * 3, cell_height * 2));
        }];
    }];
    // 送货方式&付款方式
    [printerManager addText:@"送货方式" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 8));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    [printerManager addText:@"付款方式" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 9));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    xCursor -= cell_height;
    
    [printerManager addText:printField.consigneeMode.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 8));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    [printerManager addText:printField.payType.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 9));
            maker.size.value(CGSizeMake(cell_width, cell_height));
        }];
    }];
    xCursor -= cell_height;
    
    int line7YPoint = xCursor;
    // 运输协议
    NSArray *termSheets = [CCPrintUtilities subStringForMultipLine:printField.termSheet.attachContent maxLine:7 eachLineSize:28];
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
    NSArray *remarkArray = [CCPrintUtilities subStringForMultipLine:printField.remark.attachContent maxLine:2 eachLineSize:17];
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
    NSArray *srcAddress = [CCPrintUtilities subStringForMultipLine:printField.srcAddress.attachContent maxLine:2 eachLineSize:17];
    for (NSString *srcAddr in srcAddress) {
        [printerManager addText:srcAddr attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
                maker.size.value(CGSizeMake(cell_width * 3, 24));
            }];
        }];
        xCursor -= cell_height;
    }
    [printerManager addText:printField.srcTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    
    xCursor -= cell_height;
    // 到站
    NSArray *dstAddress = [CCPrintUtilities subStringForMultipLine:printField.desAddress.attachContent maxLine:2 eachLineSize:17];
    for (NSString *dstAddr in dstAddress) {
        [printerManager addText:dstAddr attributeBlock:^(CCPrint *print) {
            [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
                maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
                maker.size.value(CGSizeMake(cell_width * 3, 24));
            }];
        }];
        xCursor -= cell_height;
    }
    [printerManager addText:printField.desTel.attachContent attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xCursor - cell_height + text_common_height * 3 + text_padding, yCursor + cell_width * 5));
            maker.size.value(CGSizeMake(cell_width * 3, 24));
        }];
    }];
    
    // 条形码、二维码
    [printerManager addBarcode:printField.queryNumber.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xEnd + line_height + text_padding * 2 + text_common_height * 3 + text_padding * 2, yStart + (int)(cell_width * 7.5)));
            maker.size.value(CGSizeMake(300, 50));
        }];
    }];
    [printerManager addQRcode:printField.qRCode.content attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + line_height + text_common_height * 3 + text_padding * 2, yStart + cell_width * 8 + 65));
            maker.size.value(CGSizeMake(160, 160));
        }];
    }];
    [printerManager addText:@"扫描二维码可以查货" attributeBlock:^(CCPrint *print) {
        [print cc_multiplexAttributes:^(CCAttributeMaker *maker) {
            maker.position.value(CGPointMake(xStart + text_padding * 2 + text_common_height * 3, yStart + (int)(cell_width * 8.25)));
        }];
    }];
    [printerManager addPrintSpacing];
    [printerManager endPrint];
}

@end

