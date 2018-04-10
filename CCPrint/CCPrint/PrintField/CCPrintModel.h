//
//  CCPrintModel.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/20.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPrintDefine.h"

@interface CCPrintModel : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *attach;

@property (nonatomic, copy) NSString *attachContent;

@property (nonatomic, assign) BOOL isBold;

@property (nonatomic, assign) BOOL isEmphatic;

@property (nonatomic, assign) CCPrintFontSize printFontSize;

@end
