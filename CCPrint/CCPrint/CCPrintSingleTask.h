//
//  CCPrintSingleTask.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/11.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPrintDefine.h"

@interface CCPrintSingleTask : NSObject

- (instancetype)initWithContent:(NSString *)content taskType:(CCPrintTaskType)taskType instructionType:(CCPrintInstructionType)instructionType;

@property (nonatomic) NSString *content;

@property (nonatomic, readonly) CCPrintTaskType tashType;

@property (nonatomic) CCFont font;

@property (nonatomic) CCBlod blod;

@property (nonatomic) CCAlign align;

@property (nonatomic) CCVertical vertical;

@property (nonatomic) CCMarginY marginY;

@property (nonatomic) BOOL hasNewLine;

@property (nonatomic) CGFloat x;

@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

- (CGSize)getCurrentPrintHeight;

- (void)setCCFont:(CCPrintFontSize)font;
- (void)setCCBlod:(BOOL)blod;
- (void)setCCAlign:(CCPrintAlignType)align;
- (void)setCCVertical:(BOOL)vertical;
- (void)setCCMarginY:(CGFloat)marginY;

@end
