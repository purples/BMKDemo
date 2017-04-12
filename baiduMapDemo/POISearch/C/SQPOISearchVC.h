//
//  SQPOISearchVC.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMKPoiInfo;

@interface SQPOISearchVC : UIViewController

@property (nonatomic, copy) void(^searchAddress)(BMKPoiInfo *poiInfo, AddressType type);

@property (nonatomic, assign) AddressType                       addrType;

@end
