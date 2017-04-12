//
//  SQPOISearchVC.m
//  baiduMapDemo
//
//  Created by 李景景 on 2017/4/11.
//  Copyright © 2017年 李景景. All rights reserved.
//

#import "SQPOISearchVC.h"



#import "SQSearchListView.h"
#import "SQPOIHelper.h"

@interface SQPOISearchVC ()
<SQSearchListViewDelegate,
UITextFieldDelegate>


@property (nonatomic, strong) UITextField                   *textField;

@property (nonatomic, strong) SQSearchListView              *listView;

@property (nonatomic, strong) SQPOIHelper                   *poiHelper;

@end

@implementation SQPOISearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, kNavBarHeight + 5, kScreenWidth - 100, 30)];
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = [UIColor grayColor].CGColor;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    self.listView = [[SQSearchListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textField.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.textField.frame))];
    self.listView.delelgate = self;
    [self.view addSubview:self.listView];
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 0) {
        [self.poiHelper poiSearchInCityWithKeyword:textField.text city:@"北京"];
        __weak __typeof(self) weakSelf = self;
        [self.poiHelper setPoiResult:^(BMKPoiResult *result) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.listView.dataSource = result.poiInfoList;
        }];
    }
    return YES;
}

#pragma mark - SQSearchListViewDelegate
- (void)searchListView:(SQSearchListView *)searchView tableView:(UITableView *)tableView didSelectWithIndex:(NSIndexPath *)indexPath
{
    BMKPoiInfo *info = searchView.dataSource[indexPath.row];
    if (self.searchAddress) {
        self.searchAddress(info, _addrType);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll
{
    [self.view endEditing:YES];
}

- (SQPOIHelper *)poiHelper
{
    if (!_poiHelper) {
        _poiHelper = [SQPOIHelper poiHelper];
    }
    return _poiHelper;
}

- (void)setAddrType:(AddressType)addrType
{
    _addrType = addrType;
}

- (void)dealloc
{
    [self.poiHelper releaseDlegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
