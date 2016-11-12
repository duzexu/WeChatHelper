//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "WCDBCoding.h"

@class NSString;

@interface WALocalStorageDataInfo : NSObject <WCDBCoding>
{
    unsigned int keyAndDataLength;
    unsigned int lastModifyTime;
    NSString *key;
    NSString *dataType;
    NSString *data;
    long long m___rowID;
}

+ (id)dummyObject;
+ (const map_0e718273 *)getFileValueTagIndexMap;
+ (id)getFileValueTypeTable;
+ (const map_0e718273 *)getPackedValueTagIndexMap;
+ (id)getPackedValueTypeTable;
+ (const map_7a576766 *)getValueNameIndexMap;
+ (id)getValueTable;
+ (const struct WCDBIndexHelper *)getWCDBIndexArray;
+ (unsigned long long)getWCDBIndexArrayCount;
+ (const basic_string_a490aa4c *)getWCDBPrimaryColumnName;
- (void).cxx_destruct;
@property(nonatomic) long long __rowID; // @synthesize __rowID=m___rowID;
@property(retain, nonatomic) NSString *data; // @synthesize data;
@property(retain, nonatomic) NSString *dataType; // @synthesize dataType;
- (const WCDBCondition_22fabacd *)db_data;
- (const WCDBCondition_22fabacd *)db_dataType;
- (const WCDBCondition_22fabacd *)db_key;
- (const WCDBCondition_c6db074e *)db_keyAndDataLength;
- (const WCDBCondition_c6db074e *)db_lastModifyTime;
- (const map_0e718273 *)getValueTagIndexMap;
- (id)getValueTypeTable;
@property(retain, nonatomic) NSString *key; // @synthesize key;
@property(nonatomic) unsigned int keyAndDataLength; // @synthesize keyAndDataLength;
@property(nonatomic) unsigned int lastModifyTime; // @synthesize lastModifyTime;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
