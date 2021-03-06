//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BaseMessageNodeView.h"

#import "IAudioReceiverExt.h"

@class UIButton;

@interface VoiceReminderRemindNodeView : BaseMessageNodeView <IAudioReceiverExt>
{
    UIButton *_playButton;
    long long _playCount;
    _Bool _playing;
}

+ (_Bool)canCreateMessageNodeViewInstanceWithMessageWrap:(id)arg1;
- (void).cxx_destruct;
- (void)OnEndPlaying:(unsigned int)arg1 isForceStop:(_Bool)arg2;
- (void)dealloc;
- (id)getMoreMainInfomationAccessibilityDescription;
- (id)init;
- (void)initData;
- (void)initView;
- (void)layoutSubviewsInternal;
- (void)onClearResource;
- (void)onDisappear;
- (void)onLongTouch;
- (void)onMenuItemWillHide;
- (void)onPlayClick;
- (void)onTouchCancel;
- (void)onTouchDown;
- (void)onTouchDownRepeat;
- (void)onTouchUpInside;
- (struct CGSize)sizeForFrame:(struct CGRect)arg1;
- (void)startPlayVoice;
- (void)stopPlayVoice;
- (void)updateBkgImage:(_Bool)arg1;

@end

