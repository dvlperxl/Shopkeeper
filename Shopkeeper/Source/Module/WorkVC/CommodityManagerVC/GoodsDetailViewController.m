//
//  GoodsDetailViewController.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailModel.h"

@interface GoodsDetailViewController ()<UITableViewDelegate>

@property (nonatomic,strong) GoodsDetailModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self loadData];
}
- (void)setupUI {
    self.navigationItem.title = @"商品详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onEditAction)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
- (void)loadData {
    [[APIService share]httpRequestQueryGoodsDetailWithId:self.goodsId success:^(NSDictionary *responseObject) {
        [self.viewModel setGoodsInfoDic:responseObject];
        self.tableView.tableViewModel = self.viewModel.tableViewModel;
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
    }];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}
#pragma mark - event
- (void)onEditAction {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:self.viewModel.categoryList forKey:@"categoryList"];
    [param setObject:self.viewModel.goodsInfoDic forKey:@"goodsDic"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"AddGoodsViewController" param:param];
}
#pragma mark - getter,setter
- (void)setStoreId:(NSString *)storeId {
    _storeId = storeId;
    if (_viewModel) {
        _viewModel = nil;
    }
}
- (void)setCategoryList:(NSArray *)categoryList {
    _categoryList = categoryList;
    self.viewModel.categoryList = categoryList;
}
- (GoodsDetailModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GoodsDetailModel alloc]initWithStoreId:self.storeId];
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
