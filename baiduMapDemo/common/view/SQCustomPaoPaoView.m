//
//  SQCustomPaoPaoView.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/6.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQCustomPaoPaoView.h"

#define kheight                         32

@interface SQCustomPaoPaoView ()

@property (nonatomic, strong) UILabel                               *label;

@end


@implementation SQCustomPaoPaoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    _label.font = [UIFont systemFontOfSize:12];
    [self addSubview:_label];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setHiddenPaoPaoView:(BOOL)hiddenPaoPaoView
{
    self.hidden = hiddenPaoPaoView;
}

- (void)layoutSubviews
{
    CGSize size = [self sizeWithLabelText:_title];
    _label.frame = CGRectMake(0, -25, size.width, kheight);
    _label.center = CGPointMake(self.superview.bounds.size.width / 2, - kheight / 2 - 2);
}

- (CGSize)sizeWithLabelText:(NSString *)text
{
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, kheight)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}
                                     context:nil].size;
    return size;
}


@end
