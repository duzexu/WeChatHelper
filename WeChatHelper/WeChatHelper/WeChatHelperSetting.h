//
//  WeChatHelperSetting.h
//  WeChatHelper
//
//  Created by duzexu on 16/11/11.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 *  插件功能设置
 */
static NSString *const kUserDefault_Helper_Setting = @"kUserDefault_Helper_Setting";

#define HELPER_SETTING [WeChatHelperSetting sharedSetting]

@interface WeChatHelperSetting : NSObject<NSCoding>

@property (nonatomic, assign) BOOL redEnvPluginIsOn;//红包开关
@property (nonatomic, assign) BOOL redEnvPluginForMyself;//抢自己发的红包
@property (nonatomic, assign) NSTimeInterval redEnvPluginDelay;//红包延时
@property (nonatomic, assign) BOOL runInBackGround;//后台运行
@property (nonatomic, retain) NSArray *redEnvBlackList;//自动抢红包黑名单

@property (nonatomic, assign) BOOL fakeLocPluginIsOn;//地理位置开关
@property (nonatomic, strong) CLLocation *fakeLocation;

@property (nonatomic, assign) BOOL forbidRevokeIsOn;//阻止撤回消息

@property (nonatomic, assign) BOOL fakeStepPluginIsOn;//微信运动步数
@property (nonatomic, assign) NSInteger fakeStepCount;

@property (nonatomic, assign) BOOL shakeJump;//摇一摇跳一跳

+ (instancetype)sharedSetting;
- (void)saveSetting;

@end
