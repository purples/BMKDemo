//
//  SQCarLocationModel.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/3/30.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQCarModel;

@interface SQCarLocationModel : NSObject

@property (nonatomic, strong) NSArray<SQCarModel *>               *list;


@end

@interface SQCarModel : NSObject


//经度
@property (nonatomic, copy) NSString                *lon;

//维度
@property (nonatomic, copy) NSString                *lat;

//id
@property (nonatomic, copy) NSString                *car_id;

//方向角
@property (nonatomic, assign) double                bearing;

@end
