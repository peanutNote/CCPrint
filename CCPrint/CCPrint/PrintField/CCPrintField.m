//
//  CCPrintField.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/20.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrintField.h"

@implementation CCPrintField

void setPrintContent(NSString *content, CCPrintModel *printModel) {
    if (content && [content isKindOfClass:[NSString class]] && content.length) {
        printModel.content = content;
    }
    printModel.attachContent = [NSString stringWithFormat:@"%@%@", printModel.attach, printModel.content];
}
NSString* getPrintContent(CCPrintModel *printModel, NSString *placeholder) {
    NSString *printContent = placeholder;
    if (printModel.content && [printModel.content isKindOfClass:[NSString class]] && printModel.content.length) {
        printContent = printModel.content;
    }
    return printContent;
}

#pragma mark - Setter&Getter

- (CCPrintModel *)companyName {
    if (_companyName == nil) {
        _companyName = [[CCPrintModel alloc] init];
        _companyName.attach = @"公司名：";
    }
    return _companyName;
}

- (CCPrintModel *)orderNumber {
    if (_orderNumber == nil) {
        _orderNumber = [[CCPrintModel alloc] init];
        _orderNumber.attach = @"运单号：";
    }
    return _orderNumber;
}

- (CCPrintModel *)goodsSerialNo {
    if (_goodsSerialNo == nil) {
        _goodsSerialNo = [[CCPrintModel alloc] init];
        _goodsSerialNo.attach = @"货号：";
    }
    return _goodsSerialNo;
}

- (CCPrintModel *)srcCity {
    if (_srcCity == nil) {
        _srcCity = [[CCPrintModel alloc] init];
        _srcCity.attach = @"发站：";
    }
    return _srcCity;
}

- (CCPrintModel *)desCity {
    if (_desCity == nil) {
        _desCity = [[CCPrintModel alloc] init];
        _desCity.attach = @"到站：";
    }
    return _desCity;
}

- (CCPrintModel *)billingDate {
    if (_billingDate == nil) {
        _billingDate = [[CCPrintModel alloc] init];
        _billingDate.attach = @"开单日期：";
    }
    return _billingDate;
}

- (CCPrintModel *)customOrderNumber {
    if (_customOrderNumber == nil) {
        _customOrderNumber = [[CCPrintModel alloc] init];
        _customOrderNumber.attach = @"委托单号：";
    }
    return _customOrderNumber;
}

- (CCPrintModel *)consignor {
    if (_consignor == nil) {
        _consignor = [[CCPrintModel alloc] init];
        _consignor.attach = @"发货人：";
    }
    return _consignor;
}

- (CCPrintModel *)consignorTel {
    if (_consignorTel == nil) {
        _consignorTel = [[CCPrintModel alloc] init];
        _consignorTel.attach = @"发货人电话：";
    }
    return _consignorTel;
}

- (CCPrintModel *)consignorAddress {
    if (_consignorAddress == nil) {
        _consignorAddress = [[CCPrintModel alloc] init];
        _consignorAddress.attach = @"发货人地址：";
    }
    return _consignorAddress;
}

- (CCPrintModel *)consignee {
    if (_consignee == nil) {
        _consignee = [[CCPrintModel alloc] init];
        _consignee.attach = @"收货人：";
    }
    return _consignee;
}

- (CCPrintModel *)consigneeTel {
    if (_consigneeTel == nil) {
        _consigneeTel = [[CCPrintModel alloc] init];
        _consigneeTel.attach = @"收货人电话：";
    }
    return _consigneeTel;
}

- (CCPrintModel *)consigneeAddress {
    if (_consigneeAddress == nil) {
        _consigneeAddress = [[CCPrintModel alloc] init];
        _consigneeAddress.attach = @"收货人地址：";
    }
    return _consigneeAddress;
}

- (CCPrintModel *)fromPoint {
    if (_fromPoint == nil) {
        _fromPoint = [[CCPrintModel alloc] init];
        _fromPoint.attach = @"发站网点名称：";
    }
    return _fromPoint;
}

- (CCPrintModel *)toPoint {
    if (_toPoint == nil) {
        _toPoint = [[CCPrintModel alloc] init];
        _toPoint.attach = @"到站网点名称：";
    }
    return _toPoint;
}

- (CCPrintModel *)unloadPoint {
    if (_unloadPoint == nil) {
        _unloadPoint = [[CCPrintModel alloc] init];
        _unloadPoint.attach = @"落货点：";
    }
    return _unloadPoint;
}

- (CCPrintModel *)memberCode {
    if (_memberCode == nil) {
        _memberCode = [[CCPrintModel alloc] init];
        _memberCode.attach = @"会员编号：";
    }
    return _memberCode;
}

- (CCPrintModel *)arrPoint {
    if (_arrPoint == nil) {
        _arrPoint = [[CCPrintModel alloc] init];
        _arrPoint.attach = @"目的网点：";
    }
    return _arrPoint;
}

- (CCPrintModel *)arrPointCode {
    if (_arrPointCode == nil) {
        _arrPointCode = [[CCPrintModel alloc] init];
        _arrPointCode.attach = @"目的网点代号：";
    }
    return _arrPointCode;
}

- (CCPrintModel *)router {
    if (_router == nil) {
        _router = [[CCPrintModel alloc] init];
        _router.attach = @"路由：";
    }
    return _router;
}

- (CCPrintModel *)srcName {
    if (_srcName == nil) {
        _srcName = [[CCPrintModel alloc] init];
        _srcName.attach = @"发站名称：";
    }
    return _srcName;
}

- (CCPrintModel *)desName {
    if (_desName == nil) {
        _desName = [[CCPrintModel alloc] init];
        _desName.attach = @"到站名称：";
    }
    return _desName;
}

- (CCPrintModel *)goodsName {
    if (_goodsName == nil) {
        _goodsName = [[CCPrintModel alloc] init];
        _goodsName.attach = @"货物名称：";
    }
    return _goodsName;
}

- (CCPrintModel *)goodsNumber {
    if (_goodsNumber == nil) {
        _goodsNumber = [[CCPrintModel alloc] init];
        _goodsNumber.attach = @"件数：";
    }
    return _goodsNumber;
}

- (CCPrintModel *)goodsWeight {
    if (_goodsWeight == nil) {
        _goodsWeight = [[CCPrintModel alloc] init];
        _goodsWeight.attach = @"重量：";
    }
    return _goodsWeight;
}

- (CCPrintModel *)goodsVolume {
    if (_goodsVolume == nil) {
        _goodsVolume = [[CCPrintModel alloc] init];
        _goodsVolume.attach = @"体积：";
    }
    return _goodsVolume;
}

- (CCPrintModel *)receiptNum {
    if (_receiptNum == nil) {
        _receiptNum = [[CCPrintModel alloc] init];
        _receiptNum.attach = @"回单：";
    }
    return _receiptNum;
}

- (CCPrintModel *)consigneeMode {
    if (_consigneeMode == nil) {
        _consigneeMode = [[CCPrintModel alloc] init];
        _consigneeMode.attach = @"送货方式：";
    }
    return _consigneeMode;
}

- (CCPrintModel *)packMode {
    if (_packMode == nil) {
        _packMode = [[CCPrintModel alloc] init];
        _packMode.attach = @"包装方式：";
    }
    return _packMode;
}

- (CCPrintModel *)transMode {
    if (_transMode == nil) {
        _transMode = [[CCPrintModel alloc] init];
        _transMode.attach = @"运输方式：";
    }
    return _transMode;
}

- (CCPrintModel *)goodsWeightUnit {
    if (_goodsWeightUnit == nil) {
        _goodsWeightUnit = [[CCPrintModel alloc] init];
        _goodsWeightUnit.attach = @"重量单位：";
    }
    return _goodsWeightUnit;
}

- (CCPrintModel *)freightPrice {
    if (_freightPrice == nil) {
        _freightPrice = [[CCPrintModel alloc] init];
        _freightPrice.attach = @"运费：";
    }
    return _freightPrice;
}

- (CCPrintModel *)goodsValue {
    if (_goodsValue == nil) {
        _goodsValue = [[CCPrintModel alloc] init];
        _goodsValue.attach = @"声明价值：";
    }
    return _goodsValue;
}

- (CCPrintModel *)deliveryFreight {
    if (_deliveryFreight == nil) {
        _deliveryFreight = [[CCPrintModel alloc] init];
        _deliveryFreight.attach = @"送货费：";
    }
    return _deliveryFreight;
}

- (CCPrintModel *)payAdvance {
    if (_payAdvance == nil) {
        _payAdvance = [[CCPrintModel alloc] init];
        _payAdvance.attach = @"垫付费：";
    }
    return _payAdvance;
}

- (CCPrintModel *)coDeliveryAdvance {
    if (_coDeliveryAdvance == nil) {
        _coDeliveryAdvance = [[CCPrintModel alloc] init];
        _coDeliveryAdvance.attach = @"垫付货款：";
    }
    return _coDeliveryAdvance;
}

- (CCPrintModel *)insurancePrice {
    if (_insurancePrice == nil) {
        _insurancePrice = [[CCPrintModel alloc] init];
        _insurancePrice.attach = @"保险费：";
    }
    return _insurancePrice;
}

- (CCPrintModel *)pickGoodsPrice {
    if (_pickGoodsPrice == nil) {
        _pickGoodsPrice = [[CCPrintModel alloc] init];
        _pickGoodsPrice.attach = @"提货费：";
    }
    return _pickGoodsPrice;
}

- (CCPrintModel *)handlingPrice {
    if (_handlingPrice == nil) {
        _handlingPrice = [[CCPrintModel alloc] init];
        _handlingPrice.attach = @"装卸费：";
    }
    return _handlingPrice;
}

- (CCPrintModel *)upstairsPrice {
    if (_upstairsPrice == nil) {
        _upstairsPrice = [[CCPrintModel alloc] init];
        _upstairsPrice.attach = @"上楼费：";
    }
    return _upstairsPrice;
}

- (CCPrintModel *)transFreight {
    if (_transFreight == nil) {
        _transFreight = [[CCPrintModel alloc] init];
        _transFreight.attach = @"中转费：";
    }
    return _transFreight;
}

- (CCPrintModel *)budgetInstallPrice {
    if (_budgetInstallPrice) {
        _budgetInstallPrice = [[CCPrintModel alloc] init];
        _budgetInstallPrice.attach = @"安装费：";
    }
    return _budgetInstallPrice;
}

- (CCPrintModel *)packageFreight {
    if (_packageFreight == nil) {
        _packageFreight = [[CCPrintModel alloc] init];
        _packageFreight.attach = @"包装费：";
    }
    return _packageFreight;
}

- (CCPrintModel *)budgetCustodianPrice {
    if (_budgetCustodianPrice == nil) {
        _budgetCustodianPrice = [[CCPrintModel alloc] init];
        _budgetCustodianPrice.attach = @"保管费：";
    }
    return _budgetCustodianPrice;
}

- (CCPrintModel *)budgetWarehousingPrice {
    if (_budgetWarehousingPrice == nil) {
        _budgetWarehousingPrice = [[CCPrintModel alloc] init];
        _budgetWarehousingPrice.attach = @"进仓费：";
    }
    return _budgetWarehousingPrice;
}

- (CCPrintModel *)budgetTax {
    if (_budgetTax == nil) {
        _budgetTax = [[CCPrintModel alloc] init];
        _budgetTax.attach = @"税费：";
    }
    return _budgetTax;
}

- (CCPrintModel *)miscPrice {
    if (_miscPrice == nil) {
        _miscPrice = [[CCPrintModel alloc] init];
        _miscPrice.attach = @"其他费：";
    }
    return _miscPrice;
}

- (CCPrintModel *)totalPrice {
    if (_totalPrice == nil) {
        _totalPrice = [[CCPrintModel alloc] init];
        _totalPrice.attach = @"合计费用：";
    }
    return _totalPrice;
}

- (CCPrintModel *)collectionOnDelivery {
    if (_collectionOnDelivery == nil) {
        _collectionOnDelivery = [[CCPrintModel alloc] init];
        _collectionOnDelivery.attach = @"代收货款：";
    }
    return _collectionOnDelivery;
}

- (CCPrintModel *)coDeliveryFee {
    if (_coDeliveryFee == nil) {
        _coDeliveryFee = [[CCPrintModel alloc] init];
        _coDeliveryFee.attach = @"货款手续费：";
    }
    return _coDeliveryFee;
}

- (CCPrintModel *)coPayArrival {
    if (_coPayArrival == nil) {
        _coPayArrival = [[CCPrintModel alloc] init];
        _coPayArrival.attach = @"代收到付：";
    }
    return _coPayArrival;
}

- (CCPrintModel *)cashReturn {
    if (_cashReturn == nil) {
        _cashReturn = [[CCPrintModel alloc] init];
        _cashReturn.attach = @"现返：";
    }
    return _cashReturn;
}

- (CCPrintModel *)discount {
    if (_discount == nil) {
        _discount = [[CCPrintModel alloc] init];
        _discount.attach = @"欠返：";
    }
    return _discount;
}

- (CCPrintModel *)payBilling {
    if (_payBilling == nil) {
        _payBilling = [[CCPrintModel alloc] init];
        _payBilling.attach = @"现付：";
    }
    return _payBilling;
}

- (CCPrintModel *)payArrival {
    if (_payArrival == nil) {
        _payArrival = [[CCPrintModel alloc] init];
        _payArrival.attach = @"到付：";
    }
    return _payArrival;
}

- (CCPrintModel *)toPay {
    if (_toPay == nil) {
        _toPay = [[CCPrintModel alloc] init];
        _toPay.attach = @"欠付：";
    }
    return _toPay;
}

- (CCPrintModel *)payBack {
    if (_payBack == nil) {
        _payBack = [[CCPrintModel alloc] init];
        _payBack.attach = @"回付：";
    }
    return _payBack;
}

- (CCPrintModel *)payMonth {
    if (_payMonth == nil) {
        _payMonth = [[CCPrintModel alloc] init];
        _payMonth.attach = @"月结：";
    }
    return _payMonth;
}

- (CCPrintModel *)arrivalPayByCredit {
    if (_arrivalPayByCredit == nil) {
        _arrivalPayByCredit = [[CCPrintModel alloc] init];
        _arrivalPayByCredit.attach = @"货到打卡：";
    }
    return _arrivalPayByCredit;
}

- (CCPrintModel *)payCoDelivery {
    if (_payCoDelivery == nil) {
        _payCoDelivery = [[CCPrintModel alloc] init];
        _payCoDelivery.attach = @"货款扣：";
    }
    return _payCoDelivery;
}

- (CCPrintModel *)paymentMode {
    if (_paymentMode == nil) {
        _paymentMode = [[CCPrintModel alloc] init];
        _paymentMode.attach = @"支付类型：";
    }
    return _paymentMode;
}

- (CCPrintModel *)payType {
    if (_payType == nil) {
        _payType = [[CCPrintModel alloc] init];
        _payType.attach = @"付款方式：";
    }
    return _payType;
}

- (CCPrintModel *)srcAddress {
    if (_srcAddress == nil) {
        _srcAddress = [[CCPrintModel alloc] init];
    }
    return _srcAddress;
}

- (CCPrintModel *)srcTel {
    if (_srcTel == nil) {
        _srcTel = [[CCPrintModel alloc] init];
        _srcTel.attach = @"发站电话：";
    }
    return _srcTel;
}

- (CCPrintModel *)desAddress {
    if (_desAddress == nil) {
        _desAddress = [[CCPrintModel alloc] init];
        _desAddress.attach = @"到站地址：";
    }
    return _desAddress;
}

- (CCPrintModel *)desTel {
    if (_desTel == nil) {
        _desTel = [[CCPrintModel alloc] init];
        _desTel.attach = @"到站电话：";
    }
    return _desTel;
}

- (CCPrintModel *)remark {
    if (_remark == nil) {
        _remark = [[CCPrintModel alloc] init];
        _remark.attach = @"备注：";
    }
    return _remark;
}

- (CCPrintModel *)printOperator {
    if (_printOperator == nil) {
        _printOperator = [[CCPrintModel alloc] init];
        _printOperator.attach = @"打印操作员：";
    }
    return _printOperator;
}

- (CCPrintModel *)operatorName {
    if (_operatorName == nil) {
        _operatorName = [[CCPrintModel alloc] init];
        _operatorName.attach = @"经办人：";
    }
    return _operatorName;
}

- (CCPrintModel *)qRCode {
    if (_qRCode == nil) {
        _qRCode = [[CCPrintModel alloc] init];
        _qRCode.attach = @"二维码：";
    }
    return _qRCode;
}

- (CCPrintModel *)queryNumber {
    if (_queryNumber == nil) {
        _queryNumber = [[CCPrintModel alloc] init];
        _queryNumber.attach = @"查单号：";
    }
    return _queryNumber;
}

- (CCPrintModel *)termSheet {
    if (_termSheet == nil) {
        _termSheet = [[CCPrintModel alloc] init];
        _termSheet.attach = @"运输协议：";
    }
    return _termSheet;
}

- (CCPrintModel *)orderCreator {
    if (_orderCreator == nil) {
        _orderCreator = [[CCPrintModel alloc] init];
        _orderCreator.attach = @"开单员：";
    }
    return _orderCreator;
}

- (CCPrintModel *)orderCreatorPhone {
    if (_orderCreatorPhone == nil) {
        _orderCreatorPhone = [[CCPrintModel alloc] init];
        _orderCreatorPhone.attach = @"开单员手机号：";
    }
    return _orderCreatorPhone;
}

- (CCPrintModel *)accountsReceivable {
    if (_accountsReceivable == nil) {
        _accountsReceivable = [[CCPrintModel alloc] init];
        _accountsReceivable.attach = @"应收款：";
    }
    return _accountsReceivable;
}

- (CCPrintModel *)srcArea {
    if (_srcArea == nil) {
        _srcArea = [[CCPrintModel alloc] init];
        _srcArea.attach = @"发站区域：";
    }
    return _srcArea;
}

- (CCPrintModel *)desArea {
    if (_desArea == nil) {
        _desArea = [[CCPrintModel alloc] init];
        _desArea.attach = @"到站区域：";
    }
    return _desArea;
}

- (CCPrintModel *)sign {
    if (_sign == nil) {
        _sign = [[CCPrintModel alloc] init];
        _sign.attach = @"发货人签字：";
    }
    return _sign;
}

- (CCPrintModel *)signDate {
    if (_signDate == nil) {
        _signDate = [[CCPrintModel alloc] init];
        _signDate.attach = @"签收日期：";
    }
    return _signDate;
}

- (void)setDefaultContent {
    // 公司名
    setPrintContent(@"测试公司", self.companyName);
    // 运单号
    setPrintContent(@"123456789", self.orderNumber);
    // 开单日期
    setPrintContent(@"2017-12-31 12:34:32", self.billingDate);
    // 发站
    setPrintContent(@"北京", self.srcCity);
    // 发站电话
    setPrintContent(@"110", self.srcTel);
    // 发站地址
    setPrintContent(@"国贸", self.srcAddress);
    // 到站
    setPrintContent(@"武汉", self.desCity);
    // 到站电话
    setPrintContent(@"119", self.desTel);
    // 到站地址
    setPrintContent(@"江滩", self.desAddress);
    // 目的网点
    setPrintContent(@"江滩网点", self.arrPoint);
    // 货物件数
    setPrintContent(@"1", self.goodsNumber);
    // 货物名称
    setPrintContent(@"苹果", self.goodsName);
    // 货物重量
    setPrintContent(@"1", self.goodsWeight);
    // 货物体积
    setPrintContent(@"1", self.goodsVolume);
    // 货号
    setPrintContent(@"11102", self.goodsSerialNo);
    // 运费
    setPrintContent(@"1", self.freightPrice);
    // 发货人
    setPrintContent(@"测试", self.consignor);
    // 发货人电话
    setPrintContent(@"12345", self.consignorTel);
    // 收货人
    setPrintContent(@"测试2", self.consignee);
    // 收货人电话
    setPrintContent(@"12345", self.consigneeTel);
    // 开单员
    setPrintContent(@"千叶", self.orderCreator);
    // 开单员电话
    setPrintContent(@"114", self.orderCreatorPhone);
    // 目的网点代号
    setPrintContent(@"JTWD", self.arrPointCode);
    // 查单号
    setPrintContent(@"123456789", self.queryNumber);
    // 送货方式
    setPrintContent(@"整车直送", self.consigneeMode);
    // 代收货款
    setPrintContent(@"1", self.collectionOnDelivery);
    // 应收款
    setPrintContent(@"1", self.accountsReceivable);
    // 送货费
    setPrintContent(@"1", self.deliveryFreight);
    // 备注
    setPrintContent(@"轻放", self.remark);
    // 二维码
    setPrintContent(@"http://blog.qianyenote.com/", self.qRCode);
    
    // 现付
    setPrintContent(@"1", self.payBilling);
    // 到付
    setPrintContent(@"1", self.payArrival);
    
    // 运输协议
    setPrintContent(@"", self.termSheet);
}

@end
