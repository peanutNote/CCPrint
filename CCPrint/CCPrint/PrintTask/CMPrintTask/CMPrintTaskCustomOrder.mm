//
//  CMPrintTaskCustomOrder.m
//  CMM
//
//  Created by qianye on 2017/12/5.
//  Copyright © 2017年 chemanman. All rights reserved.
//

#import "CMPrintTaskCustomOrder.h"
#import <SVProgressHUD.h>

#include <iconv.h>
#include "process.h"
#include <iostream>
#include <sstream>
#include <string>
#import "CCPrintManager.h"

@implementation CMPrintTaskCustomOrder

- (NSOperation *)printWithOrderId:(NSString *)orderId printTplId:(NSString *)printTplId type:(NSString *)type {
    NSDictionary *handleDict = [self handlePrintData:@{} withOrderId:orderId];
    [self printWithDataString:@"JSONString"];
    return nil;
}

- (NSDictionary *)handlePrintData:(NSDictionary *)printData withOrderId:(NSString *)orderId {
    NSMutableDictionary *gplDict = printData.mutableCopy;
    NSMutableArray *enums = [NSMutableArray array];
    for (NSDictionary *dict in [gplDict objectForKey:@"enums"]) {
        NSString *name = [dict objectForKey:@"name"];
        NSString *content = [dict objectForKey:@"content"];
        if (name.length && content.length == 0) {
            NSMutableDictionary *enumsDict = [dict mutableCopy];
            if ([name isEqualToString:@"multi_copy_name"]) {
                enumsDict[@"content"] = @"客户存根联";
            } else {
                enumsDict[@"content"] = @"ooxx";
            }
            [enums addObject:enumsDict];
        } else {
            [enums addObject:dict];
        }
    }
    gplDict[@"enums"] = enums;
    return gplDict.copy;
}

- (void)printWithDataString:(NSString *)dataString {
    CCPrintManager *printManager = [CCPrintManager sharePrinterManager];
    if (![printManager startPrintWithTaskModel:CCPrintTaskModelCustomOrder]) {
        return;
    }
    MPPrinter printer;
    printer.dpi = 8;
    printer.io = 0x01;
    CCPrintInstructionType instructType = [printManager.printerBrandManager getInstructionType];
    if (instructType == CCPrintInstructionESC) {
        printer.instruct_type = 0x01 << 20;
    } else if (instructType == CCPrintInstructionTSC) {
        printer.instruct_type = 0x01 << 17;
    } else if (instructType == CCPrintInstructionCPCL) {
        printer.instruct_type = 0x01 << 18;
    } else if (instructType == CCPrintInstructionESCP) {
        printer.dpi = 3;
        printer.io = 0x04;
        printer.instruct_type = 0x01 << 19;
    }
    if (instructType == CCPrintInstructionESCP) {
        char* in_data = (char *)[dataString UTF8String];
        int32_t in_len = (int32_t)strlen(in_data);
        int32_t out_len = in_len * 2 + 1;
        char* out_data = utf8_to_gbk(in_data, in_len, out_len);
        mp_init(out_data, out_len, printer);
    } else {
        mp_init([dataString UTF8String], (int32_t)dataString.length, printer);
    }
    MPInsRsl rsl = mp_pre_print();
    if (rsl.result != nullptr) {
        std::cout << rsl.result << std::endl;
        if (rsl.ret == 0) {
            if (instructType == CCPrintInstructionESCP) {
                NSData *date = [NSData dataWithBytes:rsl.result length:rsl.result_len];
                [printManager printForCustomTemplateWithData:date];
            } else {
                NSString *printString = [NSString stringWithUTF8String:(char *)rsl.result];
                NSData *data = [printString dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];;
                [printManager printForCustomTemplateWithData:data];
            }
        } else if (rsl.ret == -4) {
            [SVProgressHUD showErrorWithStatus:@"打印机不匹配"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"打印数据有误"];
        }
    } else {
        std::cout << "error:" << rsl.ret << std::endl;
    }
    mp_clear();
}

char* utf8_to_gbk(char *inbuf, int32_t in_len, int32_t out_len) {
    iconv_t cd = iconv_open("GBK", "UTF-8");
    size_t inlen = in_len;
    size_t outlen = out_len;
    char *outbuf = (char*)malloc(outlen);
    bzero(outbuf, outlen);
    char *in = inbuf;
    char *out = outbuf;
    iconv(cd, &in, (size_t*)&inlen, &out, &outlen);
    iconv_close(cd);
    return outbuf;
}

@end
