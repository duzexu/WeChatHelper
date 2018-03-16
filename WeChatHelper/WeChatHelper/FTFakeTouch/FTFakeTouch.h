//
//  FTFakeTouch.h
//  FTFakeTouch
//
//  Created by 刘博 on 2018/1/9.
//  Copyright © 2018年 devliubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTFakeTouch : NSObject

+ (instancetype)sharedInstance;

#pragma mark - For Window

- (void)tapAtPoint:(CGPoint)point;
- (void)twoFingerTapAtPoint:(CGPoint)point;
- (void)longPressAtPoint:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)dragFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint steps:(NSUInteger)stepCount;

#pragma mark - For View

- (void)tapInView:(UIView *)view atPoint:(CGPoint)point;
- (void)twoFingerTapInView:(UIView *)view atPoint:(CGPoint)point;
- (void)longPressInView:(UIView *)view atPoint:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)dragInView:(UIView *)view fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint steps:(NSUInteger)stepCount;

#pragma mark - For Map

- (void)twoFingerPanInView:(UIView *)view fromPoint:(CGPoint)startPoint toPoint:(CGPoint)toPoint steps:(NSUInteger)stepCount;
- (void)pinchInView:(UIView *)view atPoint:(CGPoint)centerPoint distance:(CGFloat)distance steps:(NSUInteger)stepCount;
- (void)zoomInView:(UIView *)view atPoint:(CGPoint)centerPoint distance:(CGFloat)distance steps:(NSUInteger)stepCount;
- (void)twoFingerRotateInView:(UIView *)view atPoint:(CGPoint)centerPoint angle:(CGFloat)angleInDegrees;


@end
