//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString, UIImage;

@interface WebViewMenuItem : NSObject
{
    NSString *_itemID;
    NSString *_title;
    NSString *_url;
    UIImage *_iconImage;
    NSString *_key;
}

- (void).cxx_destruct;
@property(retain, nonatomic) UIImage *iconImage; // @synthesize iconImage=_iconImage;
- (id)init;
@property(retain, nonatomic) NSString *itemID; // @synthesize itemID=_itemID;
@property(retain, nonatomic) NSString *key; // @synthesize key=_key;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;
- (void)setTitleWithID:(id)arg1;
@property(retain, nonatomic) NSString *url; // @synthesize url=_url;

@end

