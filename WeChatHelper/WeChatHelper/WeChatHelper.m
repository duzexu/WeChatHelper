//
//  WeChatHelper.m
//  WeChatHelper
//
//  Created by duzexu on 16/11/10.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "CaptainHook.h"
#import <UIKit/UIKit.h>
#import "WeChatHelperController.h"
#import "WeChatHelperSetting.h"

CHDeclareClass(MicroMessengerAppDelegate);
static UILabel *label = nil;
CHMethod1(void, MicroMessengerAppDelegate, applicationDidBecomeActive, id, arg1) {
    CHSuper1(MicroMessengerAppDelegate, applicationDidBecomeActive, arg1);
}

CHDeclareClass(MMUIViewController);

static NSInteger oldSection;

CHMethod1(void, MMUIViewController, viewDidAppear, id, arg1) {
    CHSuper1(MMUIViewController, viewDidAppear, arg1);
//    [label removeFromSuperview];
//    if (!label) {
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 100)];
//        label.backgroundColor= [UIColor colorWithWhite:0 alpha:0.3];
//        label.textColor = [UIColor whiteColor];
//        label.numberOfLines = 0;
//        label.font = [UIFont systemFontOfSize:9];
//    }
//    [[self view] addSubview:label];
//    label.text = NSStringFromClass([self class]);
}

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

CHMethod2(void, CMessageMgr, AsyncOnAddMsg, id, arg1, MsgWrap, id, arg2) {
    CHSuper2(CMessageMgr, AsyncOnAddMsg, arg1, MsgWrap, arg2);
    
    if (!HELPER_SETTING.redEnvPluginIsOn) {
        return;
    }
    
    Ivar uiMessageTypeIvar = class_getInstanceVariable(objc_getClass("CMessageWrap"), "m_uiMessageType");
    ptrdiff_t offset = ivar_getOffset(uiMessageTypeIvar);
    unsigned char *stuffBytes = (unsigned char *)(__bridge void *)arg2;
    NSUInteger m_uiMessageType = * ((NSUInteger *)(stuffBytes + offset));
    
    Ivar nsFromUsrIvar = class_getInstanceVariable(objc_getClass("CMessageWrap"), "m_nsFromUsr");
    id m_nsFromUsr = object_getIvar(arg2, nsFromUsrIvar);
    
    Ivar nsContentIvar = class_getInstanceVariable(objc_getClass("CMessageWrap"), "m_nsContent");
    id m_nsContent = object_getIvar(arg2, nsContentIvar);
    label.text = [NSString stringWithFormat:@"类型：%d 发送者：%@ 消息内容：%@",(int)m_uiMessageType,m_nsFromUsr,m_nsContent];
    
    switch(m_uiMessageType) {
        case 49: {
            // 49=红包
            //微信的服务中心
            Method methodMMServiceCenter = class_getClassMethod(objc_getClass("MMServiceCenter"), @selector(defaultCenter));
            IMP impMMSC = method_getImplementation(methodMMServiceCenter);
            id MMServiceCenter = impMMSC(objc_getClass("MMServiceCenter"), @selector(defaultCenter));
            //红包控制器
            id logicMgr = ((id (*)(id, SEL, Class))objc_msgSend)(MMServiceCenter, @selector(getService:),objc_getClass("WCRedEnvelopesLogicMgr"));
            //通讯录管理器
            id contactManager = ((id (*)(id, SEL, Class))objc_msgSend)(MMServiceCenter, @selector(getService:),objc_getClass("CContactMgr"));
            
            Method methodGetSelfContact = class_getInstanceMethod(objc_getClass("CContactMgr"), @selector(getSelfContact));
            IMP impGS = method_getImplementation(methodGetSelfContact);
            id selfContact = impGS(contactManager, @selector(getSelfContact));
            
            Ivar nsUsrNameIvar = class_getInstanceVariable([selfContact class], "m_nsUsrName");
            id m_nsUsrName = object_getIvar(selfContact, nsUsrNameIvar);
            BOOL isMesasgeFromMe = [m_nsFromUsr isEqualToString:m_nsUsrName];
            BOOL isChatroom = [m_nsFromUsr rangeOfString:@"@chatroom"].location != NSNotFound;
            if (isMesasgeFromMe && !isChatroom) {
                break;
            }
            if(isMesasgeFromMe && !HELPER_SETTING.redEnvPluginForMyself && isChatroom) {
                //不抢群里自己的红包
                break;
            }
            if ([m_nsContent rangeOfString:@"wxpay://"].location != NSNotFound) {
                NSString *nativeUrl = m_nsContent;
                NSRange rangeStart = [m_nsContent rangeOfString:@"wxpay://c2cbizmessagehandler/hongbao"];
                if (rangeStart.location != NSNotFound)
                {
                    NSUInteger locationStart = rangeStart.location;
                    nativeUrl = [nativeUrl substringFromIndex:locationStart];
                }
                
                NSRange rangeEnd = [nativeUrl rangeOfString:@"]]"];
                if (rangeEnd.location != NSNotFound)
                {
                    NSUInteger locationEnd = rangeEnd.location;
                    nativeUrl = [nativeUrl substringToIndex:locationEnd];
                }
                
                NSString *naUrl = [nativeUrl substringFromIndex:[@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length]];
                
                NSArray *parameterPairs =[naUrl componentsSeparatedByString:@"&"];
                
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:[parameterPairs count]];
                for (NSString *currentPair in parameterPairs) {
                    NSRange range = [currentPair rangeOfString:@"="];
                    if(range.location == NSNotFound)
                        continue;
                    NSString *key = [currentPair substringToIndex:range.location];
                    NSString *value =[currentPair substringFromIndex:range.location + 1];
                    [parameters setObject:value forKey:key];
                }
                
                //红包参数
                NSMutableDictionary *params = [@{} mutableCopy];
                
                [params setObject:parameters[@"msgtype"]?:@"null" forKey:@"msgType"];
                [params setObject:parameters[@"sendid"]?:@"null" forKey:@"sendId"];
                [params setObject:parameters[@"channelid"]?:@"null" forKey:@"channelId"];
                
                id getContactDisplayName = objc_msgSend(selfContact, @selector(getContactDisplayName));
                id m_nsHeadImgUrl = objc_msgSend(selfContact, @selector(m_nsHeadImgUrl));
                
                [params setObject:getContactDisplayName forKey:@"nickName"];
                [params setObject:m_nsHeadImgUrl forKey:@"headImg"];
                [params setObject:[NSString stringWithFormat:@"%@", nativeUrl]?:@"null" forKey:@"nativeUrl"];
                [params setObject:m_nsFromUsr?:@"null" forKey:@"sessionUserName"];
                
                if (HELPER_SETTING.redEnvPluginDelay > 0) {
                    [logicMgr performSelector:@selector(OpenRedEnvelopesRequest:) withObject:params afterDelay:HELPER_SETTING.redEnvPluginDelay];
                }else{
                    ((void (*)(id, SEL, NSMutableDictionary*))objc_msgSend)(logicMgr, @selector(OpenRedEnvelopesRequest:), params);
                }
                return;
            }
            break;
        }
        default:
            break;
    }
}

CHMethod1(void, CMessageMgr, onRevokeMsg, id, arg1) {
    if (!HELPER_SETTING.forbidRevokeIsOn) {
        CHSuper1(CMessageMgr, onRevokeMsg, arg1);
    }
}

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

CHConstructor {
    @autoreleasepool {
        CHLoadLateClass(MicroMessengerAppDelegate);
        CHClassHook1(MicroMessengerAppDelegate, applicationDidBecomeActive);
        CHLoadLateClass(MMUIViewController);
        CHClassHook1(MMUIViewController, viewDidAppear);
        CHLoadLateClass(FindFriendEntryViewController);
        CHClassHook1(FindFriendEntryViewController, numberOfSectionsInTableView);
        CHClassHook2(FindFriendEntryViewController, tableView, cellForRowAtIndexPath);
        CHClassHook2(FindFriendEntryViewController, tableView, numberOfRowsInSection);
        CHClassHook2(FindFriendEntryViewController, tableView, didSelectRowAtIndexPath);
        CHLoadLateClass(CMessageMgr);
        CHClassHook2(CMessageMgr, AsyncOnAddMsg, MsgWrap);
        CHClassHook1(CMessageMgr, onRevokeMsg);
        CHLoadLateClass(SeePeopleNearByLogicController);
        CHHook1(SeePeopleNearByLogicController, onRetrieveLocationOK);
        CHLoadLateClass(WCTimelinePOIPickerViewController);
        CHClassHook1(WCTimelinePOIPickerViewController, onRetrieveLocationOK);
    }
}

