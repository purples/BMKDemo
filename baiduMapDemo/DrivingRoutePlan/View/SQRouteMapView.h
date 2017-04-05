//
//  SQRouteMapView.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/1.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CLLocation.h>

@class BMKUserLocation;

@interface SQRouteMapView : UIView

////用户位置
//@property (nonatomic, strong) BMKUserLocation                       *userLocation;
//
//起点
@property (nonatomic, assign) CLLocationCoordinate2D                  starCoordinate;
//终点
@property (nonatomic, assign) CLLocationCoordinate2D                  endCoordinate;


- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@end
