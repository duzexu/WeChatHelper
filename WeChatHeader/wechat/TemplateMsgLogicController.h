//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BaseMsgContentLogicController.h"

#import "PBMessageObserverDelegate.h"

@class WAContactGetter;

@interface TemplateMsgLogicController : BaseMsgContentLogicController <PBMessageObserverDelegate>
{
    WAContactGetter *m_contactGetter;
}

- (void).cxx_destruct;
- (_Bool)CanShowSight;
- (void)ClearUnRead:(id)arg1 FromID:(unsigned int)arg2 ToID:(unsigned int)arg3;
- (void)CustomToolViewEX:(id)arg1;
- (void)DelMsg:(id)arg1 MsgList:(id)arg2 DelAll:(_Bool)arg3;
- (id)GetDownMsg:(id)arg1 FromID:(unsigned int)arg2 Limit:(unsigned int)arg3 LeftCount:(unsigned int *)arg4 LeftUnreadCount:(unsigned int *)arg5;
- (id)GetMsg:(id)arg1 FromID:(unsigned int)arg2 Limit:(unsigned int)arg3 LeftCount:(unsigned int *)arg4 LeftUnreadCount:(unsigned int *)arg5;
- (id)GetUsrTitle;
- (void)OpenChatView:(id)arg1;
- (void)OpenContactInfo:(id)arg1;
- (_Bool)ShouldShowSearchCompleteRightBarButton;
- (void)dealloc;
- (unsigned int)getMsgCountToLoad;
- (void)initViewController;
- (_Bool)isShowHeadImage:(id)arg1;
- (_Bool)shouldShowAppBottomButton;

@end

