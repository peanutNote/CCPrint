//
//  CCPrinterConnectController.m
//  CMM
//
//  Created by qianye on 2017/8/14.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrinterConnectController.h"
#import "CCPrinterConnectListController.h"
#import "CCPrintAdvancedSettingController.h"
#import "CCprinterNameManagerController.h"

#import "CCPrintDefine.h"
#import "CCPrintManager.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface CCPrinterConnectController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation CCPrinterConnectController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"打印管理";
    [self ccInitViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Private Method

- (void)ccInitViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 70, 40);
    [rightBtn setTitle:@"高级设置" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

#pragma mark - Action

- (void)rightAction:(UIButton *)sender {
    CCPrintAdvancedSettingController *vc = [[CCPrintAdvancedSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)disConnectAction:(UIButton *)sender {
    /*
    MMAlertView *alerView = [[MMAlertView alloc] initWithTitle:@"提示" message:@"是否断开所有设备" delegate:nil alertType:MMAlertViewTypeTitleImage buttonStyle:MMAlertViewButtonDefault buttonTitles:@"取消", @"确定", nil];
    [alerView showMMAlertView:YES alertBlock:^BOOL(NSInteger index) {
        if (index == 1) {
            CCPrinterConnectListController *vc = [CCPrinterConnectListController sharePrinterConnectListController];
            [vc cancelAllPeripheralsConnection];
            [_tableView reloadData];
        }
        return YES;
    }];
     */
    CCPrinterConnectListController *vc = [CCPrinterConnectListController sharePrinterConnectListController];
    [vc cancelAllPeripheralsConnection];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"运单打印";
            cell.detailTextLabel.text = [printManager.printerBrandManager getPeripheralNameWithConnectType:CCPrinterConnectPurposeOrder];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"标签打印";
            cell.detailTextLabel.text = [printManager.printerBrandManager getPeripheralNameWithConnectType:CCPrinterConnectPurposeLabel];
        } else {
            cell.textLabel.text = @"提货打印";
            cell.detailTextLabel.text = [printManager.printerBrandManager getPeripheralNameWithConnectType:CCPrinterConnectPurposeDelivery];
        }
    } else {
        cell.textLabel.text = @"蓝牙打印机命名管理";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CCPrinterConnectListController *vc = [CCPrinterConnectListController sharePrinterConnectListController];
        if (indexPath.row == 0) {
            vc.connectPurposeType = CCPrinterConnectPurposeOrder;
            vc.title = @"运单打印";
        } else if (indexPath.row == 1) {
            vc.connectPurposeType = CCPrinterConnectPurposeLabel;
            vc.title = @"标签打印";
        } else {
            vc.connectPurposeType = CCPrinterConnectPurposeDelivery;
            vc.title = @"提货打印";
        }
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CCprinterNameManagerController *vc = [[CCprinterNameManagerController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 45;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.textColor = [UIColor lightGrayColor];
    [headerView addSubview:titleLab];
    if (section == 0) {
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 45);
        titleLab.frame = CGRectMake(15, 0, kScreenWidth - 140, 45);
        titleLab.text = @"选择打印机";
        
        UIButton *disConnect = [UIButton buttonWithType:UIButtonTypeCustom];
        disConnect.frame = CGRectMake(kScreenWidth - 125, 8, 110, 29);
        disConnect.backgroundColor = [UIColor whiteColor];
        disConnect.layer.cornerRadius = 4.0;
        disConnect.layer.borderColor = [UIColor grayColor].CGColor;
        disConnect.layer.borderWidth = .5;
        [disConnect setTitle:@"" forState:UIControlStateNormal];
        [disConnect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        disConnect.titleLabel.font = [UIFont systemFontOfSize:14];
        [disConnect addTarget:self action:@selector(disConnectAction:) forControlEvents:UIControlEventTouchUpInside];
        [disConnect setTitle:@"断开所有打印机" forState:UIControlStateNormal];
        [headerView addSubview:disConnect];
    } else {
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 30);
        titleLab.frame = CGRectMake(15, 0, kScreenWidth - 30, 30);
        titleLab.text = @"管理蓝牙打印机，个性化命名操作";
    }
    return headerView;
}

#pragma mark - Getter & Setter


@end

