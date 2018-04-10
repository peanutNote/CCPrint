//
//  CCPrinterConnectListController.h
//  CMM
//
//  Created by qianye on 2017/9/27.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import <UIKit/UIViewController.h>
#import "CCPrintDefine.h"

@interface CCPrinterConnectListController : UIViewController

@property (nonatomic, assign) CCPrinterConnectPurposeType connectPurposeType;

+ (CCPrinterConnectListController *)sharePrinterConnectListController;
//断开所有已连接的设备
- (void)cancelAllPeripheralsConnection;

@end
