//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMUIViewController.h"

#import "ITemplateMsgRecvExt.h"
#import "UITableViewDataSource.h"
#import "UITableViewDelegate.h"

@class MMScrollView, MMTableView, NSArray, NSString;

@interface TemplateMsgRecvViewController : MMUIViewController <UITableViewDelegate, UITableViewDataSource, ITemplateMsgRecvExt>
{
    NSString *_username;
    MMTableView *_tableView;
    MMScrollView *_emptyView;
    NSArray *_msgRecvState;
    _Bool _bStateChanged;
}

- (void).cxx_destruct;
- (void)dealloc;
- (void)initEmptyView;
- (void)initTableView;
- (id)initWithUser:(id)arg1;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)onRecvSwitchChanged:(id)arg1;
- (void)onTemplateMsgConnectionChange:(unsigned int)arg1;
- (void)onTemplateMsgRecvStateChangedForUser:(id)arg1 withData:(id)arg2;
- (void)showSubView;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (void)viewDidLoad;
- (void)viewWillBePoped:(_Bool)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
