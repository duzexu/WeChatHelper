//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "WNNoteFavItemBase.h"

@class NSString;

@interface WNNoteFileItem : WNNoteFavItemBase
{
    NSString *_title;
    NSString *_content;
    NSString *_iconPath;
    NSString *_dataPath;
}

- (void).cxx_destruct;
@property(retain, nonatomic) NSString *content; // @synthesize content=_content;
@property(retain, nonatomic) NSString *dataPath; // @synthesize dataPath=_dataPath;
@property(retain, nonatomic) NSString *iconPath; // @synthesize iconPath=_iconPath;
- (id)init;
- (void)initIcon;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;

@end

