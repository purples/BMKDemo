//
//  SQPOIHelper.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface SQPOIHelper : NSObject

@property (nonatomic, copy) void(^poiResult)(BMKPoiResult *result);

/**
 * 初始化
 */
+ (instancetype)poiHelper;

/**
 * 代理置为nil
 */
- (void)releaseDlegate;

/**
 * 城市内POI检索
 * @parma keyword 搜索词
 * @parma city 区域名称(市或区的名字，如北京市，海淀区)，必选, 必须最长25个字符
 */
- (void)poiSearchInCityWithKeyword:(NSString *)keyword city:(NSString *)city;

@end
