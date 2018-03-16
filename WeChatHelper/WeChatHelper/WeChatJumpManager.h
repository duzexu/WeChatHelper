//
//  WeChatJumpManager.h
//  IPAPatchFramework
//
//  Created by duzexu on 2018/3/5.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatJumpManager : NSObject

@property (assign, nonatomic) BOOL isJumping;

+ (instancetype)sharedManager;
- (void)startJump;
- (void)stopJump;

@end
