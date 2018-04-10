//
//  CCPrinterWiFiMacAddress.m
//  CMM
//
//  Created by qianye on 2018/1/30.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import "CCPrinterWiFiMacAddress.h"

#include "route.h"
#include "if_ether.h"
#include <arpa/inet.h>

#define BUFLEN (sizeof(struct rt_msghdr) + 512)

@implementation CCPrinterWiFiMacAddress

+ (NSString *)getMacAddressWithIpAddress:(NSString *)ipAddress {
    const char *ip = [ipAddress UTF8String];
    
    unsigned char buf[BUFLEN];
    unsigned char buf2[BUFLEN];
    memset(buf, 0, sizeof(buf));
    memset(buf2, 0, sizeof(buf2));
    
    int sockfd = socket(AF_ROUTE, SOCK_RAW, 0);
    
    struct rt_msghdr *rtm = (struct rt_msghdr *)buf;
    rtm->rtm_msglen = sizeof(struct rt_msghdr) + sizeof(struct sockaddr_in);
    rtm->rtm_version = RTM_VERSION;
    rtm->rtm_type = RTM_GET;
    rtm->rtm_addrs = RTA_DST;
    rtm->rtm_flags = RTF_LLINFO;
    rtm->rtm_pid = 1234;
    rtm->rtm_seq = 9999;
    
    struct sockaddr_in *sin = (struct sockaddr_in *) (rtm + 1);
    sin->sin_len = sizeof(struct sockaddr_in);
    sin->sin_family = AF_INET;
    sin->sin_addr.s_addr = inet_addr(ip);
    write(sockfd, rtm, rtm->rtm_msglen);
    
    ssize_t n = read(sockfd, buf2, BUFLEN);
    close(sockfd);
    
    if (n != 0) {
        int index =  sizeof(struct rt_msghdr) + sizeof(struct sockaddr_inarp) + 8;
        NSString *macAddress = [NSString stringWithFormat:@"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x", buf2[index+0], buf2[index+1], buf2[index+2], buf2[index+3], buf2[index+4], buf2[index+5]];
        //If macAddress is equal to 00:00.. then mac address not exist in ARP table and returns nil. If it retuns 08:00.. then the mac address not exist because it's not in the same subnet with the device and return nil
        if ([macAddress isEqualToString:@"00:00:00:00:00:00"] || [macAddress isEqualToString:@"08:00:00:00:00:00"] ) {
            return nil;
        }
        return macAddress;
    }
    return @"";
}

@end
