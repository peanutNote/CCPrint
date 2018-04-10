//
//  CCprinterNameManagerController.m
//  CMM
//
//  Created by qianye on 2017/9/27.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCprinterNameManagerController.h"
#import "CCPeripheral.h"
#import "CCPrintUtilities.h"
#import "CCModelDefine.h"
#import <SVProgressHUD.h>

@interface CCprinterNameManagerController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataList;

@end

@implementation CCprinterNameManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蓝牙打印机命名管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataList = [CCPrintUtilities getLocalCachePeripherals];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - Action

- (void)renameAction:(UIButton *)sender {
    CCPeripheral *peripheral = _dataList[sender.tag];
    /*
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:nil message:nil delegate:nil alertType:MMAlertViewTypeImageCustomVeiw buttonStyle:MMAlertViewButtonDefault buttonTitles:@"取消", @"确定", nil];
    CGFloat alerViewWidth = self.view.bounds.size.width * 0.84 - (15 * 0.84) * 2;
    MMAlertCustomView *customView = [[MMAlertCustomView alloc] initWithFrame:CGRectMake(0, 0, alerViewWidth, 40)];
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, alerViewWidth, 40)];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.font = [UIFont systemFontOfSize:16];
    nameField.text = CheckString(peripheral.rename, YES, peripheral.originName);
    [customView addSubview:nameField];
    alertView.customView = customView;
    __weak typeof(self) weakSelf = self;
    [alertView showMMAlertView:YES alertBlock:^BOOL(NSInteger index) {
        if (index == 1) {
            if (nameField.text.length > 0) {
                BOOL isShowAlert = NO;
                NSString *subString = @"";
                if ([nameField.text.uppercaseString hasSuffix:@"__MP_E"]) {
                    isShowAlert = YES;
                    subString = [NSString stringWithFormat:@"您重命名的名称包含%@后缀，是否指定该打印机使用ESC指令控制？", [nameField.text substringFromIndex:nameField.text.length - 6]];
                }
                if ([nameField.text.uppercaseString hasSuffix:@"__MP_EQ"]) {
                    isShowAlert = YES;
                    subString = [NSString stringWithFormat:@"您重命名的名称包含%@后缀，是否指定该打印机使用ESC指令控制？", [nameField.text substringFromIndex:nameField.text.length - 7]];
                }
                if ([nameField.text.uppercaseString hasSuffix:@"__MP_T"] || [nameField.text hasSuffix:@"__GP_T"]) {
                    isShowAlert = YES;
                    subString = [NSString stringWithFormat:@"您重命名的名称包含%@后缀，是否指定该打印机使用TSC指令控制？", [nameField.text substringFromIndex:nameField.text.length - 6]];
                }
                if ([nameField.text.uppercaseString hasSuffix:@"__MP_Z"] || [nameField.text hasSuffix:@"_HP_C"]) {
                    isShowAlert = YES;
                    subString = [NSString stringWithFormat:@"您重命名的名称包含%@后缀，是否指定该打印机使用CPCL指令控制？", [nameField.text substringFromIndex:nameField.text.length - 6]];
                }
                if (isShowAlert) {
                    MMAlertView *tipAlert = [[MMAlertView alloc] initWithTitle:@"提示" message:subString delegate:nil alertType:MMAlertViewTypeTitleImage buttonStyle:MMAlertViewButtonDefault buttonTitles:@"取消", @"确认继续", nil];
                    [tipAlert showMMAlertView:YES alertBlock:^BOOL(NSInteger index) {
                        if (index == 1) {
                            peripheral.rename = nameField.text;
                            [CCPrintUtilities savePeripheral:peripheral];
                            [weakSelf.tableView reloadData];
                            [SVProgressHUD showSuccessWithStatus:@"重命名打印机成功"];
                        }
                        return YES;
                    }];
                } else {
                    peripheral.rename = nameField.text;
                    [CCPrintUtilities savePeripheral:peripheral];
                    [weakSelf.tableView reloadData];
                    [SVProgressHUD showSuccessWithStatus:@"重命名打印机成功"];
                }
            }
        }
        return YES;
    }];
     */
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    CCPeripheral *peripheral = [_dataList objectAtIndex:indexPath.row];
    cell.textLabel.text = peripheral.rename.length ? peripheral.rename : peripheral.originName;
    UIButton *renameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    renameBtn.tag = indexPath.row;
    renameBtn.frame = CGRectMake(0, 0, 75, 30);
    renameBtn.layer.cornerRadius = 4.0f;
    renameBtn.layer.borderWidth = .5f;
    renameBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    renameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [renameBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [renameBtn setTitle:@"重命名" forState:UIControlStateNormal];
    [renameBtn addTarget:self action:@selector(renameAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = renameBtn;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"蓝牙打印机";
}

@end
