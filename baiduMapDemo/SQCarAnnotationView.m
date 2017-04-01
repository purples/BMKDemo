//
//  SQCarAnnotationView.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/3/30.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQCarAnnotationView.h"


@interface SQCarAnnotationView()

@property (nonatomic, strong) UIImageView               *imgView;

@property (nonatomic, strong) UILabel                   *label;

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
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, -_imgView.bounds.size.height / 2, 50, 20)];
    [self addSubview:_label];
    [self addSubview:_imgView];
}

- (void)setBearing:(double)bearing
{
    _bearing = bearing;
    _imgView.transform = CGAffineTransformRotate(_imgView.transform, _bearing * M_PI / 180);
}

- (void)setPaopaoTitle:(NSString *)paopaoTitle
{
    _label.text = paopaoTitle;
}


@end
