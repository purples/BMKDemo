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

@interface SQRoutePlanningVC ()
<BMKMapViewDelegate,
BMKLocationServiceDelegate>



@end

@implementation SQRoutePlanningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路线规划";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
