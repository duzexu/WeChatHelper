//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString;

@interface SelectorWrapper : NSObject
{
    NSString *_objKey;
    SEL _selector;
    id _parameter;
    unsigned long long _inQueueTime;
}

+ (id)genKeyForObject:(id)arg1 withSelector:(SEL)arg2;
- (void)dealloc;
@property(nonatomic) unsigned long long inQueueTime; // @synthesize inQueueTime=_inQueueTime;
@property(retain, nonatomic) NSString *objKey; // @synthesize objKey=_objKey;
@property(retain, nonatomic) id parameter; // @synthesize parameter=_parameter;
@property(nonatomic) SEL selector; // @synthesize selector=_selector;

@end

