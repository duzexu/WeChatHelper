//
//  WeChatRedEnvelopParam.m
//  IPAPatchFramework
//
//  Created by 杜 泽旭 on 2018/2/12.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import "WeChatRedEnvelopParam.h"

@implementation WeChatRedEnvelopParam

- (NSDictionary *)toParams {
    return @{
             @"msgType": self.msgType,
             @"sendId": self.sendId,
             @"channelId": self.channelId,
             @"nickName": self.nickName,
             @"headImg": self.headImg,
             @"nativeUrl": self.nativeUrl,
             @"sessionUserName": self.sessionUserName,
             @"timingIdentifier": self.timingIdentifier
             };
}

@end
