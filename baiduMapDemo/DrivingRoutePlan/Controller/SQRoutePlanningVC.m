//
//  SQRoutePlanningVC.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/3/31.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQRoutePlanningVC.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "SQRouteMapView.h"
#import <CoreLocation/CLLocation.h>

@interface SQRoutePlanningVC ()
<BMKMapViewDelegate,
BMKLocationServiceDelegate>

@property (nonatomic, strong) SQRouteMapView                    *mapView;


@end

@implementation SQRoutePlanningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路线规划";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupMapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewDidDisappear:animated];
}

- (void)setupMapView
{
    self.mapView = [[SQRouteMapView alloc] initWithFrame:self.view.bounds];
    CLLocationCoordinate2D startCoor;
    startCoor.latitude = 39.933740;
    startCoor.longitude = 116.452287;
    
    CLLocationCoordinate2D endCoor;
    endCoor.latitude = 39.935509;
    endCoor.longitude = 116.453321;
    
    self.mapView.starCoordinate = startCoor;
    self.mapView.endCoordinate = endCoor;
    [self.mapView viewWillAppear:YES];
    [self.view addSubview:self.mapView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
