//
//  WeChatHelper.m
//  WeChatHelper
//
//  Created by duzexu on 16/11/10.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "CaptainHook.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WeChatHeader.h"
#import "WeChatHelperController.h"
#import "WeChatHelperSetting.h"
#import "WeChatRedEnvelopManager.h"
#import "WeChatJumpManager.h"

BOOL __addMethod(Class clazz, SEL sel, IMP function) {
    NSString *selName = NSStringFromSelector(sel);
    
    NSMutableString *tmpString = [[NSMutableString alloc] initWithFormat:@"%@", selName];
    
    int count = (int)[tmpString replaceOccurrencesOfString:@":"
                                                withString:@"_"
                                                   options:NSCaseInsensitiveSearch
                                                     range:NSMakeRange(0, selName.length)];
    
    NSMutableString *val = [[NSMutableString alloc] initWithString:@"i@:"];
    
    for (int i = 0; i < count; i++) {
        [val appendString:@"@"];
    }
    const char *funcTypeEncoding = [val UTF8String];
    return class_addMethod(clazz, sel, function, funcTypeEncoding);
}

NSString* bundleIdentifierFunction(id target, SEL cmd) {
    return @"com.tencent.xin";
}

@interface UIWindow (Shake)
@end

@implementation UIWindow (Shake)
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        WeChatJumpManager *manager = [WeChatJumpManager sharedManager];
        if (manager.isJumping) {
            [manager stopJump];
        }else{
            if (HELPER_SETTING.shakeJump) {
                [manager startJump];
            }
        }
    }
}
@end

// 代理
CHDeclareClass(MicroMessengerAppDelegate);

static AVAudioPlayer *player = nil;

CHMethod2(BOOL, MicroMessengerAppDelegate, application, UIApplication*, ap, didFinishLaunchingWithOptions, NSDictionary*, launchOptions) {
//    __addMethod([NSBundle class], @selector(wc_bundleIdentifier), bundleIdentifierFunction);
//    Method originalMethod = class_getInstanceMethod([NSBundle class], @selector(bundleIdentifier));
//    Method swizzledMethod = class_getInstanceMethod([NSBundle class], @selector(wc_bundleIdentifier));
//    method_exchangeImplementations(originalMethod, swizzledMethod);
    NSLog(@"## Load WeChatHelper ##");
    return CHSuper2(MicroMessengerAppDelegate, application, ap, didFinishLaunchingWithOptions, launchOptions);
}

CHMethod1(void, MicroMessengerAppDelegate, applicationDidBecomeActive, id, arg1) {
    CHSuper1(MicroMessengerAppDelegate, applicationDidBecomeActive, arg1);
}

CHMethod1(void, MicroMessengerAppDelegate, applicationWillResignActive, id, arg1) {
    CHSuper1(MicroMessengerAppDelegate, applicationWillResignActive, arg1);
    
    [HELPER_SETTING saveSetting];
    if (HELPER_SETTING.runInBackGround) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        if (![session.category isEqualToString:AVAudioSessionCategoryPlayAndRecord]) {
            [session setActive:YES error:nil];
            [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        }
    }
}

CHMethod1(void, MicroMessengerAppDelegate, applicationDidEnterBackground, id, arg1) {
    CHSuper1(MicroMessengerAppDelegate, applicationDidEnterBackground, arg1);
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (HELPER_SETTING.runInBackGround && ![session.category isEqualToString:AVAudioSessionCategoryPlayAndRecord]) {
        if (!player) {
            NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"m4a"];
            NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            player.volume = 0.01;
            player.numberOfLoops = -1;
        }
        [player play];
    }
}

CHMethod1(void, MicroMessengerAppDelegate, applicationWillEnterForeground, id, arg1) {
    CHSuper1(MicroMessengerAppDelegate, applicationWillEnterForeground, arg1);
    [player stop];
}

static NSInteger oldSection;

CHDeclareClass(FindFriendEntryViewController);

CHMethod1(NSInteger, FindFriendEntryViewController, numberOfSectionsInTableView, id, arg1) {
    oldSection = CHSuper1(FindFriendEntryViewController, numberOfSectionsInTableView, arg1);
    return oldSection+1;
}

CHMethod2(UITableViewCell*, FindFriendEntryViewController, tableView, UITableView *, tb, cellForRowAtIndexPath, NSIndexPath*, indexPath) {
    if (indexPath.section < oldSection) {
        return CHSuper2(FindFriendEntryViewController, tableView, tb, cellForRowAtIndexPath, indexPath);
    }
    Class class = NSClassFromString(@"MMTableViewCell");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"helper_setting@2x" ofType:@"png"];
    UITableViewCell *cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.imageView.image = [UIImage imageWithContentsOfFile:path];
    cell.textLabel.text = @"助手设置";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

CHMethod2(NSInteger, FindFriendEntryViewController, tableView, UITableView *, tb, numberOfRowsInSection, NSInteger, index) {
    if (index < oldSection) {
        return CHSuper2(FindFriendEntryViewController, tableView, tb, numberOfRowsInSection, index);
    }
    return 1;
}

CHMethod2(void, FindFriendEntryViewController, tableView, UITableView *, tb, didSelectRowAtIndexPath, NSIndexPath*, indexPath) {
    if (indexPath.section < oldSection) {
        CHSuper2(FindFriendEntryViewController, tableView, tb, didSelectRowAtIndexPath, indexPath);
        return;
    }
    WeChatHelperController *vc = [[WeChatHelperController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [((UIViewController *)self).navigationController pushViewController:vc animated:YES];
}

CHDeclareClass(CMessageMgr);

//MARK: At all
CHMethod2(void, CMessageMgr, AddMsg, id, arg1, MsgWrap, CMessageWrap *, wrap) {
    NSUInteger type = wrap.m_uiMessageType;
    NSString *mFromUser = wrap.m_nsFromUsr;
    NSString *mToUsr = wrap.m_nsToUsr;
    NSString *mContent = wrap.m_nsContent;
    NSString *mSource = wrap.m_nsMsgSource;
    CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *selfContact = [contactManager getSelfContact];
    if (type == 1) {
        if ([mFromUser isEqualToString:selfContact.m_nsUsrName]) {
            if ([mToUsr hasSuffix:@"@chatroom"]) {
                if(!mSource) {
                    NSArray *result = (NSArray *)[objc_getClass("CContact") getChatRoomMemberWithoutMyself:mToUsr];
                    if ([mContent hasPrefix:@"#所有人"]){
                        // 前缀要求
                        NSString *subStr = [mContent substringFromIndex:4];
                        NSMutableString *string = [NSMutableString string];
                        [result enumerateObjectsUsingBlock:^(CContact *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [string appendFormat:@",%@",obj.m_nsUsrName];
                        }];
                        NSString *sourceString = [string substringFromIndex:1];
                        wrap.m_uiStatus = 3;
                        wrap.m_nsContent = subStr;
                        wrap.m_nsMsgSource = [NSString stringWithFormat:@"<msgsource><atuserlist>%@</atuserlist></msgsource>",sourceString];
                    }
                }
            }
        }
    }
    CHSuper(2, CMessageMgr,AddMsg,arg1,MsgWrap,wrap);
}

// 红包
CHMethod2(void, CMessageMgr, AsyncOnAddMsg, NSString*, arg1, MsgWrap, CMessageWrap*, wrap) {
    CHSuper2(CMessageMgr, AsyncOnAddMsg, arg1, MsgWrap, wrap);
    Class contactMgrClass = [objc_getClass("CContactMgr") class];
    CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:contactMgrClass];
    CContact *selfContact = [contactManager getSelfContact];
    
    BOOL isMesasgeFromMe = [wrap.m_nsFromUsr isEqualToString:selfContact.m_nsUsrName];
    BOOL isChatroomReceive = [wrap.m_nsFromUsr rangeOfString:@"@chatroom"].location != NSNotFound;
    BOOL isChatroomSender = [wrap.m_nsToUsr rangeOfString:@"@chatroom"].location != NSNotFound;
    BOOL isChatroomSenderSelf = isMesasgeFromMe && isChatroomSender;
    BOOL isInBlackList = [HELPER_SETTING.redEnvBlackList containsObject:wrap.m_nsFromUsr];
    
    /** 是否自动抢红包 */
    BOOL (^shouldReceiveRedEnvelop)() = ^BOOL() {
        if (!HELPER_SETTING.redEnvPluginIsOn) { return NO; }
        if (isInBlackList) { return NO; }
        
        return isChatroomReceive || (isChatroomSenderSelf && HELPER_SETTING.redEnvPluginForMyself);
    };
    
    switch(wrap.m_uiMessageType) {
        case 49: { // AppNode
            if ([wrap.m_nsContent rangeOfString:@"wxpay://"].location != NSNotFound) { // 红包
                if (!shouldReceiveRedEnvelop()) {
                    break;
                }
                
                NSDictionary *(^parseNativeUrl)(NSString *nativeUrl) = ^(NSString *nativeUrl) {
                    nativeUrl = [nativeUrl substringFromIndex:[@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length]];
                    return [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:nativeUrl separator:@"&"];
                };
                /*
                 agreeDuty = 0;
                 channelId = 1;
                 inWay = 1;
                 msgType = 1;
                 nativeUrl = "wxpay://c2cbizmessagehandler/hongbao/receivehongbao?msgtype=1&channelid=1&sendid=1000039501201709047019673006344&sendusername=ljl4323108&ver=6&sign=99690d3a66ff93739b339d1e1fc71ec12f026f3e34a0806aec19f05f6ab09c9604e4a5a63eef95b25b87cff49fa5bd0d87e46e8a35eca8189fc1020479fc23ad04c00ab0ca78ede59440ed8c63da189b60df7e8f9c7795ca43d1a78410f4ab47";
                 wxpay://c2cbizmessagehandler/hongbao/receivehongbao?msgtype=1&channelid=1&sendid=1000039501201709047018482497054&sendusername=ljl4323108&ver=6&sign=4bee27fc5aeec1399701f05959a48100fbd01fb263d295dd29e13129b8d94c8939232ee668a1e68bf164ee9bead0f4ff14001333427f3a653519efa1578d6f74b7ee48ba20034727fb1c64105b91153c0891f0f29c979437c46f9e9b289a14a8
                 sendId = 1000039501201709047019673006344;
                 */
                /** 获取服务端验证参数 */
                void (^queryRedEnvelopesReqeust)(NSDictionary *nativeUrlDict) = ^(NSDictionary *nativeUrlDict) {
                    NSMutableDictionary *params = [@{} mutableCopy];
                    params[@"agreeDuty"] = @"0";
                    params[@"channelId"] = [nativeUrlDict stringForKey:@"channelid"];
                    params[@"inWay"] = @"0";
                    params[@"msgType"] = [nativeUrlDict stringForKey:@"msgtype"];
                    params[@"nativeUrl"] = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
                    params[@"sendId"] = [nativeUrlDict stringForKey:@"sendid"];
                    
                    WCRedEnvelopesLogicMgr *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
                    [logicMgr ReceiverQueryRedEnvelopesRequest:params];
                };
                
                /** 储存参数 */
                void (^enqueueParam)(NSDictionary *nativeUrlDict) = ^(NSDictionary *nativeUrlDict) {
                    WeChatRedEnvelopParam *mgrParams = [[WeChatRedEnvelopParam alloc] init];
                    mgrParams.msgType = [nativeUrlDict stringForKey:@"msgtype"];
                    mgrParams.sendId = [nativeUrlDict stringForKey:@"sendid"];
                    mgrParams.channelId = [nativeUrlDict stringForKey:@"channelid"];
                    mgrParams.nickName = [selfContact getContactDisplayName];
                    mgrParams.headImg = [selfContact m_nsHeadImgUrl];
                    mgrParams.nativeUrl = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
                    mgrParams.sessionUserName = isChatroomSenderSelf ? wrap.m_nsToUsr : wrap.m_nsFromUsr;
                    mgrParams.sign = [nativeUrlDict stringForKey:@"sign"];
                    
                    mgrParams.isGroupSender = isChatroomSenderSelf;
                    
                    [[WeChatRedEnvelopManager sharedManager].redEnvelopParams addObject:mgrParams];
                };
                
                NSString *nativeUrl = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
                NSDictionary *nativeUrlDict = parseNativeUrl(nativeUrl);
                
                queryRedEnvelopesReqeust(nativeUrlDict);
                enqueueParam(nativeUrlDict);
            }
            break;
        }
        default:
            break;
    }
}

CHDeclareClass(WCRedEnvelopesLogicMgr);
CHMethod2(void, WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, HongBaoRes*, arg1, Request, HongBaoReq*, arg2) {
    
    CHSuper2(WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, arg1, Request, arg2);
    // 非参数查询请求
    if (arg1.cgiCmdid != 3) { return; }
    
    NSString *(^parseRequestSign)() = ^NSString *() {
        NSString *requestString = [[NSString alloc] initWithData:arg2.reqText.buffer encoding:NSUTF8StringEncoding];
        NSDictionary *requestDictionary = [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:requestString separator:@"&"];
        NSString *nativeUrl = [[requestDictionary stringForKey:@"nativeUrl"] stringByRemovingPercentEncoding];
        NSDictionary *nativeUrlDict = [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:nativeUrl separator:@"&"];
        
        return [nativeUrlDict stringForKey:@"sign"];
    };
    
    NSDictionary *responseDict = [[[NSString alloc] initWithData:arg1.retText.buffer encoding:NSUTF8StringEncoding] JSONDictionary];
    
    WeChatRedEnvelopParam *mgrParams = [[WeChatRedEnvelopManager sharedManager] paramWithSign:parseRequestSign()];
    
    BOOL (^shouldReceiveRedEnvelop)() = ^BOOL() {
        
        // 手动抢红包
        if (!mgrParams) { return NO; }
        
        // 自己已经抢过
        if ([responseDict[@"receiveStatus"] integerValue] == 2) { return NO; }
        
        // 红包被抢完
        if ([responseDict[@"hbStatus"] integerValue] == 4) { return NO; }
        
        // 没有这个字段会被判定为使用外挂
        if (!responseDict[@"timingIdentifier"]) { return NO; }
        
        return HELPER_SETTING.redEnvPluginIsOn;
    };
    
    if (shouldReceiveRedEnvelop()) {
        mgrParams.timingIdentifier = responseDict[@"timingIdentifier"];
        
        NSTimeInterval delay = 0;
        if (HELPER_SETTING.redEnvPluginDelay > 0) {
            delay = HELPER_SETTING.redEnvPluginDelay;
        }else if (HELPER_SETTING.redEnvPluginDelay < 0) {
            int index = arc4random() % WeChatHelperDelayTimes.count;
            delay = [WeChatHelperDelayTimes[index] doubleValue];
        }
        WeChatRedEnvelopOperation *operation = [[WeChatRedEnvelopOperation alloc] initWithParam:mgrParams delay:delay];
        [[WeChatRedEnvelopManager sharedManager] addSerialTask:operation];
    }
}

// 防止消息撤回
CHOptimizedMethod1(self, void, CMessageMgr, onRevokeMsg, CMessageWrap *, arg1) {
    if (!HELPER_SETTING.forbidRevokeIsOn) {
        CHSuper1(CMessageMgr, onRevokeMsg, arg1);
    }else{
        if ([arg1.m_nsContent rangeOfString:@"<session>"].location == NSNotFound) { return; }
        if ([arg1.m_nsContent rangeOfString:@"<replacemsg>"].location == NSNotFound) { return; }
        
        NSString *(^parseSession)() = ^NSString *() {
            NSUInteger startIndex = [arg1.m_nsContent rangeOfString:@"<session>"].location + @"<session>".length;
            NSUInteger endIndex = [arg1.m_nsContent rangeOfString:@"</session>"].location;
            NSRange range = NSMakeRange(startIndex, endIndex - startIndex);
            return [arg1.m_nsContent substringWithRange:range];
        };
        
        NSString *(^parseSenderName)() = ^NSString *() {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<!\\[CDATA\\[(.*?)撤回了一条消息\\]\\]>" options:NSRegularExpressionCaseInsensitive error:nil];
            
            NSRange range = NSMakeRange(0, arg1.m_nsContent.length);
            NSTextCheckingResult *result = [regex matchesInString:arg1.m_nsContent options:0 range:range].firstObject;
            if (result.numberOfRanges < 2) { return nil; }
            
            return [arg1.m_nsContent substringWithRange:[result rangeAtIndex:1]];
        };
        
        CMessageWrap *msgWrap = [[objc_getClass("CMessageWrap") alloc] initWithMsgType:0x2710];
        BOOL isSender = [objc_getClass("CMessageWrap") isSenderFromMsgWrap:arg1];
        
        NSString *sendContent;
        if (isSender) {
            [msgWrap setM_nsFromUsr:arg1.m_nsToUsr];
            [msgWrap setM_nsToUsr:arg1.m_nsFromUsr];
            sendContent = @"你撤回了一条消息";
        } else {
            [msgWrap setM_nsToUsr:arg1.m_nsToUsr];
            [msgWrap setM_nsFromUsr:arg1.m_nsFromUsr];
            
            NSString *name = parseSenderName();
            sendContent = [NSString stringWithFormat:@"拦截 %@ 的一条撤回消息", name ? name : arg1.m_nsFromUsr];
        }
        [msgWrap setM_uiStatus:0x4];
        [msgWrap setM_nsContent:sendContent];
        [msgWrap setM_uiCreateTime:[arg1 m_uiCreateTime]];
        
        [self AddLocalMsg:parseSession() MsgWrap:msgWrap fixTime:0x1 NewMsgArriveNotify:0x0];
    }
}

// 地理位置伪装
CHDeclareClass(SeePeopleNearByLogicController);

CHMethod1(void, SeePeopleNearByLogicController, onRetrieveLocationOK, id, arg1) {
    if (HELPER_SETTING.fakeLocPluginIsOn) {
        CHSuper1(SeePeopleNearByLogicController, onRetrieveLocationOK, HELPER_SETTING.fakeLocation);
    }else{
        CHSuper1(SeePeopleNearByLogicController, onRetrieveLocationOK, arg1);
    }
}

CHDeclareClass(WCTimelinePOIPickerViewController);

CHMethod1(void, WCTimelinePOIPickerViewController, onRetrieveLocationOK, id, arg1) {
    if (HELPER_SETTING.fakeLocPluginIsOn) {
        CHSuper1(WCTimelinePOIPickerViewController, onRetrieveLocationOK, HELPER_SETTING.fakeLocation);
    }else{
        CHSuper1(WCTimelinePOIPickerViewController, onRetrieveLocationOK, arg1);
    }
}

// 微信步数
CHDeclareClass(WCDeviceStepObject);

CHMethod0(NSInteger, WCDeviceStepObject, hkStepCount) {
    if (HELPER_SETTING.fakeStepPluginIsOn) {
        return HELPER_SETTING.fakeStepCount;
    }else{
        return CHSuper0(WCDeviceStepObject, hkStepCount);
    }
}

CHMethod0(NSInteger, WCDeviceStepObject, m7StepCount) {
    if (HELPER_SETTING.fakeStepPluginIsOn) {
        return HELPER_SETTING.fakeStepCount;
    }else{
        return CHSuper0(WCDeviceStepObject, m7StepCount);
    }
}

CHConstructor {
    @autoreleasepool {
        CHLoadLateClass(MicroMessengerAppDelegate);
        CHHook2(MicroMessengerAppDelegate, application, didFinishLaunchingWithOptions);
        CHHook1(MicroMessengerAppDelegate, applicationDidBecomeActive);
        CHHook1(MicroMessengerAppDelegate, applicationWillResignActive);
        CHHook1(MicroMessengerAppDelegate, applicationDidEnterBackground);
        CHHook1(MicroMessengerAppDelegate, applicationWillEnterForeground);
        CHLoadLateClass(FindFriendEntryViewController);
        CHHook1(FindFriendEntryViewController, numberOfSectionsInTableView);
        CHHook2(FindFriendEntryViewController, tableView, cellForRowAtIndexPath);
        CHHook2(FindFriendEntryViewController, tableView, numberOfRowsInSection);
        CHHook2(FindFriendEntryViewController, tableView, didSelectRowAtIndexPath);
        CHLoadLateClass(CMessageMgr);
        CHHook2(CMessageMgr, AsyncOnAddMsg, MsgWrap);
        CHHook1(CMessageMgr, onRevokeMsg);
        CHHook2(CMessageMgr, AddMsg, MsgWrap);
        CHLoadLateClass(SeePeopleNearByLogicController);
        CHHook1(SeePeopleNearByLogicController, onRetrieveLocationOK);
        CHLoadLateClass(WCTimelinePOIPickerViewController);
        CHHook1(WCTimelinePOIPickerViewController, onRetrieveLocationOK);
        CHLoadLateClass(WCDeviceStepObject);
        CHHook0(WCDeviceStepObject, hkStepCount);
        CHHook0(WCDeviceStepObject, m7StepCount);
        CHLoadLateClass(WCRedEnvelopesLogicMgr);
        CHHook2(WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, Request);
    }
}

