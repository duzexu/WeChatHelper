//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCoding.h"

@class NSString;

@interface BakChatUploadMediaPackageStruct : NSObject <NSCoding>
{
    NSString *mediaPath;
    NSString *mediaID;
}

- (void).cxx_destruct;
- (void)clear;
- (void)dealloc;
- (void)encodeWithCoder:(id)arg1;
- (id)init;
- (id)initWithCoder:(id)arg1;
@property(retain, nonatomic) NSString *mediaID; // @synthesize mediaID;
@property(retain, nonatomic) NSString *mediaPath; // @synthesize mediaPath;

@end
