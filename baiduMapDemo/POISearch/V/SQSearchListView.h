//
//  SQSearchView.h
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQSearchListView;

@protocol SQSearchListViewDelegate <NSObject>

- (void)searchListView:(SQSearchListView *)searchView
         tableView:(UITableView *)tableView
didSelectWithIndex:(NSIndexPath *)indexPath;

- (void)scrollViewDidScroll;

@end

@interface SQSearchListView : UIView

@property (nonatomic, weak) id<SQSearchListViewDelegate> delelgate;

@property (nonatomic, strong) NSArray                   *dataSource;

@end
