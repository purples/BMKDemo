
//
//  SQPOIHelper.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQPOIHelper.h"

@interface SQPOIHelper ()<BMKPoiSearchDelegate>

@property (nonatomic, strong) BMKPoiSearch                  *search;


@end

@implementation SQPOIHelper

+ (instancetype)poiHelper
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (_search) {
        _search = [[BMKPoiSearch alloc] init];
        _search.delegate = self;

    }
    return self;
}

- (void)releaseDlegate
{
    _search.delegate = nil;
}

- (void)poiSearchInCityWithKeyword:(NSString *)keyword city:(NSString *)city
{
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc] init];
    option.keyword = keyword;
    option.city = city;
    option.pageIndex = 0;
    option.pageCapacity = 20;
   BOOL flag = [_search poiSearchInCity:option];
    if (flag) {
        NSLog(@"发送检索成功");
    } else {
        NSLog(@"发送检索失败");
    }
}

#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        self.poiResult(poiResult);
    } else {
        NSLog(@"%d", errorCode);
    }
}


@end
