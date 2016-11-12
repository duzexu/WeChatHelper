//
//  ViewController.m
//  demo
//
//  Created by duzexu on 16/11/11.
//  Copyright © 2016年 duzexu. All rights reserved.
//

#import "WeChatMapController.h"
#import "WeChatHelperSetting.h"
#import <MapKit/MapKit.h>

@interface WeChatMapController ()<MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate> {
    BOOL isLocated;
}

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) MKPointAnnotation *centerAnnotation;

@end

@implementation WeChatMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[MKMapView alloc] init];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    panGesture.delegate = self;
    [_mapView addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    pinchGesture.delegate = self;
    [_mapView addGestureRecognizer:pinchGesture];
    
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
    [_manager requestWhenInUseAuthorization];
}

- (void)viewDidLayoutSubviews {
    _mapView.frame = self.view.bounds;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    HELPER_SETTING.fakeLocation = [[CLLocation alloc] initWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    _centerAnnotation.coordinate = _mapView.centerCoordinate;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_manager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!isLocated) {
        isLocated = YES;
        float zoomLevel = 0.05;
        MKCoordinateRegion region = MKCoordinateRegionMake(HELPER_SETTING.fakeLocation.coordinate, MKCoordinateSpanMake(zoomLevel, zoomLevel));
        [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
        _centerAnnotation = [[MKPointAnnotation alloc] init];
        _centerAnnotation.title = @"设置为此位置";
        _centerAnnotation.coordinate = HELPER_SETTING.fakeLocation.coordinate;
        [_mapView addAnnotation:_centerAnnotation];
        [_mapView selectAnnotation:_centerAnnotation animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [_mapView deselectAnnotation:_centerAnnotation animated:YES];
    _centerAnnotation.coordinate = mapView.centerCoordinate;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    _centerAnnotation.coordinate = mapView.centerCoordinate;
    [_mapView selectAnnotation:_centerAnnotation animated:YES];
}

@end
