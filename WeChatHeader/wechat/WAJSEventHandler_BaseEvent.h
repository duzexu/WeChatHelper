//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class WAWebViewController;

@interface WAJSEventHandler_BaseEvent : NSObject
{
    unsigned int _callbackId;
    id <WAJSEventHandlerContextDelegate> _context;
    WAWebViewController *_webviewController;
}

- (void).cxx_destruct;
@property(nonatomic) unsigned int callbackId; // @synthesize callbackId=_callbackId;
@property(nonatomic) __weak id <WAJSEventHandlerContextDelegate> context; // @synthesize context=_context;
- (void)endWithResult:(id)arg1;
- (id)getAppID;
- (void)handleJSEvent:(id)arg1;
@property(nonatomic) __weak WAWebViewController *webviewController; // @synthesize webviewController=_webviewController;

@end

