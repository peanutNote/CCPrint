//
//  CCPrintTaskTest.h
//  CMM
//
//  Created by qianye on 2017/10/12.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrintTask.h"
@class CCPeripheral;

typedef NS_ENUM(NSInteger, CCPrintTestModelType) {
    CCPrintTestModelOne,
    CCPrintTestModelTwo,
    CCPrintTestModelThree,
    CCPrintTestModelFour
};

@interface CCPrintTaskTest : CCPrintTask

- (void)printWithTestModel:(CCPrintTestModelType)testModel appointedPeripheral:(CCPeripheral *)appointedPeripheral;

@end
