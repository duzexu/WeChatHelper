//
//  WeChatRedEnvelopManager.h
//  IPAPatchFramework
//
//  Created by duzexu on 2018/2/28.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeChatRedEnvelopOperation.h"
#import "WeChatRedEnvelopParam.h"

@interface WeChatRedEnvelopManager : NSObject

@property (nonatomic, strong) NSMutableArray *redEnvelopParams;

+ (instancetype)sharedManager;
- (void)addSerialTask:(WeChatRedEnvelopOperation *)task;

- (WeChatRedEnvelopParam *)paramWithSign:(NSString *)sign;

@end
