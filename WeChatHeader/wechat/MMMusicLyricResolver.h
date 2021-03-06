//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray, NSString;

@interface MMMusicLyricResolver : NSObject
{
    NSString *_lyrics;
    NSMutableArray *_lyricsList;
    NSMutableArray *_timeList;
    _Bool _isLyricListContainsEmptyStr;
}

- (void).cxx_destruct;
- (void)dealloc;
- (int)getCurrentIndexWithTime:(float)arg1;
- (double)getDuaration;
- (id)init;
@property(retain, nonatomic) NSString *lyrics; // @synthesize lyrics=_lyrics;
@property(retain, nonatomic) NSMutableArray *lyricsList; // @synthesize lyricsList=_lyricsList;
- (_Bool)resolveLyrics:(id)arg1;
@property(retain, nonatomic) NSMutableArray *timeList; // @synthesize timeList=_timeList;
- (float)time_StringToFloat:(id)arg1;

@end

