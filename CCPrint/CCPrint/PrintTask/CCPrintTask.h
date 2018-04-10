//
//  CCPrintTask.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/13.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPrintField.h"

@interface CCPrintTask : NSObject

- (void)printWithField:(CCPrintField *)printField;

@end
