//
//  SQCarAnnotationView.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/3/30.
//  Copyright © 2017年 李景景. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SQCarAnnotationView : BMKAnnotationView
/** 图片名称 */
@property (nonatomic, strong) NSString                  *imgName;

/** 旋转角 */
@property (nonatomic, assign) double                    bearing;

/** 泡泡 */
@property (nonatomic, copy) NSString                    *paopaoTitle;

@end
