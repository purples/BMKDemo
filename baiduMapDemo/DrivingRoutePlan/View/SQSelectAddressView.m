//
//  SQSelectAddressView.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQSelectAddressView.h"

#define height 25

@interface SQSelectAddressView ()

@property (nonatomic, strong) UIButton                           *startBtn;
@property (nonatomic, strong) UIButton                           *endBtn;


@end

@implementation SQSelectAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBtn.frame = CGRectMake(0, 0, self.bounds.size.width, height);
    self.startBtn.layer.cornerRadius = 3;
    self.startBtn.layer.borderWidth = 1;
    self.startBtn.layer.masksToBounds = YES;
    [self.startBtn setTitle:@"输入起点" forState:UIControlStateNormal];
    [self.startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn.tag = 1;
    [self addSubview:self.startBtn];
    
    self.endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endBtn.frame = CGRectMake(0, height + 5, self.bounds.size.width, height);
    self.endBtn.layer.cornerRadius = 3;
    self.endBtn.layer.borderWidth = 1;
    self.endBtn.layer.masksToBounds = YES;
    [self.endBtn setTitle:@"输入终点" forState:UIControlStateNormal];
    [self.endBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.endBtn addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
    self.endBtn.tag = 2;
    [self addSubview:self.endBtn];
    
}

- (void)selectAddress:(UIButton *)button
{
    if (button.tag == 1) {
        self.selectStartAddress(button);
    } else if (button.tag == 2) {
        self.selectEndAddress(button);
    }
}

- (void)addressName:(NSString *)name addressType:(AddressType)addressType
{
    switch (addressType) {
            
        case AddressType_start:
            [self.startBtn setTitle:name forState:UIControlStateNormal];
            break;
            
        case AddressType_end:
            [self.endBtn setTitle:name forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}


@end
