//
//  CCAttributesMaker.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCAttribute.h"

@interface CCAttributeMaker : NSObject

@property (nonatomic, assign) BOOL updateExisting;
@property (nonatomic, assign) BOOL useExisting;
@property (nonatomic, assign) BOOL autoExisting;

@property (nonatomic, strong) CCAttribute *font;
@property (nonatomic, strong) CCAttribute *bold;
@property (nonatomic, strong) CCAttribute *align;
@property (nonatomic, strong) CCAttribute *position;
@property (nonatomic, strong) CCAttribute *size;
@property (nonatomic, strong) CCAttribute *rect;
@property (nonatomic, strong) CCAttribute *vertical;
@property (nonatomic, strong) CCAttribute *marginY;
@property (nonatomic, strong) CCAttribute *hasNewLine;


- (NSArray *)install;

@end

typedef void(^CCAttributeConfigBlock)(CCAttributeMaker *maker);
