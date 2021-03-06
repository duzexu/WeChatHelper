//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMService.h"

#import "ISysCallCheckExt.h"
#import "MMMusicAlbumRtnExt.h"
#import "MMMusicListExt.h"
#import "MMMusicLyricsRtnExt.h"
#import "MMMusicPlayerExt.h"
#import "MMService.h"

@class MMMusicInfo, MMMusicListMgr, MMMusicLyricResolver, MusicLogInfo, NSDate, NSMutableArray, NSString;

@interface MMMusicPlayerMgr : MMService <MMService, MMMusicPlayerExt, MMMusicLyricsRtnExt, MMMusicAlbumRtnExt, MMMusicListExt, ISysCallCheckExt>
{
    NSMutableArray *m_arrMusicItems;
    MMMusicInfo *m_prevMusicInfo;
    MMMusicInfo *m_curMusicInfo;
    MMMusicInfo *m_nextMusicInfo;
    int m_playMode;
    int m_playState;
    int m_playDirection;
    MMMusicListMgr *m_musicListMgr;
    MMMusicLyricResolver *m_musicLyricResolver;
    unsigned int m_uiCurMusicIndex;
    double m_musicOffset;
    NSDate *m_musicStartTime;
    _Bool m_bforceStop;
    _Bool m_shouldTurnRepeatNoneMode;
    MusicLogInfo *m_musicLogInfo;
}

- (void).cxx_destruct;
- (void)EndInterruption;
- (void)OnGetLyrics:(id)arg1 Lyrics:(id)arg2;
- (void)OnGetSongAlbumUrl:(id)arg1 AlbumUrl:(id)arg2;
- (void)dealloc;
- (id)getArrMusicItems;
- (id)getCurLyricsList;
- (id)getCurMusicInfo;
- (id)getCurTimeList;
- (id)getMusicInfoByMusicKey:(id)arg1;
- (int)getMusicListSource;
- (double)getMusicOffset;
- (double)getMusicOffsetWhenPaused;
- (double)getMusicOffsetWithoutConsiderPlayState;
- (int)getMusicPlayMode;
- (int)getMusicPlayState;
- (id)getMusicTitle;
- (id)getMusicUrlWithMusicInfo:(id)arg1;
- (id)getNextMusicInfo;
- (id)getPreviousMusicInfo;
- (unsigned long long)indexOfMusic:(id)arg1;
- (id)init;
- (_Bool)isLyricValid;
- (_Bool)isMusicItemsContainsMusicKey:(id)arg1;
- (_Bool)isValidLowBandUrl:(id)arg1;
- (double)jsapi_GetMusicCurrentOffset;
- (unsigned long long)jsapi_GetMusicDownloadPercentByMusicID:(id)arg1;
- (void)jsapi_seekPlay:(float)arg1 withMusicID:(id)arg2;
- (void)logMusicStat;
- (void)logMusicStatAndReset;
@property(retain, nonatomic) MMMusicInfo *m_curMusicInfo; // @synthesize m_curMusicInfo;
@property(retain, nonatomic) MMMusicListMgr *m_musicListMgr; // @synthesize m_musicListMgr;
@property(retain, nonatomic) MusicLogInfo *m_musicLogInfo; // @synthesize m_musicLogInfo;
@property(retain, nonatomic) NSDate *m_musicStartTime; // @synthesize m_musicStartTime;
@property(retain, nonatomic) MMMusicInfo *m_nextMusicInfo; // @synthesize m_nextMusicInfo;
@property(retain, nonatomic) MMMusicInfo *m_prevMusicInfo; // @synthesize m_prevMusicInfo;
@property(nonatomic) _Bool m_shouldTurnRepeatNoneMode; // @synthesize m_shouldTurnRepeatNoneMode;
- (void)onForceStopMusic;
- (void)onLevelMeterPeak:(float)arg1;
- (void)onMusicListArrayChange;
- (void)onMusicPlayStatusChanged;
- (void)onNeedSetPlayPercent;
- (void)onNewSeekTime:(double)arg1;
- (void)onPlayNextMusic;
- (void)onPlayPreviousMusic;
- (void)pausePlay;
- (void)playNextMusic;
- (void)playPreviousMusic;
- (void)playWithMusicInfo:(id)arg1;
- (void)playWithMusicKey:(id)arg1;
- (void)resetMusicPlayerEntranceType;
- (void)setAndPlayMusicItem:(id)arg1;
- (void)setMusicItemList:(id)arg1;
- (void)setMusicPlayDirection:(int)arg1;
- (void)setPlayMode:(int)arg1;
- (void)statNativePlayerAction:(id)arg1 scene:(unsigned int)arg2 actionType:(unsigned int)arg3;
- (void)stopPlay;
- (_Bool)stopWithMusicKey:(id)arg1;
- (void)updateArrMusicItems;
- (void)updateMPNowPlayingInfo;
- (void)updateMusicListBySource:(int)arg1;
- (void)updateMusicLogInfo;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

