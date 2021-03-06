//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMService.h"

#import "MMService.h"

@class NSMutableArray, NSString;

@interface WAAppHistoryMagager : MMService <MMService>
{
    NSMutableArray *m_historyItems;
    NSMutableArray *m_historyItemsWithMsgs;
}

+ (id)genCornerImage:(id)arg1;
- (void).cxx_destruct;
- (void)addAppToHistoryList:(id)arg1;
- (void)deleteAppItemInHistory:(id)arg1;
- (void)fetchImageSuccess:(CDUnknownBlockType)arg1;
- (id)genWebViewSnapImagePath:(id)arg1;
- (id)getAllAppItems;
- (long long)indexOfAppItemInHistory:(id)arg1;
- (id)init;
- (void)initData;
- (_Bool)isAppItemInHistory:(id)arg1;
- (id)itemAtIndex:(unsigned long long)arg1;
- (unsigned long long)itemCount;
- (void)msg_addAppToHistoryList:(id)arg1;
- (void)msg_deleteAppItemInHistory:(id)arg1;
- (id)msg_getAllAppItems;
- (long long)msg_indexOfAppItemInHistory:(id)arg1;
- (_Bool)msg_isAppItemInHistory:(id)arg1;
- (id)msg_itemAtIndex:(unsigned long long)arg1;
- (unsigned long long)msg_itemCount;
- (void)normal_addAppToHistoryList:(id)arg1;
- (void)normarl_deleteAppItemInHistory:(id)arg1;
- (void)onReceiveWeAppMsg:(id)arg1;
- (void)saveData;
- (void)saveSnapWithWebView:(id)arg1;
- (void)saveSnapWithWebView:(id)arg1 forceUpdate:(_Bool)arg2;
- (id)sessionidInHistory:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

