//
//  SQRouteAnnotation.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/5.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SQRouteAnnotation : BMKPointAnnotation
/** 0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 */
@property (nonatomic, assign) NSUInteger                type;
@property (nonatomic, assign) NSInteger                 degree;

@end
