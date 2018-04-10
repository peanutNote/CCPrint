//
//  CCPrinterConnectListController.m
//  CMM
//
//  Created by qianye on 2017/9/27.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CCPrinterConnectListController.h"
#import "CCPrinterConnectManager.h"

#import "CCPrinterConnectListCell.h"
#import "CCPeripheral.h"
#import "GCDAsyncSocket.h"
//#import "MMAlertView.h"

@interface CCPrinterConnectListController ()<UITableViewDelegate, UITableViewDataSource, CCPrinterConnectListCellDelegate, CCPrinterConnectManagerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) CCPrinterConnectManager *connectManager;
@property (nonatomic, strong) NSArray *currentPeripherals;
@property (nonatomic, assign) CCPrinterConnectType connectType;
@property (nonatomic, strong) UIButton *BluetoothConnect;
@property (nonatomic, strong) UIButton *wifiConnect;

@end

static CCPrinterConnectListController *printerConnectListController;

@implementation CCPrinterConnectListController

+ (CCPrinterConnectListController *)sharePrinterConnectListController
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        printerConnectListController = [[CCPrinterConnectListController alloc] init];
    });
    return printerConnectListController;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        printerConnectListController = [super allocWithZone:zone];
    });
    return printerConnectListController;
    
}

#pragma mark - View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化连接管理对象
    _connectManager = [[CCPrinterConnectManager alloc] init];
    _connectManager.delegate = self;
    // 第一次进来默认为蓝牙连接方式
    _connectType = CCPrinterConnectBluetooth;
    
    UILabel *segmentLabel = [[UILabel alloc] init];
    segmentLabel.text = @"选择打印机类型";
    segmentLabel.font = [UIFont systemFontOfSize:14];
    segmentLabel.frame = CGRectMake(15, 0, 80, 30);
    [self.view addSubview:segmentLabel];
    
    UIView *segmentView = [[UIView alloc] init];
    segmentView.backgroundColor = [UIColor whiteColor];
    segmentView.frame = CGRectMake(0, 30, self.view.bounds.size.width, 68);
    [self.view addSubview:segmentView];
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"circle_img_selectDefault"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"circle_img_circleChoose"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(connectAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [segmentView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _BluetoothConnect = button;
        } else {
            _wifiConnect = button;
        }
    }
    [_BluetoothConnect setTitle:@" 蓝牙打印机" forState:UIControlStateNormal];
    _BluetoothConnect.frame = CGRectMake(15, 0, 100, 16);
    [_wifiConnect setTitle:@" WiFi针式" forState:UIControlStateNormal];
    _wifiConnect.frame = CGRectMake(115, 0, 100, 16);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.frame = CGRectMake(0, 98, self.view.frame.size.width, self.view.frame.size.height - 98);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.rowHeight = 68;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_connectManager setCurrentPurposeType:_connectPurposeType connectType:_connectType];
    
    [self connectAction:_BluetoothConnect];
    if (_connectPurposeType == CCPrinterConnectPurposeOrder) {
        _BluetoothConnect.hidden = NO;
        _wifiConnect.hidden = NO;
    } else if (_connectPurposeType == CCPrinterConnectPurposeLabel) {
        _BluetoothConnect.hidden = NO;
        _wifiConnect.hidden = YES;
    } else if (_connectPurposeType == CCPrinterConnectPurposeDelivery) {
        _BluetoothConnect.hidden = NO;
        _wifiConnect.hidden = YES;
    }
    [self reloadTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_connectManager startScanPeripherals];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_connectManager stopScanPeripherals];
    _connectPurposeType = CCPrinterConnectPurposeAll;
}

- (void)reloadTableView {
    self.currentPeripherals = [self.connectManager getCurrentPeripherals];
    [self.tableView reloadData];
}

#pragma mark - Public Method

- (void)cancelAllPeripheralsConnection {
    [_connectManager disconnectAllPeripheralsConnection];
}

#pragma mark - Action

- (void)connectAction:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        if (sender == _BluetoothConnect) {
            _wifiConnect.selected = NO;
            _connectType = CCPrinterConnectBluetooth;
            [_connectManager setCurrentPurposeType:_connectPurposeType connectType:_connectType];
        } else {
            _BluetoothConnect.selected = NO;
            _connectType = CCPrinterConnectWiFi;
            [_connectManager setCurrentPurposeType:_connectPurposeType connectType:_connectType];
        }
        [self reloadTableView];
    }
}

#pragma mark Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _currentPeripherals.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"蓝牙设备";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCPrinterConnectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderSettingCell"];
    if (cell == nil) {
        cell = [[CCPrinterConnectListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"orderSettingCell"];
        cell.delegate = self;
    }
    CCPeripheral *peripheral = _currentPeripherals[indexPath.row];
    cell.peripheral = peripheral;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - CCPrinterConnectListCellDelegate

- (void)didClickConnectActionWithIndexPath:(NSIndexPath *)indexPath {
    CCPeripheral *peripheral = _currentPeripherals[indexPath.row];
    if (peripheral.peripheralType == CCPrinterPeripheralWifi) {
        if (peripheral.socket.isConnected) {
            [_connectManager disconnectToPeripheral:peripheral];
        } else {
            [_connectManager connectToPeripheral:peripheral];
        }
    } else {
        if (peripheral.per.state == CBPeripheralStateConnected) {
            [_connectManager disconnectToPeripheral:peripheral];
        } else {
            if ([peripheral.originName isEqualToString:@"Printer001"]) {
                /*
                MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"打印机型号" message:@"机身山查看打印机型号" delegate:nil alertType:MMAlertViewTypeTitleImage buttonStyle:MMAlertViewButtonDefault buttonTitles:@"XP-370B(条码)", @"XP-Q200(小票)", nil];
                alertView.selectedIndex = NSNotFound;
                [alertView showMMAlertView:YES alertBlock:^BOOL(NSInteger index) {
                    if (index == 1) {
                        peripheral.isPrinterQ200 = YES;
                    }
                    [_connectManager connectToPeripheral:peripheral];
                    return YES;
                }];
                 */
            } else {
                [_connectManager connectToPeripheral:peripheral];
            }
        }
    }
}

#pragma mark - CCPrinterConnectManagerDelegate

- (void)connectManager:(CCPrinterConnectManager *)connectManager peripheralsDidChange:(NSArray *)peripherals {
    [self reloadTableView];
}

@end
