//
//  CCAttribute+Private.h
//  QYBluetoothManager
//
//  Created by qianye on 2017/7/10.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CCAttribute.h"
#import "CCPrintDefine.h"

@protocol CCAttributeDelegate;

@interface CCAttribute ()

@property (nonatomic, assign) BOOL updateExisting;
@property (nonatomic, assign) BOOL useExisting;
@property (nonatomic, assign) BOOL autoExisting;

@property (nonatomic, weak) id<CCAttributeDelegate> delegate;

- (void)setPrintAttributeWithValue:(NSValue *)value;

@end

@interface CCAttribute (Abstract)

- (CCAttribute * (^)(id))valueOfAttribute;

- (CCAttribute *)addAttributeWithAttributeType:(CCPrintAttributeType __unused)attributeType;

@end

@protocol CCAttributeDelegate <NSObject>

- (void)attribute:(CCAttribute *)attribute shouldBeReplacedWithAttribute:(CCAttribute *)replacementAttribute;

- (__kindof CCAttribute *)attribute:(CCAttribute *)attribute addAttributeWithAttributeType:(CCPrintAttributeType)attributeType;

@end
