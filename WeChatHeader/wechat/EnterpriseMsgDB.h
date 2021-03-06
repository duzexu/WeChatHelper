//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMObject.h"

@class NSMutableSet, NSRecursiveLock, NSString, WCDataBase;

@interface EnterpriseMsgDB : MMObject
{
    WCDataBase *_db;
    NSMutableSet *_setCreatedTable;
    NSRecursiveLock *_lock;
    NSString *_path;
}

- (void).cxx_destruct;
- (_Bool)ClearUnRead:(id)arg1 FromID:(unsigned int)arg2 ToID:(unsigned int)arg3;
- (unsigned int)ClearUnReadForSync:(id)arg1 CreateTime:(unsigned int)arg2;
- (void)DelMsg:(id)arg1 MsgList:(id)arg2 DelAll:(_Bool)arg3;
- (id)GetDownMsg:(id)arg1 FromID:(unsigned int)arg2 Limit:(unsigned int)arg3;
- (id)GetFirstUnreadMsg:(id)arg1;
- (id)GetImgAndVideoMsgList:(id)arg1;
- (id)GetImgOrVideoLastMsg:(id)arg1;
- (id)GetImgOrVideoLastMsg:(id)arg1 FromID:(unsigned int)arg2 CreateTime:(unsigned int)arg3;
- (unsigned int)GetImgOrVideoMsgCount:(id)arg1;
- (unsigned int)GetImgOrVideoMsgCount:(id)arg1 FromID:(unsigned int)arg2 CreateTime:(unsigned int)arg3;
- (id)GetImgOrVideoNextMsg:(id)arg1 FromID:(unsigned int)arg2 CreateTime:(unsigned int)arg3;
- (id)GetLastMsg:(id)arg1;
- (unsigned int)GetLastMsgCreateTime:(id)arg1;
- (id)GetMsg:(id)arg1 FromID:(unsigned int)arg2 Limit:(unsigned int)arg3;
- (id)GetMsg:(id)arg1 uiLocalID:(unsigned int)arg2;
- (id)GetMsgByCreateTime:(id)arg1 FromID:(unsigned int)arg2 FromCreateTime:(unsigned int)arg3 Limit:(unsigned int)arg4 LeftCount:(unsigned int *)arg5;
- (unsigned int)GetUnReadCountInChat:(id)arg1;
- (unsigned int)GetUnReadCountInChat:(id)arg1 Since:(unsigned int)arg2;
- (_Bool)MergeImgStatus:(id)arg1 LocalID:(unsigned int)arg2 ImgStatus:(unsigned int)arg3;
- (_Bool)ModMsgByBitSet:(id)arg1 MsgWrap:(id)arg2 BitSet:(unsigned int)arg3;
- (_Bool)ModMsgStatus:(id)arg1 LocalID:(unsigned int)arg2 MsgStatus:(unsigned int)arg3;
- (_Bool)ModMsgSvrId:(id)arg1 LocalID:(unsigned int)arg2 SvrId:(unsigned long long)arg3;
- (void)addCreatedTableCache:(id)arg1;
- (_Bool)addMsg:(id)arg1 MsgWrap:(id)arg2;
- (void)clearCreatedTableCache;
- (void)clearFileOfMsg:(id)arg1;
- (_Bool)createTable:(id)arg1;
- (void)dealloc;
- (void)deleteDB;
- (void)dropTable:(id)arg1;
- (id)getChatTable:(id)arg1;
- (id)getChatTableName:(id)arg1;
- (id)initWithPath:(id)arg1;
- (id)internalGetMsgDBItem:(id)arg1 uiLocalID:(unsigned int)arg2;
- (_Bool)isTableCreated:(id)arg1;
- (void)removeCreatedTableCache:(id)arg1;
- (_Bool)runTransaction:(CDUnknownBlockType)arg1;
- (_Bool)runTransaction:(CDUnknownBlockType)arg1 stateDidChanged:(CDUnknownBlockType)arg2;
- (void)setupCreatedTableCache;

@end

