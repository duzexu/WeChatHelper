//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCoding.h"

@class NSString;

@interface WCPayBannerNotice : NSObject <NSCoding>
{
    unsigned int _m_readOnly;
    NSString *_m_detailUrl;
    NSString *_m_wording;
}

- (void).cxx_destruct;
- (void)dealloc;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
@property(retain, nonatomic) NSString *m_detailUrl; // @synthesize m_detailUrl=_m_detailUrl;
@property(nonatomic) unsigned int m_readOnly; // @synthesize m_readOnly=_m_readOnly;
@property(retain, nonatomic) NSString *m_wording; // @synthesize m_wording=_m_wording;

@end

