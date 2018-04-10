//
//  CCPrintAttribute.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCAttribute.h"
#import "CCPrintDefine.h"

@interface CCPrintAttribute : CCAttribute <NSCopying>

- (instancetype)initWithPrintTashType:(CCPrintAttributeType)attributeType;

@end
