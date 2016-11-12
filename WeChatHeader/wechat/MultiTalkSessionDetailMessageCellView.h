//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMUIView.h"

#import "UITableViewDataSource.h"
#import "UITableViewDelegate.h"

@class MMTableView, NSArray, NSString;

@interface MultiTalkSessionDetailMessageCellView : MMUIView <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_messageList;
    MMTableView *_tableView;
}

+ (double)contentHeightForMessageList:(id)arg1;
- (void).cxx_destruct;
- (void)dealloc;
- (id)getMessageItemAtIndexPath:(id)arg1;
- (void)initView;
- (id)initWithFrame:(struct CGRect)arg1 andMessageContentViewWithMessageList:(id)arg2;
@property(retain, nonatomic) NSArray *messageList; // @synthesize messageList=_messageList;
- (long long)numberOfSectionsInTableView:(id)arg1;
@property(retain, nonatomic) MMTableView *tableView; // @synthesize tableView=_tableView;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
