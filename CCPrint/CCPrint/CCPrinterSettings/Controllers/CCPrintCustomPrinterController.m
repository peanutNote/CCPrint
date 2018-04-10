//
//  CCPrintCustomPrinterController.m
//  CMM
//
//  Created by qianye on 2017/10/11.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrintCustomPrinterController.h"

#import <Masonry.h>
#import <SVProgressHUD.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CCPrintManager.h"
#import "CCPrintUtilities.h"
#import "CCPeripheral.h"
#import "CCPrintTaskTest.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface CCPrintCustomPrinterController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *step1TableView;
@property (nonatomic, copy) NSArray *step1DataList;
@property (nonatomic, weak) UITableView *step2TableView;
@property (nonatomic, strong) CCPeripheral *selectedPeripheral;
@property (nonatomic, assign) NSInteger currentChooseMode;
@property (nonatomic, weak) UIView *footerView;

@end

@implementation CCPrintCustomPrinterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义蓝牙打印机";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 获取已经连接的打印机
    CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
    self.step1DataList = [printManager.printerBrandManager getPeripheralWithConnectType:CCPrinterConnectPurposeAll];
    if (self.step1DataList.count == 0) {
        /*
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:nil message:@"当前无已连接蓝牙打印机，请连接打印机后再设置！" delegate:nil alertType:MMAlertViewTypeTitleImage buttonStyle:MMAlertViewButtonDefault buttonTitles:@"我知道了", nil];
        [alertView showMMAlertView:YES alertBlock:^BOOL(NSInteger index) {
            [self.navigationController popViewControllerAnimated:YES];
            return YES;
        }];
         */
    } else {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        self.step1TableView = tableView;
        
        UITableView *tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView2.delegate = self;
        tableView2.dataSource = self;
        tableView2.alpha = 0.0;
        [self.view addSubview:tableView2];
        [tableView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-55);
        }];
        self.step2TableView = tableView2;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.layer.borderColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:221.0/255.0].CGColor;
        footerView.layer.borderWidth = .5;
        footerView.layer.shadowColor = [UIColor blackColor].CGColor;
        footerView.layer.shadowOpacity = 0.1f;
        footerView.layer.shadowOffset = CGSizeMake(0, -3);
        footerView.alpha = 0.0;
        [self.view addSubview:footerView];
        [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(55);
            make.bottom.equalTo(self.view);
        }];
        self.footerView = footerView;
        
        CGFloat buttonWidth = (kScreenWidth - 45) / 2.0;
        for (int i = 0; i < 2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15 + i * (15 + buttonWidth), 7.5, buttonWidth, 40);
            button.tag = i;
            button.layer.cornerRadius = 4.0f;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            if (i == 0) {
                button.layer.borderWidth = .5f;
                button.layer.borderColor = [UIColor orangeColor].CGColor;
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [button setTitle:@"取消退出" forState:UIControlStateNormal];
            } else {
                button.backgroundColor = [UIColor orangeColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitle:@"保存配置" forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(footerAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.footerView addSubview:button];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    // 清除指定打印设备
    [CCPrintManager sharePrinterManager].printerBrandManager.appointedPeripheral = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _step1TableView) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _step1TableView) {
        if (section == 1) {
            return _step1DataList.count;
        } else {
            return 1;
        }
    } else {
        if (section == 2) {
            return 4;
        } else {
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
            make.top.equalTo(cell.contentView).offset(8);
            make.height.mas_equalTo(14);
        }];
        UIImageView *spaceLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"print_img_stepLine"]];
        [cell.contentView addSubview:spaceLine];
        [spaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView);
            make.top.equalTo(label.mas_bottom).offset(9);
        }];
        UIImageView *currentStep1 = [[UIImageView alloc] init];
        [cell.contentView addSubview:currentStep1];
        [currentStep1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(spaceLine.mas_left).offset(-20);
            make.centerY.equalTo(spaceLine);
        }];
        UIImageView *currentStep2 = [[UIImageView alloc] init];
        [cell.contentView addSubview:currentStep2];
        [currentStep2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(spaceLine.mas_right).offset(20);
            make.centerY.equalTo(spaceLine);
        }];
        if (tableView == _step1TableView) {
            label.text = @"第1步/共2步";
            currentStep1.image = [UIImage imageNamed:@"print_img_currentStep"];
            currentStep2.image = [UIImage imageNamed:@"print_img_nullStep"];
        } else {
            label.text = @"第2步/共2步";
            currentStep1.image = [UIImage imageNamed:@"print_img_doneStep"];
            currentStep2.image = [UIImage imageNamed:@"print_img_currentStep"];
        }
    } else {
        if (tableView == _step1TableView) {
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            if (indexPath.section == 1) {
                CCPeripheral *peripheral = _step1DataList[indexPath.row];
                cell.textLabel.text = peripheral.rename.length ? [NSString stringWithFormat:@"%@(%@)", peripheral.originName, peripheral.rename] : peripheral.originName;
                cell.detailTextLabel.text = peripheral.identifier;
                
                UIButton *configButton = [UIButton buttonWithType:UIButtonTypeCustom];
                configButton.tag = indexPath.row;
                configButton.frame = CGRectMake(0, 0, 75, 30);
                configButton.layer.cornerRadius = 4.0f;
                configButton.layer.borderWidth = .5f;
                configButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
                configButton.titleLabel.font = [UIFont systemFontOfSize:14];
                [configButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [configButton setTitle:@"配置" forState:UIControlStateNormal];
                [configButton addTarget:self action:@selector(configButton:) forControlEvents:UIControlEventTouchUpInside];
                cell.accessoryView = configButton;
            }
            
        } else {
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            if (indexPath.section == 1) {
                cell.textLabel.text = _selectedPeripheral.rename.length ? [NSString stringWithFormat:@"%@(%@)", _selectedPeripheral.originName, _selectedPeripheral.rename] : _selectedPeripheral.originName;
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.detailTextLabel.text = _selectedPeripheral.identifier;
            } else {
                cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"模式一（推荐）";
                    cell.detailTextLabel.text = @"-通用热敏小票打印机";
                } else if (indexPath.row == 1) {
                    cell.textLabel.text = @"模式二";
                    cell.detailTextLabel.text = @"-通用热敏小票打印机（支持二维码）";
                } else if (indexPath.row == 2) {
                    cell.textLabel.text = @"模式三";
                    cell.detailTextLabel.text = @"-芝柯、车满满定制条码打印机";
                } else if (indexPath.row == 3) {
                    cell.textLabel.text = @"模式四";
                    cell.detailTextLabel.text = @"-XPrinter等条码打印机";
                }
                if (_currentChooseMode - 1 == indexPath.row) {
                    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singleSelection_on"]];
                } else {
                    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singleSelection_off"]];
                }
                UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                textBtn.tag = indexPath.row;
                textBtn.layer.cornerRadius = 4.0f;
                textBtn.layer.borderWidth = .5f;
                textBtn.layer.borderColor = [UIColor orangeColor].CGColor;
                textBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [textBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [textBtn setImage:[UIImage imageNamed:@"print_btn_printerIcon"] forState:UIControlStateNormal];
                [textBtn setTitle:@" 测试" forState:UIControlStateNormal];
                [textBtn addTarget:self action:@selector(textAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:textBtn];
                [textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(cell.detailTextLabel.mas_top);
                    make.left.equalTo(cell.textLabel.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake(75, 30));
                }];
            }
        }
    }
    return cell;
}

#pragma mark - Action

- (void)configButton:(UIButton *)sender {
    _selectedPeripheral = [_step1DataList objectAtIndex:sender.tag];
    
    _currentChooseMode = [_selectedPeripheral.customModel integerValue];
    [_step2TableView reloadData];
    [UIView animateWithDuration:.35 animations:^{
        _step1TableView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.35 animations:^{
            _step2TableView.alpha = _footerView.alpha = 1.0;
        }];
    }];
}

- (void)textAction:(UIButton *)sender {
    CCPrintTaskTest *printTest = [[CCPrintTaskTest alloc] init];
    /*
    // 打印测试
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:nil message:@"如打印内容同如下预览图，表示您可以选用该模式" delegate:nil alertType:MMAlertViewTypeImageCustomVeiw buttonStyle:MMAlertViewButtonDefault buttonTitles:@"取消", @"确定", nil];
    [alertView setMessageAlignment:NSTextAlignmentLeft];
    CGFloat alerViewWidth = [CCUIUtility screenWidth] * 0.84 - (15 * 0.84) * 2;
    MMAlertCustomView *customView = [[MMAlertCustomView alloc] initWithFrame:CGRectMake(0, 0, alerViewWidth, (alerViewWidth * 400.0 / 575.0) + 40)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, alerViewWidth, (alerViewWidth * 400.0 / 575.0))];
    [customView addSubview:imageView];
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (alerViewWidth * 400.0 / 575.0), alerViewWidth, 40)];
    footerLabel.font = [UIFont CCFont14];
    footerLabel.numberOfLines = 0;
    footerLabel.textColor = [UIColor CCColor333333];
    footerLabel.text = @"请确保打印机中存放80mm宽的热敏打印纸";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [customView addSubview:footerLabel];
    
    alertView.customView = customView;
    NSInteger selectedIndex = sender.tag + 1;
    if (sender.tag == 0) {
        imageView.image = [UIImage imageNamed:@"print_img_model1"];
        [printTest printWithTestModel:CCPrintTestModelOne appointedPeripheral:_selectedPeripheral];
        [CCPrintManager sharePrinterManager].printerBrandManager.appointedPeripheral = _selectedPeripheral;
    } else if (sender.tag == 1) {
        imageView.image = [UIImage imageNamed:@"print_img_model2"];
        [printTest printWithTestModel:CCPrintTestModelTwo appointedPeripheral:_selectedPeripheral];
    } else if (sender.tag == 2) {
        imageView.image = [UIImage imageNamed:@"print_img_model3"];
        [printTest printWithTestModel:CCPrintTestModelThree appointedPeripheral:_selectedPeripheral];
    } else if (sender.tag == 3) {
        imageView.image = [UIImage imageNamed:@"print_img_model3"];
        [printTest printWithTestModel:CCPrintTestModelFour appointedPeripheral:_selectedPeripheral];
    }
    [alertView showMMAlertView:YES alertBlock:^BOOL(NSInteger index) {
        if (index == 1) {
            _currentChooseMode = selectedIndex;
            [_step2TableView reloadData];
        }
        return YES;
    }];
     */
}

- (void)footerAction:(UIButton *)sender {
    if (sender.tag == 0) {
        // 取消退出
        [UIView animateWithDuration:.35 animations:^{
            _step2TableView.alpha = _footerView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.35 animations:^{
                _step1TableView.alpha = 1.0;
            }];
        }];
    } else {
        _selectedPeripheral.customModel = @(_currentChooseMode);
        // 更新打印配置
        [_selectedPeripheral updateBrandType];
        // 保存配置
        [CCPrintUtilities savePeripheral:_selectedPeripheral];
        [SVProgressHUD showSuccessWithStatus:@"配置保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _step1TableView) {
        if (indexPath.section == 0) {
            return 45.0;
        }
        return 60.0;
    } else {
        if (indexPath.section == 0) {
            return 45.0;
        } else if (indexPath.section == 1) {
            return 60.0;
        }
        return 70.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _step2TableView && indexPath.section == 2) {
        if (_currentChooseMode == indexPath.row + 1) {
            _currentChooseMode = 0;
        } else {
            _currentChooseMode = indexPath.row + 1;
        }
        [_step2TableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _step1TableView) {
        if (section == 1) {
            return @"从下列已连接的蓝牙打印机中选择";
        }
    } else {
        if (section == 1) {
            return @"打印机信息";
        } else if (section == 2) {
            return @"打印模式设置";
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0;
    }
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
