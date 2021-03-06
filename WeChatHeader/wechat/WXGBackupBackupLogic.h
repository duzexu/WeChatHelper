//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "WXGBackupBasicLogic.h"

@class NSMutableDictionary, NSMutableSet, NSString, WXGBackupAnalysis, WXGBackupBigSizeDataMgr, WXGBackupDataInfo, WXGBackupDataMgr, WXGBackupProtoHandler;

@interface WXGBackupBackupLogic : WXGBackupBasicLogic
{
    WXGBackupProtoHandler *m_protoHandler;
    WXGBackupDataMgr *m_dataMgr;
    WXGBackupDataInfo *m_backupDataInfo;
    WXGBackupBigSizeDataMgr *m_bigSizeDataMgr;
    _Bool m_bSendBigData;
    _Bool m_bFirstTag;
    unsigned long long m_currentSessionCount;
    unsigned long long m_totalSessionCount;
    NSString *m_lastBackupSesionName;
    NSMutableDictionary *m_sessionNickDictionary;
    unsigned int m_startBackupTime;
    _Bool m_bProcessingTag;
    NSMutableSet *m_currentDataID;
    WXGBackupAnalysis *m_analysisiHelper;
}

- (void).cxx_destruct;
- (void)confirmLogic;
- (id)initWithProtoHandler:(id)arg1 withProcessQueue:(id)arg2;
- (void)p_processBackupDataTag:(id)arg1;
- (void)p_sendBackupOutputToRemote:(id)arg1;
- (void)p_sendDataOnMainThread:(id)arg1;
- (void)processBackupDataTag:(id)arg1;
- (void)processBackupDataTagResponse:(id)arg1;
- (void)processDataPush:(id)arg1;
- (void)processDataPushResponse:(id)arg1;
- (void)processFinishRequest:(id)arg1;
- (void)processNotifyCode:(unsigned long long)arg1;
- (void)processOnMainThreadAlert:(unsigned long long)arg1;
- (void)processOnMainThreadNotifyCode:(unsigned long long)arg1;
- (void)processOnMainThreadProgressCurrentSession:(unsigned long long)arg1 totalSession:(unsigned long long)arg2;
- (void)processProgressCurrentSession:(unsigned long long)arg1 totalSession:(unsigned long long)arg2;
- (void)processRequestSession:(id)arg1;
- (void)processRequestSessionResponse:(id)arg1;
- (void)processStartRequest:(id)arg1;
- (void)processStartResponse:(id)arg1;
- (void)processSvrIDRequest:(id)arg1;
- (void)processSvrIDResponse:(id)arg1;
- (void)sendBackupConfirm;
- (void)sendBackupDataTagWithDataInfo:(id)arg1;
- (_Bool)sendData:(id)arg1;
- (void)sendFinishRequest;
- (void)sendLotOfBigDataPush;
- (void)sendLotOfDataPush;
- (void)sendNextBigDataPush;
- (void)sendNextDataPush;
- (void)sendRequestSession;
- (void)sendStartRequest;
- (void)sendSvrIDRequest;
- (void)startService;
- (void)stopService;

@end

