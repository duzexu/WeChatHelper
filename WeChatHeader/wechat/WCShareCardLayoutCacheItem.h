//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMObject.h"

#import "PBCoding.h"

@class NSMutableArray, NSString;

@interface WCShareCardLayoutCacheItem : MMObject <PBCoding>
{
    unsigned int lastUpdateTime;
    NSMutableArray *nearbyCardList;
    NSMutableArray *localCityList;
    NSString *cityName;
}

+ (void)initialize;
- (void).cxx_destruct;
@property(retain, nonatomic) NSString *cityName; // @synthesize cityName;
- (const map_0e718273 *)getValueTagIndexMap;
- (id)getValueTypeTable;
@property(nonatomic) unsigned int lastUpdateTime; // @synthesize lastUpdateTime;
@property(retain, nonatomic) NSMutableArray *localCityList; // @synthesize localCityList;
@property(retain, nonatomic) NSMutableArray *nearbyCardList; // @synthesize nearbyCardList;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

