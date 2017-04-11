//
//  SQSearchView.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQSearchListView.h"

#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface SQSearchListView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView                       *tabelView;


@end


@implementation SQSearchListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.tabelView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.showsVerticalScrollIndicator = NO;
    self.tabelView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.tabelView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delelgate && [self.delelgate respondsToSelector:@selector(searchListView:tableView:didSelectWithIndex:)])
    {
        [self.delelgate searchListView:self tableView:tableView didSelectWithIndex:indexPath];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo *poiInfo = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = poiInfo.name;
    return cell;
}

- (void)setDataSource:(NSArray *)dataSource
{
    self.dataSource = dataSource;
    [self.tabelView reloadData];
}

@end