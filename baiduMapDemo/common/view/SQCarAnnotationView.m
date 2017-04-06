//
//  SQCarAnnotationView.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/3/30.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQCarAnnotationView.h"

#import "SQCustomPaoPaoView.h"

@interface SQCarAnnotationView()

@property (nonatomic, strong) UIImageView               *imgView;

//气泡
@property (nonatomic, strong) SQCustomPaoPaoView        *paopao;

@end

@implementation SQCarAnnotationView


- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //如果不设置annotation的大小，annotation不会响应点击事件
    self.bounds = CGRectMake(0, 0, 15, 30);
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"car"];
    _imgView.frame = CGRectMake(0, 0, 15, 30);
    _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
    
    _paopao = [[SQCustomPaoPaoView alloc] init];
    [self addSubview:_paopao];
    
    
}

- (void)setBearing:(double)bearing
{
    _bearing = bearing;
    _imgView.transform = CGAffineTransformRotate(_imgView.transform, _bearing * M_PI / 180);
}

- (void)setPaopaoTitle:(NSString *)paopaoTitle
{
    _paopao.title = paopaoTitle;
}


@end
