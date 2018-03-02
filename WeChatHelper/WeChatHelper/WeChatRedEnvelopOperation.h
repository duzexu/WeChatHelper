//
//  WeChatRedEnvelopOperation.h
//  IPAPatchFramework
//
//  Created by 杜 泽旭 on 2018/2/12.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeChatRedEnvelopParam;
@interface WeChatRedEnvelopOperation : NSOperation

- (instancetype)initWithParam:(WeChatRedEnvelopParam *)param delay:(NSTimeInterval)delay;

@end
