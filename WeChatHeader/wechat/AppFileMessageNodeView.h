//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "BaseMessageNodeView.h"

#import "UIAlertViewDelegate.h"

@class AppFileNodeProgressView, NSString, UIButton, UILabel;

@interface AppFileMessageNodeView : BaseMessageNodeView <UIAlertViewDelegate>
{
    UILabel *m_detailLabel;
    AppFileNodeProgressView *m_fileProgressView;
    UIButton *m_oCancelBtn;
    int m_uiStatus;
}

+ (_Bool)canCreateMessageNodeViewInstanceWithMessageWrap:(id)arg1;
- (void).cxx_destruct;
- (void)StopDownloadAppFile;
- (void)StopUploadAppFile;
- (void)alertView:(id)arg1 clickedButtonAtIndex:(long long)arg2;
- (id)getFileDetailText;
- (id)getMessageDisplayView;
- (id)getMoreMainInfomationAccessibilityDescription;
- (id)getThumbImage;
- (id)getTitleLabel;
- (id)getTitleText;
- (void)initDetailLabel;
- (id)initWithMessageWrap:(id)arg1 Contact:(id)arg2 ChatContact:(id)arg3;
- (void)layoutSubviewsInternal;
- (void)onAppear;
- (void)onClearResource;
- (void)onClick;
- (void)onDisappear;
- (void)onDownloadAppAttachCommonFail:(id)arg1;
- (void)onDownloadAppAttachExpireFail:(id)arg1;
- (void)onFavoriteAdd:(id)arg1;
- (void)onForward:(id)arg1;
- (void)onLongTouch;
- (void)onMenuItemWillHide;
- (void)onMoreOperate:(id)arg1;
- (void)onTouchCancel;
- (void)onTouchDown;
- (void)onTouchDownRepeat;
- (void)onTouchUpInside;
- (void)resend:(id)arg1;
- (void)showOpearation;
- (struct CGSize)sizeForFrame:(struct CGRect)arg1;
- (void)updateBkgImage:(_Bool)arg1;
- (void)updateStatus:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

