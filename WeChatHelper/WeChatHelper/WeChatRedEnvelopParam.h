//
//  WeChatRedEnvelopParam.h
//  IPAPatchFramework
//
//  Created by 杜 泽旭 on 2018/2/12.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatRedEnvelopParam : NSObject

@property (strong, nonatomic) NSString *msgType;
@property (strong, nonatomic) NSString *sendId;
@property (strong, nonatomic) NSString *channelId;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *headImg;
@property (strong, nonatomic) NSString *nativeUrl;
@property (strong, nonatomic) NSString *sessionUserName;
@property (strong, nonatomic) NSString *sign;
@property (strong, nonatomic) NSString *timingIdentifier;

@property (assign, nonatomic) BOOL isGroupSender;

- (NSDictionary *)toParams;

@end
