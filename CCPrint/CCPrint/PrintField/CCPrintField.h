//
//  CCPrintField.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/20.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPrintModel.h"

@interface CCPrintField : NSObject

#pragma mark - 运单信息
/// 公司名
@property (nonatomic, copy) CCPrintModel *companyName;
/// 运单号
@property (nonatomic, copy) CCPrintModel *orderNumber;
/// 货号
@property (nonatomic, copy) CCPrintModel *goodsSerialNo;
/// 发站
@property (nonatomic, copy) CCPrintModel *srcCity;
/// 到站
@property (nonatomic, copy) CCPrintModel *desCity;
/// 开单时间
@property (nonatomic, copy) CCPrintModel *billingDate;
/// 委托单号
@property (nonatomic, copy) CCPrintModel *customOrderNumber;
/// 发货人
@property (nonatomic, copy) CCPrintModel *consignor;
/// 发货电话
@property (nonatomic, copy) CCPrintModel *consignorTel;
/// 发货地址
@property (nonatomic, copy) CCPrintModel *consignorAddress;
/// 收货人
@property (nonatomic, copy) CCPrintModel *consignee;
/// 收货电话
@property (nonatomic, copy) CCPrintModel *consigneeTel;
/// 收货地址
@property (nonatomic, copy) CCPrintModel *consigneeAddress;
/// 发站网点名称
@property (nonatomic, copy) CCPrintModel *fromPoint;
/// 到站网点名称
@property (nonatomic, copy) CCPrintModel *toPoint;
/// 落货点
@property (nonatomic, copy) CCPrintModel *unloadPoint;
/// 会员编号
@property (nonatomic, copy) CCPrintModel *memberCode;
/// 目的网点
@property (nonatomic, copy) CCPrintModel *arrPoint;
/// 目的网点简称&代号
@property (nonatomic, copy) CCPrintModel *arrPointCode;
/// 路由
@property (nonatomic, copy) CCPrintModel *router;
/// 发站名称
@property (nonatomic, copy) CCPrintModel *srcName;
/// 到站名称
@property (nonatomic, copy) CCPrintModel *desName;

#pragma mark - 货物信息
/// 货物名称
@property (nonatomic, copy) CCPrintModel *goodsName;
/// 货物件数
@property (nonatomic, copy) CCPrintModel *goodsNumber;
/// 货物重量
@property (nonatomic, copy) CCPrintModel *goodsWeight;
/// 货物体积
@property (nonatomic, copy) CCPrintModel *goodsVolume;
/// 回单数
@property (nonatomic, copy) CCPrintModel *receiptNum;
/// 送货方式
@property (nonatomic, copy) CCPrintModel *consigneeMode;
/// 包装方式
@property (nonatomic, copy) CCPrintModel *packMode;
/// 运输方式
@property (nonatomic, copy) CCPrintModel *transMode;
/// 货物重量单位
@property (nonatomic, copy) CCPrintModel *goodsWeightUnit;

#pragma mark - 费用信息

/// 运费
@property (nonatomic, copy) CCPrintModel *freightPrice;
/// 声明价值
@property (nonatomic, copy) CCPrintModel *goodsValue;
/// 送货费
@property (nonatomic, copy) CCPrintModel *deliveryFreight;
/// 垫付费
@property (nonatomic, copy) CCPrintModel *payAdvance;
/// 垫付货款
@property (nonatomic, copy) CCPrintModel *coDeliveryAdvance;
/// 保险费
@property (nonatomic, copy) CCPrintModel *insurancePrice;
/// 提货费
@property (nonatomic, copy) CCPrintModel *pickGoodsPrice;
/// 装卸费
@property (nonatomic, copy) CCPrintModel *handlingPrice;
/// 上楼费
@property (nonatomic, copy) CCPrintModel *upstairsPrice;
/// 中转费
@property (nonatomic, copy) CCPrintModel *transFreight;
/// 安装费
@property (nonatomic, copy) CCPrintModel *budgetInstallPrice;
/// 包装费
@property (nonatomic, copy) CCPrintModel *packageFreight;
/// 保管费
@property (nonatomic, copy) CCPrintModel *budgetCustodianPrice;
/// 进仓费
@property (nonatomic, copy) CCPrintModel *budgetWarehousingPrice;
/// 税费
@property (nonatomic, copy) CCPrintModel *budgetTax;
/// 其他费
@property (nonatomic, copy) CCPrintModel *miscPrice;
/// 合计费用
@property (nonatomic, copy) CCPrintModel *totalPrice;
/// 代收货款
@property (nonatomic, copy) CCPrintModel *collectionOnDelivery;
/// 货款手续费
@property (nonatomic, copy) CCPrintModel *coDeliveryFee;
/// 代收到付
@property (nonatomic, copy) CCPrintModel *coPayArrival;
/// 现返
@property (nonatomic, copy) CCPrintModel *cashReturn;
/// 欠返
@property (nonatomic, copy) CCPrintModel *discount;

#pragma mark - 付款方式
/// 现付
@property (nonatomic, copy) CCPrintModel *payBilling;
/// 到付
@property (nonatomic, copy) CCPrintModel *payArrival;
/// 欠付
@property (nonatomic, copy) CCPrintModel *toPay;
/// 回付
@property (nonatomic, copy) CCPrintModel *payBack;
/// 月结
@property (nonatomic, copy) CCPrintModel *payMonth;
/// 货到打卡
@property (nonatomic, copy) CCPrintModel *arrivalPayByCredit;
/// 货款扣
@property (nonatomic, copy) CCPrintModel *payCoDelivery;
/// 支付类型
@property (nonatomic, copy) CCPrintModel *paymentMode;
/// 付款方式
@property (nonatomic, copy) CCPrintModel *payType;

#pragma mark - 附加信息
/// 发站地址
@property (nonatomic, copy) CCPrintModel *srcAddress;
/// 发站电话
@property (nonatomic, copy) CCPrintModel *srcTel;
/// 到站地址
@property (nonatomic, copy) CCPrintModel *desAddress;
/// 到站电话
@property (nonatomic, copy) CCPrintModel *desTel;
/// 备注
@property (nonatomic, copy) CCPrintModel *remark;
/// 打印操作员
@property (nonatomic, copy) CCPrintModel *printOperator;
/// 经办人
@property (nonatomic, copy) CCPrintModel *operatorName;
/// 二维码
@property (nonatomic, copy) CCPrintModel *qRCode;
/// 查单号
@property (nonatomic, copy) CCPrintModel *queryNumber;
/// 条款
@property (nonatomic, copy) CCPrintModel *termSheet;
/// 运单创建人
@property (nonatomic, copy) CCPrintModel *orderCreator;
/// 运单创建电话
@property (nonatomic, copy) CCPrintModel *orderCreatorPhone;
/// 应收款
@property (nonatomic, copy) CCPrintModel *accountsReceivable;
/// 发站区域
@property (nonatomic, copy) CCPrintModel *srcArea;
/// 到站区域
@property (nonatomic, copy) CCPrintModel *desArea;
/// 发货人签字
@property (nonatomic, copy) CCPrintModel *sign;
/// 签收日期
@property (nonatomic, copy) CCPrintModel *signDate;

/**
 给打印数据赋值

 @param content 打印内容
 @param printModel 打印内容模型
 */
void setPrintContent(NSString *content, CCPrintModel *printModel);

/**
 获取打印数据

 @param printModel 打印内容模型
 @param placeholder 打印缺省值
 @return 打印内容
 */
NSString* getPrintContent(CCPrintModel *printModel, NSString *placeholder);

- (void)setDefaultContent;

@end
