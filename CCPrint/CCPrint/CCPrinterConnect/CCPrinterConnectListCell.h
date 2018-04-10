//
//  CCPrinterConnectListCell.h
//  CMM
//
//  Created by qianye on 2017/10/10.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCPeripheral;

@protocol CCPrinterConnectListCellDelegate <NSObject>

- (void)didClickConnectActionWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface CCPrinterConnectListCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<CCPrinterConnectListCellDelegate> delegate;

@property (nonatomic, strong) CCPeripheral *peripheral;

@end
