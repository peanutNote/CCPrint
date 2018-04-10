//
//  CCPrinterConnectListCell.m
//  CMM
//
//  Created by qianye on 2017/10/10.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrinterConnectListCell.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CCPrintUtilities.h"
#import "CCPeripheral.h"
#import "CCModelDefine.h"

@implementation CCPrinterConnectListCell {
    UILabel *_nameLabel;
    UIButton *_statusButton;
    UIButton *_renameButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusButton.frame = CGRectMake(0, 0, 75, 30);
        _statusButton.layer.cornerRadius = 4.0f;
        _statusButton.layer.borderWidth = 1.0f;
        _statusButton.layer.borderColor = [[UIColor orangeColor] CGColor];
        _statusButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_statusButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_statusButton addTarget:self action:@selector(statusChange:) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView = _statusButton;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_peripheral) {
        self.textLabel.text = @"未发现可连接打印机";
        _statusButton.hidden = YES;
    } else {
        NSString *nameString = @"未知设备";
        nameString = CheckString(_peripheral.rename, YES, _peripheral.originName);
        self.textLabel.text = nameString;
        self.detailTextLabel.text = _peripheral.identifier;
        _statusButton.hidden = NO;
        
        if (_peripheral.connectState == CCPrinterPeripheralConnected) {
            [_statusButton setTitle:@"断开连接" forState:UIControlStateNormal];
        } else if (_peripheral.connectState == CCPrinterPeripheralUnconnect) {
            [_statusButton setTitle:@"点击连接" forState:UIControlStateNormal];
        } else if (_peripheral.connectState == CCPrinterPeripheralConnecting) {
            [_statusButton setTitle:@"正在连接..." forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Action

- (void)statusChange:(UIButton *)sneder {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickConnectActionWithIndexPath:)]) {
        [_delegate didClickConnectActionWithIndexPath:_indexPath];
    }
}

@end
