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
#import "SQCarAnnotationView.h"

#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "SQRouteAnnotation.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface SQRouteMapView ()
<BMKMapViewDelegate,
BMKLocationServiceDelegate,
BMKRouteSearchDelegate>


@property (nonatomic, strong) BMKMapView                        *mapView;
@property (nonatomic, strong) BMKLocationService                *locService;
//用户位置
@property (nonatomic, strong) BMKUserLocation                   *userLocation;

@property (nonatomic, strong) BMKRouteSearch                    *routeSearch;





@end

@implementation SQRouteMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupMap];
        [self setupLocation];
        [self setupParam];
       
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.routeSearch.delegate = self;//不用时置为nil，防止内存泄漏
    //视图将要出现时开始搜索路线
    [self setupRouteSearch];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.routeSearch.delegate = nil;
    
}

- (void)setupMap
{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.zoomLevel = 19;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;

    [self addSubview:self.mapView];
}

- (void)setupLocation
{
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self;
    //开始定位
    [self.locService startUserLocationService];
}

- (void)setupParam
{
    BMKLocationViewDisplayParam *para = [[BMKLocationViewDisplayParam alloc] init];
    para.isAccuracyCircleShow = YES;
    //动态定制我的位置样式
    [self.mapView updateLocationViewWithParam:para];
}

- (void)setupRouteSearch
{
    self.routeSearch = [[BMKRouteSearch alloc] init];
    _routeSearch.delegate = self;
    
    ///线路检索节点信息
    BMKPlanNode *starNode = [[BMKPlanNode alloc] init];
//    starNode.name = @"起点";
//    starNode.cityName = @"北京";//两者同时设定，检索结果会出错，<检索地址有岐义>
    starNode.pt = self.starCoordinate;
    
    BMKPlanNode *endNode = [[BMKPlanNode alloc] init];
//    endNode.name = @"终点";
//    endNode.cityName = @"北京";
    endNode.pt = self.endCoordinate;
    
    /// 路线查询基础信息类
    BMKDrivingRoutePlanOption *drivingPlan = [[BMKDrivingRoutePlanOption alloc] init];
    drivingPlan.from = starNode;
    drivingPlan.to = endNode;
    ///驾乘路线检索
    ///异步函数，返回结果在BMKRouteSearchDelegate的onGetDrivingRouteResult通知
    BOOL flag = [self.routeSearch drivingSearch:drivingPlan];
    
    if(flag)
    {
        NSLog(@"search success.");
    }
    else
    {
        NSLog(@"search failed!");
    }

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
        SQRouteAnnotation *routePoint = (SQRouteAnnotation *)annotation;
        
        BMKAnnotationView *view = nil;
        switch (routePoint.type) {
            case 0://起点
            case 1://终点
            {
                view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
                if (view == nil) {
                    view = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"start_node"];
                    view.image = [UIImage imageNamed:@"pin"];
                }
                view.annotation = annotation;
            }
                break;
                
            case 4://驾乘点
//                SQCarAnnotationView *car = [mapView ];
                view = [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([SQCarAnnotationView class])];
                if (view == nil) {
                    view = [[SQCarAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([SQCarAnnotationView class])];
                    view.image = [UIImage imageNamed:@"car"];
                }
                view.annotation = annotation;

                
                break;
                
            default:
                break;
        }
        return view;
    }
    
    
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
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
    if (!self.userLocation) {
        self.mapView.centerCoordinate = userLocation.location.coordinate;
    }
    self.userLocation = userLocation;
    //动态更新我的位置数据,如果不更新，不会在地图上显示当前位置✨✨✨✨✨✨
    [self.mapView updateLocationData:userLocation];
    
}

#pragma mark - BMKRouteSearchDelegate
- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    //移除所有的标注和地图覆盖物（overlay）
    NSArray *array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
    
    if (error == BMK_OPEN_NO_ERROR) {
        ///此类表示一条驾车路线
        BMKDrivingRouteLine *planLine = (BMKDrivingRouteLine *)[result.routes objectAtIndex:0];
        NSLog(@"%d, %d",planLine.duration.minutes, planLine.distance);
        //计算路线方案中的路段数目
        NSInteger size = planLine.steps.count;
        
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep *step = planLine.steps[i];
            if (i == 0) {
                SQRouteAnnotation *startPoint = [[SQRouteAnnotation alloc] init];
                startPoint.coordinate = planLine.starting.location;
                startPoint.title = @"起点";
                startPoint.type = 0;
                //添加起点标注
                [self.mapView addAnnotation:startPoint];
                
            } else if (i == size - 1) {
                //添加终点标注
                SQRouteAnnotation *end = [[SQRouteAnnotation alloc] init];
                end.coordinate = planLine.terminal.location;
                end.title = @"终点";
                end.type = 1;
                [self.mapView addAnnotation:end];
            }
            
            //轨迹点总数累计
            planPointCounts += step.pointsCount;
        }
        //添加途经点
        
        //轨迹点
        BMKMapPoint tempPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep *step = planLine.steps[j];
            for (int k = 0; k < step.pointsCount; k++) {
                tempPoint[i].x = step.points[k].x;
                tempPoint[i].y = step.points[k].y;
                i++;
            }
        }
        
        //通过points构建BMKPolyline,根据指定坐标点生成一段折线
        BMKPolyline *polyLine = [BMKPolyline polylineWithPoints:tempPoint count:planPointCounts];
        [self.mapView addOverlay:polyLine];
        //调整地图范围
        [self mapViewFitPolyLine:polyLine];
       
    }
    
    SQRouteAnnotation *p = [[SQRouteAnnotation alloc] init];
    p.coordinate = self.userLocation.location.coordinate;
    p.type = 1;
    [_mapView addAnnotation:p];
    
    
}



//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}




- (void)setStarCoordinate:(CLLocationCoordinate2D)starCoordinate
{
    _starCoordinate = starCoordinate;

}

- (void)setEndCoordinate:(CLLocationCoordinate2D)endCoordinate
{
    _endCoordinate = endCoordinate;
}


- (void)dealloc
{
    if (self.mapView) {
        self.mapView = nil;
    }
}





@end
