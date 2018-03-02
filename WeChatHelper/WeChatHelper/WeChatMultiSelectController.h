//
//  WeChatMultiSelectController.h
//  IPAPatchFramework
//
//  Created by duzexu on 2018/2/28.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeChatMultiSelectDelegate <NSObject>
- (void)onMultiSelectGroupReturn:(NSArray *)arg1;
@end

@interface WeChatMultiSelectController : UIViewController

@property (nonatomic, weak) id<WeChatMultiSelectDelegate> delegate;

- (instancetype)initWithBlackList:(NSArray *)blackList;

@end
