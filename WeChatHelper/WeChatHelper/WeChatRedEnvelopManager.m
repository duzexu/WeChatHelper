//
//  WeChatRedEnvelopManager.m
//  IPAPatchFramework
//
//  Created by duzexu on 2018/2/28.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import "WeChatRedEnvelopManager.h"

@interface WeChatRedEnvelopManager ()

@property (strong, nonatomic) NSOperationQueue *serialTaskQueue;

@end

@implementation WeChatRedEnvelopManager

+ (instancetype)sharedManager {
    static WeChatRedEnvelopManager *taskManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        taskManager = [WeChatRedEnvelopManager new];
    });
    return taskManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _redEnvelopParams = [NSMutableArray array];
        _serialTaskQueue = [[NSOperationQueue alloc] init];
        _serialTaskQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)addSerialTask:(WeChatRedEnvelopOperation *)task {
    [self.serialTaskQueue addOperation:task];
}

- (WeChatRedEnvelopParam *)paramWithSign:(NSString *)sign {
    if (_redEnvelopParams.count == 0) {
        return nil;
    }
    WeChatRedEnvelopParam *result = nil;
    for (WeChatRedEnvelopParam *param in _redEnvelopParams) {
        if ([param.sign isEqualToString:sign]) {
            result = param;
            break;
        }
    }
    if (!result) {
        result = _redEnvelopParams.firstObject;
    }
    [_redEnvelopParams removeObject:result];
    return result;
}

@end
