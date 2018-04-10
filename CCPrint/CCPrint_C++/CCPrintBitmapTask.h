//
//  CCPrintBitmapTask.h
//  CMM
//
//  Created by qianye on 2018/2/1.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPrintBitmapTask : NSObject

+ (uint8_t *)printBitmapTaskOfText:(NSString *)text width:(uint32_t)width height:(uint32_t)height font:(NSInteger)font;

+ (uint8_t *)printBitmapTaskOfLine:(uint32_t)width height:(uint32_t)height;

+ (uint8_t *)printBitmapTaskOfBarCode:(uint32_t)width height:(uint32_t)height;

+ (uint8_t *)printBitmapTaskOfQrCode:(uint32_t)width height:(uint32_t)height;

@end
