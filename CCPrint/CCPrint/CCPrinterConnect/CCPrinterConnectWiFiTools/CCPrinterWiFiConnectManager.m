//
//  CCPrinterWiFiConnectManager.m
//  CMM
//
//  Created by qianye on 2018/1/16.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import "CCPrinterWiFiConnectManager.h"
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"
#import "CCPeripheral.h"

@interface CCPrinterWiFiConnectManager ()<GCDAsyncSocketDelegate, GCDAsyncUdpSocketDelegate>
/// wifi打印机连接类
@property (strong, nonatomic) GCDAsyncSocket *socket;
/// wifi自动搜索类
@property (strong, nonatomic) GCDAsyncUdpSocket *udpSocket;
/// 控制UDP广播是否发送
@property (assign, nonatomic) BOOL isUDPStart;
@property (nonatomic, strong) CCPeripheral *peripheral;

@end

@implementation CCPrinterWiFiConnectManager

- (instancetype)init {
    if (self = [super init]) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
        [self setupUdpSocket];
    }
    return self;
}

- (void)setupUdpSocket {
    _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [_udpSocket bindToPort:5040 error:nil];
    NSError *error1;
    [_udpSocket enableBroadcast:YES error:&error1];
    if (error1) {
        NSLog(@"error:%@",error1);
    }else {
        [_udpSocket beginReceiving:&error1];
    }
    _discoverPeripherals = [NSMutableArray array];
    _connectedPeripherals = [NSMutableArray array];
}

- (void)startScanPeripherals {
    _isUDPStart = YES;
    [self timeAction:nil];
}

- (void)connectToPeripheral:(CCPeripheral *)peripheral {
    if (peripheral.peripheralType == CCPrinterPeripheralWifi) {
        _peripheral = peripheral;
        NSError *error = nil;
        [_socket connectToHost:peripheral.identifier onPort:9100 error:&error];
        if (error) {
            if (_delegate && [_delegate respondsToSelector:@selector(connectManager:failureConnectedWithPeripheral:)]) {
                [_delegate connectManager:self failureConnectedWithPeripheral:_peripheral];
            }
        }
    }
}

- (void)disconnectPeripheralConnection:(CCPeripheral *)peripheral {
    _peripheral = peripheral;
    if (peripheral.peripheralType == CCPrinterPeripheralWifi) {
        if (_socket.isConnected) {
            [_socket disconnect];
        }
    }
}

- (void)disconnectAllPeripheralsConnection {
    if (_socket.isConnected) {
        [_socket disconnect];
    }
}

- (void)stopScanPeripherals {
    _isUDPStart = NO;
}

#pragma mark - Action

- (void)timeAction:(NSTimer *)timer {
    // 发送UDP广播搜索打印机
    if (_isUDPStart) {
        Byte dataByte[] = {0x00, 0x00, 0x5A, 0x01};
        NSData *data = [NSData dataWithBytes:dataByte length:4];
        UInt16 port = 3040;
        [_udpSocket sendData:data toHost:@"255.255.255.255" port:port withTimeout:100 tag:1];
    }
}

#pragma mark - GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    if (sock.connectedHost) {
        [self addPeripheral:[self findCCPeripheral:_peripheral.identifier]];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:didConnectedWithPeripheral:)]) {
        [_delegate connectManager:self didConnectedWithPeripheral:_peripheral];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err {
    if (err) {
        if (_delegate && [_delegate respondsToSelector:@selector(connectManager:failureConnectedWithPeripheral:)]) {
            [_delegate connectManager:self failureConnectedWithPeripheral:_peripheral];
        }
    } else {
        if (sock.connectedHost) {
            [self deletePeripheral:[self findCCPeripheral:_peripheral.identifier]];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(connectManager:didDisconnectedWithPeripheral:)]) {
            [_delegate connectManager:self didDisconnectedWithPeripheral:_peripheral];
        }
    }
}

#pragma mark - GCDAsyncUdpSocketDelegate

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    CCPeripheral *peripheral = [self findCCPeripheral:ip];
    if (peripheral == nil) {
        peripheral = [[CCPeripheral alloc] init];
        peripheral.rename = @"";
        peripheral.customModel = @0;
        peripheral.peripheralType = CCPrinterPeripheralWifi;
        if (port == 3040) {
            peripheral.originName = @"JolimarkFP-570KLL";
        }
    }
    peripheral.identifier = ip;
    peripheral.socket = _socket;
    [self addDiscoverPeripheral:peripheral];
    if (_delegate && [_delegate respondsToSelector:@selector(connectManager:didDiscoverPeripheral:)]) {
        [_delegate connectManager:self didDiscoverPeripheral:peripheral];
    }
}

#pragma mark - 设备list管理

- (void)addDiscoverPeripheral:(CCPeripheral *)peripheral{
    if (![_discoverPeripherals containsObject:peripheral]) {
        [_discoverPeripherals addObject:peripheral];
    }
}

- (void)addPeripheral:(CCPeripheral *)peripheral {
    if (![_connectedPeripherals containsObject:peripheral]) {
        [_connectedPeripherals addObject:peripheral];
    }
}

- (void)deletePeripheral:(CCPeripheral *)peripheral{
    [_connectedPeripherals removeObject:peripheral];
}

- (CCPeripheral *)findCCPeripheral:(NSString *)identifier {
    for (CCPeripheral *p in _discoverPeripherals) {
        if ([p.identifier isEqualToString:identifier]) {
            return p;
        }
    }
    return nil;
}

@end
