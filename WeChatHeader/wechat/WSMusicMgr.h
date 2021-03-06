//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "IMusicPlayerExt.h"

@class MMMusicInfo, NSMutableArray, NSString;

@interface WSMusicMgr : NSObject <IMusicPlayerExt>
{
    MMMusicInfo *_curMusicInfo;
    NSMutableArray *_musicList;
    id <WSMusicDelegate> _delegate;
}

- (void).cxx_destruct;
- (void)clickSnsMusic:(id)arg1 withParams:(id)arg2;
- (id)convertFromWCDataItems:(id)arg1;
@property(retain, nonatomic) MMMusicInfo *curMusicInfo; // @synthesize curMusicInfo=_curMusicInfo;
- (void)dealloc;
@property(nonatomic) __weak id <WSMusicDelegate> delegate; // @synthesize delegate=_delegate;
- (id)getCurrentPlayingMusicSnsId;
- (id)init;
- (_Bool)isMusic:(id)arg1 matchSnsId:(id)arg2;
- (id)makeMusicInfoByMusicItem:(id)arg1;
- (id)makeMusicInfoBySnsId:(id)arg1;
- (void)mergeList:(id)arg1;
@property(retain, nonatomic) NSMutableArray *musicList; // @synthesize musicList=_musicList;
- (void)onClearData;
- (void)onMusicPlayStatusChanged;
- (void)onReloadData;
- (id)parseSnsIdFromMusicId:(id)arg1;
- (void)receiveMusicData:(id)arg1;
- (void)resetData;
- (void)setCurentPlayingUI;
- (void)updatePlayStatus:(_Bool)arg1 forSnsid:(id)arg2;
- (void)updateUI:(id)arg1 playing:(_Bool)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

