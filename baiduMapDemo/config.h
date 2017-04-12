//
//  config.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#ifndef config_h
#define config_h

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define kNavBarHeight   64

/**
 * 搜索地址type
 **/
typedef enum {
    AddressType_unknown,
    AddressType_start,//开始地址
    AddressType_end,//结束地址
} AddressType;


#endif /* config_h */
