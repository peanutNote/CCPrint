//
//  ViewController.m
//  CCPrint
//
//  Created by qianye on 2018/4/10.
//  Copyright © 2018年 qianye. All rights reserved.
//

#import "ViewController.h"
#import "CCPrintField.h"
#import "CCPrinterConnectController.h"

#import "CMPrintTaskWayBill80.h"
#import "CMPrintTaskWayBill58.h"
#import "CMPrintTaskNormalLabel.h"
#import "CMPrintTaskWayBill80Hor.h"
#import "CMPrintTaskCustomOrder.h"

#import "MMPrintTaskWaybill80.h"
#import "MMPrintTaskNormalLabel.h"
#import "MMPrintTaskWayBill80Hor.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *dataList;
@property (strong, nonatomic) CCPrintField *printField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configData];
}

#pragma mark - ConfigData

- (void)configData {
    _dataList = @[@[@"运单80mm", @"运单58mm", @"标签", @"横向表格", @"自定义运单"], @[@"通用版运单80mm", @"通用版标签", @"通用版横向表格"], @[@"打印设置"]];
    _printField = [[CCPrintField alloc] init];
    [_printField setDefaultContent];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *innerArray = _dataList[section];
    return innerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"print_cell"];
    NSArray *innerArray = _dataList[indexPath.section];
    cell.textLabel.text = innerArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CMPrintTaskWayBill80 *wayBill80 = [[CMPrintTaskWayBill80 alloc] init];
            [wayBill80 printWithField:_printField];
        } else if (indexPath.row == 1) {
            CMPrintTaskWayBill58 *wayBill58 = [[CMPrintTaskWayBill58 alloc] init];
            [wayBill58 printWithField:_printField];
        } else if (indexPath.row == 2) {
            CMPrintTaskNormalLabel *norLabel = [[CMPrintTaskNormalLabel alloc] init];
            [norLabel printWithField:_printField];
        } else if (indexPath.row == 3) {
            CMPrintTaskWayBill80Hor *wayBill80Hor = [[CMPrintTaskWayBill80Hor alloc] init];
            [wayBill80Hor printWithField:_printField];
        } else if (indexPath.row == 4) {
            CMPrintTaskCustomOrder *customOrder = [[CMPrintTaskCustomOrder alloc] init];
            [customOrder printWithField:_printField];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MMPrintTaskWaybill80 *wayBill80 = [[MMPrintTaskWaybill80 alloc] init];
            [wayBill80 printWithField:_printField];
        } else if (indexPath.row == 1) {
            MMPrintTaskNormalLabel *norLabel = [[MMPrintTaskNormalLabel alloc] init];
            [norLabel printWithField:_printField];
        } else if (indexPath.row == 2) {
            MMPrintTaskWayBill80Hor *wayBill80Hor = [[MMPrintTaskWayBill80Hor alloc] init];
            [wayBill80Hor printWithField:_printField];
        }
    } else {
        CCPrinterConnectController *vc = [[CCPrinterConnectController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
