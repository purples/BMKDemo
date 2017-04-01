//
//  ViewController.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/3/27.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "ViewController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "YYModel.h"
#import "SQCarLocationModel.h"
#import "SQCarAnnotationView.h"

#import "SQRoutePlanningVC.h"

#define kScrrenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height

@interface ViewController ()<BMKLocationServiceDelegate, BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView                    *mapView;
@property (nonatomic, strong) BMKUserLocation               *location;
@property (nonatomic, strong) BMKPointAnnotation            *annotation;
@property (nonatomic, strong) BMKLocationService            *locService;
@property (nonatomic, strong) UIImageView                   *pinImgView;
/** 小车位置 */
@property (nonatomic, strong) NSArray                       *carLocationArr;
@property (nonatomic, strong) NSArray                       *oldCarLocArr;

@property (nonatomic, strong) NSMutableArray                *pointAnnotationArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ///地图定位
    [self setupMap];
    [self setupCuurentLocation];
    [self setupMyLocationParam];
    [self setupPinImg];

//    [self getCarLocationData];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(getCarLocationData) userInfo:nil repeats:YES];
    [timer fire];

}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    /// 地图View的Delegate，此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)setupMap
{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScrrenWidth, kScreenHeight)];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.zoomLevel = 19;
    _mapView.showsUserLocation = YES;
    _mapView.rotateEnabled = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    [self.view addSubview:_mapView];
    
}

//动态定制我的位置样式 -- 自定义精度圈
- (void)setupMyLocationParam
{
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
//    param.accuracyCircleFillColor = [UIColor blueColor];
//    param.accuracyCircleStrokeColor = [UIColor purpleColor];
    param.isAccuracyCircleShow = YES;
//    param.locationViewImgName = @"pin_custom@2x";
    [self.mapView updateLocationViewWithParam:param];
}
//开启定位
- (void)setupCuurentLocation
{
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}

//大头针
- (void)setupPinImg
{
    CGFloat w = 20;
    CGFloat h = 50;
    _pinImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScrrenWidth - w) / 2, (kScreenHeight - h) / 2 - 25, w, h)];
    _pinImgView.image = [UIImage imageNamed:@"pin"];
    [self.mapView addSubview:_pinImgView];
}

- (void)addAnnotationView
{
    
    NSMutableArray *mutArr = [NSMutableArray array];
    for (SQCarModel *car in self.carLocationArr) {
        BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D coord;
        coord.latitude = [car.lat doubleValue];
        coord.longitude = [car.lon doubleValue];
        point.coordinate = coord;
        [mutArr addObject:point];
        
   
    }
    self.pointAnnotationArr = mutArr;
    //添加一组标注图
    [_mapView addAnnotations:self.pointAnnotationArr];

    
}

//获取司机位置数据
- (void)getCarLocationData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"carLocation" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    SQCarLocationModel *carList = [SQCarLocationModel yy_modelWithDictionary:dict];
    self.carLocationArr = carList.list;
    
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!self.location) {
        //设置当前地图的中心点，是定位地址显示在地图的中心
        self.mapView.centerCoordinate = userLocation.location.coordinate;
        
    }
    self.location = userLocation;
    [self.mapView updateLocationData:userLocation];
}


#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        SQCarAnnotationView *car = (SQCarAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([SQCarAnnotationView class])];
        if (car == nil) {
            car = [[SQCarAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"car"];
            car.bearing = 45;
            car.alpha = 0;
        }
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            car.alpha = 1.0;
        } completion:nil];
        return car;
    }
    return nil;
}

/**
 *地图区域改变完成后会调用此接
 
 *@param mapView 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%lf   %lf", mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    //如果有小车，应该移除小车annotation
    [self removeAnnotation];
    //获取附近小车数据
    //添加标注，注意旋转角（还有新老数据对比）
    [self addAnnotationView];
    
}

- (void)removeAnnotation
{
    //移除一组标注及标注自定义view
    [_mapView removeAnnotations:self.pointAnnotationArr];
    [self.pointAnnotationArr removeAllObjects];
}


- (void)setCarLocationArr:(NSArray *)carLocationArr
{
    _carLocationArr = carLocationArr;
    /*  1、将旧数据与新数据进行合并
        2、进行绘制标注图 
            已存在的变换旋转角度及位置
            新出现的添加annotation
            已不存在的删除annotation
    */
    if (self.oldCarLocArr.count == carLocationArr.count) {
        for (int i = 0; i < self.pointAnnotationArr.count; i++) {
            BMKPointAnnotation *point = self.pointAnnotationArr[i];
            SQCarAnnotationView *car = (SQCarAnnotationView *)[self.mapView viewForAnnotation:point];
            [UIView animateWithDuration:0.5 animations:^{
//                SQCarModel *m = self.oldCarLocArr[i];
//                car.bearing = m.bearing;
                car.bearing = 45;
                car.paopaoTitle = @"hahah";
            }completion:^(BOOL finished) {
                //帧动画
                [UIView animateKeyframesWithDuration:4.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                    point.coordinate = CLLocationCoordinate2DMake(39.934022, 116.454584);
                } completion:nil];
            }];
        }
        } else {
        [self addAnnotationView];
    }
    self.oldCarLocArr = carLocationArr;
}

#pragma mark - 路线规划
- (IBAction)rightBarButtonClicked:(id)sender {
    SQRoutePlanningVC *planVC = [[SQRoutePlanningVC alloc] init];
    planVC.currentLocation = self.location;
    [self.navigationController pushViewController:planVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
