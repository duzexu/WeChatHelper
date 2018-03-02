//
//  WeChatRedEnvelopOperation.m
//  IPAPatchFramework
//
//  Created by 杜 泽旭 on 2018/2/12.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import "WeChatRedEnvelopOperation.h"
#import "WeChatHeader.h"
#import "WeChatRedEnvelopParam.h"
#import <objc/runtime.h>

@interface WeChatRedEnvelopOperation ()

@property (assign, nonatomic, getter=isExecuting) BOOL executing;
@property (assign, nonatomic, getter=isFinished) BOOL finished;

@property (strong, nonatomic) WeChatRedEnvelopParam *redEnvelopParam;
@property (assign, nonatomic) NSTimeInterval delaySeconds;

@end

@implementation WeChatRedEnvelopOperation
@synthesize executing = _executing,finished = _finished;

- (instancetype)initWithParam:(WeChatRedEnvelopParam *)param delay:(NSTimeInterval)delay {
    if (self = [super init]) {
        _redEnvelopParam = param;
        _delaySeconds = delay;
    }
    return self;
}

- (void)start {
    if (self.isCancelled) {
        self.finished = YES;
        self.executing = NO;
        return;
    }
    [self main];
}

- (void)main {
    if (self.delaySeconds > 0) {
        sleep(self.delaySeconds);
    }
    WCRedEnvelopesLogicMgr *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
    [logicMgr OpenRedEnvelopesRequest:[self.redEnvelopParam toParams]];
    
    self.finished = YES;
    self.executing = NO;
}

- (void)cancel {
    self.finished = YES;
    self.executing = NO;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isAsynchronous {
    return YES;
}

@end
