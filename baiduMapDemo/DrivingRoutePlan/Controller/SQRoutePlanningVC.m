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

#import "SQSelectAddressView.h"
#import "SQPOISearchVC.h"

@interface SQRoutePlanningVC ()
<BMKMapViewDelegate,
BMKLocationServiceDelegate>

@property (nonatomic, strong) SQRouteMapView                    *mapView;
@property (nonatomic, strong) SQSelectAddressView               *selectAddrView;


@end

@implementation SQRoutePlanningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路线规划";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight);
    [self setupSelectAddrView];
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
    self.mapView = [[SQRouteMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectAddrView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.selectAddrView.frame))];
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

- (void)setupSelectAddrView
{
    self.selectAddrView = [[SQSelectAddressView alloc] initWithFrame:CGRectMake(55, kNavBarHeight, kScreenWidth - 100, 60)];
    __weak __typeof(self)weakSelf = self;
    [self.selectAddrView setSelectStartAddress:^(UIButton *btn){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf searchAddress];
    }];
    
    [self.selectAddrView setSelectEndAddress:^(UIButton *btn){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf searchAddress];
    }];
    
    [self.view addSubview:self.selectAddrView];
}

#pragma mark - POI搜索
- (void)searchAddress
{
    SQPOISearchVC *searchVC = [[SQPOISearchVC alloc] init];
//    [self presentViewController:searchVC animated:YES completion:nil];
    [self.navigationController pushViewController:searchVC animated:YES];
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
