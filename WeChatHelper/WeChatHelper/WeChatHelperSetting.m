//
//  WeChatHelperSetting.m
//  WeChatHelper
//
//  Created by duzexu on 16/11/11.
//
//

#import "WeChatHelperSetting.h"

@implementation WeChatHelperSetting

+ (instancetype)sharedSetting {
    static WeChatHelperSetting *_sharedSetting = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSetting = [[self alloc] init];
    });
    
    return _sharedSetting;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *settingData = [defaults objectForKey:kUserDefault_Helper_Setting];
        if (settingData) {
            WeChatHelperSetting *setting = [NSKeyedUnarchiver unarchiveObjectWithData:settingData];
            return setting;
        }else{
           _fakeLocation = [[CLLocation alloc] initWithLatitude:39.912 longitude:116.402];
        }
    }
    return self;
}

- (void)saveSetting {
    NSData *settingData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:settingData forKey:kUserDefault_Helper_Setting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_redEnvPluginIsOn forKey:@"redEnvPluginIsOn"];
    [aCoder encodeBool:_redEnvPluginForMyself forKey:@"redEnvPluginForMyself"];
    [aCoder encodeDouble:_redEnvPluginDelay forKey:@"redEnvPluginDelay"];
    [aCoder encodeBool:_runInBackGround forKey:@"runInBackGround"];
    [aCoder encodeObject:_redEnvBlackList forKey:@"redEnvBlackList"];
    [aCoder encodeBool:_fakeLocPluginIsOn forKey:@"fakeLocPluginIsOn"];
    [aCoder encodeObject:@[@(_fakeLocation.coordinate.latitude),@(_fakeLocation.coordinate.longitude)] forKey:@"fakeLocation"];
    [aCoder encodeBool:_forbidRevokeIsOn forKey:@"forbidRevokeIsOn"];
    [aCoder encodeBool:_fakeStepPluginIsOn forKey:@"fakeStepPluginIsOn"];
    [aCoder encodeInteger:_fakeStepCount forKey:@"fakeStepCount"];
    [aCoder encodeBool:_shakeJump forKey:@"shakeJump"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _redEnvPluginIsOn = [aDecoder decodeBoolForKey:@"redEnvPluginIsOn"];
        _redEnvPluginForMyself = [aDecoder decodeBoolForKey:@"redEnvPluginForMyself"];
        _redEnvPluginDelay = [aDecoder decodeDoubleForKey:@"redEnvPluginDelay"];
        _runInBackGround = [aDecoder decodeBoolForKey:@"runInBackGround"];
        _redEnvBlackList = [aDecoder decodeObjectForKey:@"redEnvBlackList"];
        _fakeLocPluginIsOn = [aDecoder decodeBoolForKey:@"fakeLocPluginIsOn"];
        NSArray *loc = [aDecoder decodeObjectForKey:@"fakeLocation"];
        _fakeLocation = [[CLLocation alloc] initWithLatitude:[loc[0] doubleValue] longitude:[loc[1] doubleValue]];
        _forbidRevokeIsOn = [aDecoder decodeBoolForKey:@"forbidRevokeIsOn"];
        _fakeStepPluginIsOn = [aDecoder decodeBoolForKey:@"fakeStepPluginIsOn"];
        _fakeStepCount = [aDecoder decodeIntegerForKey:@"fakeStepCount"];
        _shakeJump = [aDecoder decodeBoolForKey:@"shakeJump"];
    }
    return self;
}

@end
