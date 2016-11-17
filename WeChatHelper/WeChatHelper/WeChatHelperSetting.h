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
 *  插件功能开关
 */
static NSString *const kUserDefault_Helper_RedEnvPluginSwitch = @"kUserDefault_Helper_RedEnvPluginSwitch";
static NSString *const kUserDefault_Helper_RedEnvPluginForMyself = @"kUserDefault_Helper_RedEnvPluginForMyself";
static NSString *const kUserDefault_Helper_RedEnvPluginDelayTime = @"kUserDefault_Helper_RedEnvPluginDelayTime";
static NSString *const kUserDefault_Helper_fakeLocPluginSwitch = @"kUserDefault_Helper_fakeLocPluginSwitch";
static NSString *const kUserDefault_Helper_fakeLocPluginLocation = @"kUserDefault_Helper_fakeLocPluginLocation";
static NSString *const kUserDefault_Helper_forbidRevokeSwitch = @"kUserDefault_Helper_forbidRevokeSwitch";
static NSString *const kUserDefault_Helper_fakeStepPluginSwitch = @"kUserDefault_Helper_fakeStepPluginSwitch";
static NSString *const kUserDefault_Helper_fakeStepPluginCount = @"kUserDefault_Helper_fakeStepPluginCount";

#define HELPER_SETTING [WeChatHelperSetting sharedSetting]

@interface WeChatHelperSetting : NSObject

@property (nonatomic, assign) BOOL redEnvPluginIsOn;//红包开关
@property (nonatomic, assign) BOOL redEnvPluginForMyself;//抢自己发的红包
@property (nonatomic, assign) NSTimeInterval redEnvPluginDelay;//红包延时

@property (nonatomic, assign) BOOL fakeLocPluginIsOn;//地理位置开关
@property (nonatomic, strong) CLLocation *fakeLocation;

@property (nonatomic, assign) BOOL forbidRevokeIsOn;//阻止撤回消息

@property (nonatomic, assign) BOOL fakeStepPluginIsOn;//微信运动步数
@property (nonatomic, assign) NSInteger fakeStepCount;

+ (instancetype)sharedSetting;

@end
