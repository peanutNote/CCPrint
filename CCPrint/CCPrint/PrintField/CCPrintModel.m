//
//  CCPrintModel.m
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/20.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCPrintModel.h"

@implementation CCPrintModel

- (instancetype)init {
    if (self = [super init]) {
        _content = @"";
        _attach = @"";
        _attachContent = @"";
        _isBold = NO;
        _isEmphatic = NO;
    }
    return self;
}

- (NSString *)content {
    if ([_content isKindOfClass:NSString.class]) {
        return _content;
    }
    return @"";
}

- (CCPrintFontSize)printFontSize {
    if (_isEmphatic) {
        return CCPrintFontSizeXXX;
    }
    return CCPrintFontSizeL;
}

@end
