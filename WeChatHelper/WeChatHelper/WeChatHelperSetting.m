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
        _redEnvPluginIsOn = [defaults boolForKey:kUserDefault_Helper_RedEnvPluginSwitch];
        _redEnvPluginForMyself = [defaults boolForKey:kUserDefault_Helper_RedEnvPluginForMyself];
        _redEnvPluginDelay = [defaults doubleForKey:kUserDefault_Helper_RedEnvPluginDelayTime];
        _fakeLocPluginIsOn = [defaults boolForKey:kUserDefault_Helper_fakeLocPluginSwitch];
        //默认位置 39.9128640000,116.4021780000
        NSArray *loc = [defaults objectForKey:kUserDefault_Helper_fakeLocPluginLocation];
        if (loc) {
            _fakeLocation = [[CLLocation alloc] initWithLatitude:[loc[0] doubleValue] longitude:[loc[1] doubleValue]];
        }else{
            _fakeLocation = [[CLLocation alloc] initWithLatitude:39.912 longitude:116.402];
        }
        _forbidRevokeIsOn = [defaults boolForKey:kUserDefault_Helper_forbidRevokeSwitch];
        _fakeStepPluginIsOn = [defaults boolForKey:kUserDefault_Helper_fakeStepPluginSwitch];
        _fakeStepCount = [defaults integerForKey:kUserDefault_Helper_fakeStepPluginCount];
    }
    return self;
}

- (void)setRedEnvPluginIsOn:(BOOL)redEnvPluginIsOn {
    _redEnvPluginIsOn = redEnvPluginIsOn;
    [[NSUserDefaults standardUserDefaults] setBool:redEnvPluginIsOn forKey:kUserDefault_Helper_RedEnvPluginSwitch];
}

-(void)setRedEnvPluginForMyself:(BOOL)redEnvPluginForMyself {
    _redEnvPluginForMyself = redEnvPluginForMyself;
    [[NSUserDefaults standardUserDefaults] setBool:redEnvPluginForMyself forKey:kUserDefault_Helper_RedEnvPluginForMyself];
}

-(void)setRedEnvPluginDelay:(NSTimeInterval)redEnvPluginDelay {
    _redEnvPluginDelay = redEnvPluginDelay;
    [[NSUserDefaults standardUserDefaults] setDouble:redEnvPluginDelay forKey:kUserDefault_Helper_RedEnvPluginDelayTime];
}

- (void)setFakeLocPluginIsOn:(BOOL)fakeLocPluginIsOn {
    _fakeLocPluginIsOn = fakeLocPluginIsOn;
    [[NSUserDefaults standardUserDefaults] setBool:fakeLocPluginIsOn forKey:kUserDefault_Helper_fakeLocPluginSwitch];
}

- (void)setFakeLocation:(CLLocation *)fakeLocation {
    if (fakeLocation) {
        _fakeLocation = fakeLocation;
        CLLocationCoordinate2D c = fakeLocation.coordinate;
        [[NSUserDefaults standardUserDefaults] setObject:@[@(c.latitude),@(c.longitude)] forKey:kUserDefault_Helper_fakeLocPluginLocation];
    }
}

- (void)setForbidRevokeIsOn:(BOOL)forbidRevokeIsOn {
    _forbidRevokeIsOn = forbidRevokeIsOn;
    [[NSUserDefaults standardUserDefaults] setBool:forbidRevokeIsOn forKey:kUserDefault_Helper_forbidRevokeSwitch];
}

- (void)setFakeStepPluginIsOn:(BOOL)fakeStepPluginIsOn {
    _fakeStepPluginIsOn = fakeStepPluginIsOn;
    [[NSUserDefaults standardUserDefaults] setBool:fakeStepPluginIsOn forKey:kUserDefault_Helper_fakeStepPluginSwitch];
}

- (void)setFakeStepCount:(NSInteger)fakeStepCount {
    _fakeStepCount = fakeStepCount;
    [[NSUserDefaults standardUserDefaults] setInteger:fakeStepCount forKey:kUserDefault_Helper_fakeStepPluginCount];
}

@end
