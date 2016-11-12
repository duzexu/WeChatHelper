//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UITabBarController.h"

@class NSMutableArray, UITapGestureRecognizer;

@interface MMTabBarController : UITabBarController
{
    unsigned long long _viewControllersCount;
    NSMutableArray *_tabBarBtns;
    NSMutableArray *_badgeViews;
    UITapGestureRecognizer *_doubleTapGesture;
    _Bool _hasDoubleTapGesture;
    double _lastScreenWidth;
}

- (void).cxx_destruct;
- (void)addDoubleTapGesture;
- (void)bringBadgeViewsToFront;
- (id)currentViewController;
- (id)getBadgeViewForIndex:(long long)arg1;
- (int)getBadgeViewRightMarginPortrait;
- (id)getBadgeViews;
- (id)getTabBarBtnForIndex:(long long)arg1;
- (id)getTabBarBtnViews;
- (id)getViewControllerAtIndex:(unsigned int)arg1;
- (void)handleDoubleTapGesture:(id)arg1;
- (void)hideTabBar;
- (void)hideTabBarForIndex:(long long)arg1;
- (void)hideTabBarWithNoViewHeightUpdateForIndex:(long long)arg1;
- (id)init;
- (void)makeSureFrame;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)reLayoutTabbarToOrientation:(long long)arg1;
- (void)relayoutBadgeViewForIpadIOS8;
- (void)removeDoubleTapGesture;
- (void)setAllTabBarItemEnabled:(_Bool)arg1;
- (void)setSelectedIndex:(unsigned long long)arg1;
- (void)setSelectedViewController:(id)arg1;
- (void)setTabBarBadgeImage:(id)arg1 forIndex:(unsigned int)arg2;
- (void)setTabBarBadgeString:(id)arg1 forIndex:(long long)arg2;
- (void)setTabBarBadgeValue:(long long)arg1 forIndex:(long long)arg2;
- (void)setViewControllers:(id)arg1;
- (void)setViewControllers:(id)arg1 animated:(_Bool)arg2;
- (void)showTabBar;
- (void)showTabBarForIndex:(long long)arg1;
- (void)showTabBarWithNoViewHeightUpdateForIndex:(long long)arg1;
- (unsigned long long)supportedInterfaceOrientations;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewDidLayoutSubviews;
- (void)viewDidLoad;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewWillLayoutSubviews;
- (void)willAnimateRotationToInterfaceOrientation:(long long)arg1 duration:(double)arg2;

// Remaining properties
@property(nonatomic) __weak id <MMTabBarControllerDelegate> delegate;

@end
