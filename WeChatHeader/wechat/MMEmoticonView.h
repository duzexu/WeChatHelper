//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIView.h"

@class CEmoticonWrap, MMGifView, UIImageView;

@interface MMEmoticonView : UIView
{
    double m_imageScale;
    CEmoticonWrap *emoticonWrap;
    double maxHeight;
    UIImageView *m_imageView;
    MMGifView *m_gifView;
    double _use1xScaleMaxWidth;
    struct CGSize _noImageSize;
}

+ (double)ImageScaleForIsStore:(_Bool)arg1;
+ (double)MaxSizeSetting;
+ (unsigned int)getIdKeyDisplayFailed;
+ (unsigned int)getIdKeyIdEmoticon;
+ (unsigned int)getIdKeyNotImageFile;
- (void).cxx_destruct;
- (void)adjustSettingForPreview;
- (struct CGSize)calSizeForSize:(struct CGSize)arg1;
- (void)dealloc;
@property(retain, nonatomic) CEmoticonWrap *emoticonWrap; // @synthesize emoticonWrap;
- (_Bool)formGifView:(_Bool)arg1;
- (_Bool)formImageView:(id)arg1;
- (_Bool)formImageView:(id)arg1 newSize:(struct CGSize)arg2;
- (id)imageWithData:(id)arg1;
- (id)init;
- (id)initWithFrame:(struct CGRect)arg1;
- (_Bool)isPlayGif;
@property(retain, nonatomic) MMGifView *m_gifView; // @synthesize m_gifView;
@property(retain, nonatomic) UIImageView *m_imageView; // @synthesize m_imageView;
@property(nonatomic) double maxHeight; // @synthesize maxHeight;
@property(nonatomic) struct CGSize noImageSize; // @synthesize noImageSize=_noImageSize;
- (_Bool)setEmoticonWrap:(id)arg1 PlayGif:(_Bool)arg2;
- (void)setFrame:(struct CGRect)arg1;
- (void)setGifViewMaxEdge:(double)arg1;
- (void)setImageHidden:(_Bool)arg1;
- (void)setPlayGif:(_Bool)arg1;
@property(nonatomic) double use1xScaleMaxWidth; // @synthesize use1xScaleMaxWidth=_use1xScaleMaxWidth;

@end

