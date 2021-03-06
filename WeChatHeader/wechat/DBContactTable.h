//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "WCDBCoding.h"

@class DBContactBrand, DBContactChatRoom, DBContactHeadImage, DBContactLocal, DBContactOther, DBContactProfile, DBContactRemark, DBContactSocial, NSString;

@interface DBContactTable : NSObject <WCDBCoding>
{
    unsigned int type;
    unsigned int certificationFlag;
    unsigned int imgStatus;
    NSString *userName;
    NSString *encodeUserName;
    DBContactLocal *dbContactLocal;
    DBContactOther *dbContactOther;
    DBContactRemark *dbContactRemark;
    DBContactHeadImage *dbContactHeadImage;
    DBContactProfile *dbContactProfile;
    DBContactSocial *dbContactSocial;
    DBContactChatRoom *dbContactChatRoom;
    DBContactBrand *dbContactBrand;
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
@property(nonatomic) unsigned int certificationFlag; // @synthesize certificationFlag;
@property(retain, nonatomic) DBContactBrand *dbContactBrand; // @synthesize dbContactBrand;
@property(retain, nonatomic) DBContactChatRoom *dbContactChatRoom; // @synthesize dbContactChatRoom;
@property(retain, nonatomic) DBContactHeadImage *dbContactHeadImage; // @synthesize dbContactHeadImage;
@property(retain, nonatomic) DBContactLocal *dbContactLocal; // @synthesize dbContactLocal;
@property(retain, nonatomic) DBContactOther *dbContactOther; // @synthesize dbContactOther;
@property(retain, nonatomic) DBContactProfile *dbContactProfile; // @synthesize dbContactProfile;
@property(retain, nonatomic) DBContactRemark *dbContactRemark; // @synthesize dbContactRemark;
@property(retain, nonatomic) DBContactSocial *dbContactSocial; // @synthesize dbContactSocial;
- (const WCDBCondition_c6db074e *)db_certificationFlag;
- (const WCDBCondition_ccdac511 *)db_dbContactBrand;
- (const WCDBCondition_4ac13cdf *)db_dbContactChatRoom;
- (const WCDBCondition_b9289f6f *)db_dbContactHeadImage;
- (const WCDBCondition_b66c908b *)db_dbContactLocal;
- (const WCDBCondition_dc97b27b *)db_dbContactOther;
- (const WCDBCondition_f2837fb8 *)db_dbContactProfile;
- (const WCDBCondition_4c69d9ed *)db_dbContactRemark;
- (const WCDBCondition_6800d679 *)db_dbContactSocial;
- (const WCDBCondition_22fabacd *)db_encodeUserName;
- (const WCDBCondition_c6db074e *)db_imgStatus;
- (const WCDBCondition_c6db074e *)db_type;
- (const WCDBCondition_22fabacd *)db_userName;
@property(retain, nonatomic) NSString *encodeUserName; // @synthesize encodeUserName;
- (const map_0e718273 *)getValueTagIndexMap;
- (id)getValueTypeTable;
@property(nonatomic) unsigned int imgStatus; // @synthesize imgStatus;
@property(nonatomic) unsigned int type; // @synthesize type;
@property(retain, nonatomic) NSString *userName; // @synthesize userName;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

