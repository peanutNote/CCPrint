//
//  CCAttribute.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCAttribute : NSObject

- (CCAttribute *)font;
- (CCAttribute *)bold;
- (CCAttribute *)align;
- (CCAttribute *)vertical;
- (CCAttribute *)position;
- (CCAttribute *)size;
- (CCAttribute *)rect;
- (CCAttribute *)marginY;
- (CCAttribute *)hasNewLine;

- (CCAttribute *(^)(id))value;
- (CCAttribute * (^)(CGFloat printValue))valuePrint;
- (CCAttribute * (^)(CGPoint position))valuePosition;
- (CCAttribute * (^)(CGSize size))valueSize;
- (CCAttribute * (^)(CGRect rect))valueRect;

- (void)setValuePrint:(CGFloat __unused)valuePrint;
- (void)setValuePosition:(CGPoint __unused)valuePosition;
- (void)setValueSize:(CGSize __unused)valueSize;
- (void)setValueRect:(CGRect __unused)valueRect;

/// 将代码转化为指令保存
- (void)install;

@end

#define value(...)                 value(CCBoxValue((__VA_ARGS__)))
