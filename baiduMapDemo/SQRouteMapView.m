//
//  SQRouteMapView.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/1.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQRouteMapView.h"


#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface SQRouteMapView ()
<BMKMapViewDelegate,
BMKLocationServiceDelegate>


@property (nonatomic, strong) BMKMapView                        *mapView;
@property (nonatomic, strong) BMKLocationService                *locService;


@end

@implementation SQRouteMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupMap];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    
}

- (void)setupMap
{
     self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:self.mapView];
}

- (void)setupLocation
{
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self;
}

#pragma merk - BMKMapViewDelegate
/**
 *地图区域改变完成后会调用此接口
 *@param mapView 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *pin = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([BMKPinAnnotationView class])];
        return pin;
    }
    
    
    return nil;
}


#pragma mark - BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
}

- (void)dealloc
{
    if (self.mapView) {
        self.mapView = nil;
    }
}





@end
