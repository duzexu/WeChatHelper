//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "PBCoding.h"

@class NSString;

@interface MSEMessageMetaDataImageItem : NSObject <PBCoding>
{
    NSString *toUsername;
    NSString *imageUrl;
}

+ (void)initialize;
- (void).cxx_destruct;
- (const map_0e718273 *)getValueTagIndexMap;
- (id)getValueTypeTable;
@property(retain, nonatomic) NSString *imageUrl; // @synthesize imageUrl;
@property(retain, nonatomic) NSString *toUsername; // @synthesize toUsername;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

