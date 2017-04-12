//
//  SQSelectAddressView.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQSelectAddressView : UIView

@property (nonatomic, copy) void (^selectStartAddress)();

@property (nonatomic, copy) void (^selectEndAddress)();

- (void)addressName:(NSString *)name addressType:(AddressType)addressType;

@end
