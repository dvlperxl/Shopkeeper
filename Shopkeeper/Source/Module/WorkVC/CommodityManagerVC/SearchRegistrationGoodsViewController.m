//
//  SearchRegistrationGoodsViewController.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SearchRegistrationGoodsViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "SearchRegistrationGoodsModel.h"
#import "HNSearchController.h"
#import "SearchRegistrationGoodsCell.h"
#import "SearchRegistrationGoodsToast.h"

@interface SearchRegistrationGoodsViewController ()<UITableViewDelegate,HNSearchControllerDelegate>

@property (nonatomic,strong) SearchRegistrationGoodsModel *viewModel;
/** searchcontroller*/
@property(nonatomic, strong) HNSearchController *searchController;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,strong) SearchRegistrationGoodsToast *toastView;
@end

@implementation SearchRegistrationGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchController.hn_searchBar becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchController.hn_searchBar resignFirstResponder];
}
- (void)setupUI {
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelAction)];
    self.searchController.hn_searchDelegate = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [self.view addSubview:self.toastView];
}
- (void)loadMoreSearchData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel getNextPageSuccess:^(KKTableViewModel *tableModel, BOOL hasMore) {
         weakSelf.tableView.tableViewModel = tableModel;
        if (hasMore) {
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSString *errorMsg) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - HNSearchControllerDelegate
/**  字符改变的回调方法*/
- (void)hn_updateSearchResultsForSearchController:(HNSearchController *)searchController searchText:(NSString *)searchText {
  
}
/** 点击搜索回调方法*/
- (void)hn_SearchControllerSearchButtonClick:(HNSearchController *)searchController {
    [self.toastView removeFromSuperview];
    __weak typeof(self) weakSelf = self;
    [self.viewModel getTableViewModelWithSearchKey:searchController.hn_searchBar.text success:^(KKTableViewModel *tableModel, BOOL hasMore) {
        weakSelf.tableView.tableViewModel = tableModel;
        _tableView.mj_footer.hidden = NO;
    } failure:^(NSString *errorMsg) {
        
    }];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KKSectionModel *section = self.tableView.tableViewModel.sectionDataList[indexPath.section];
    if (section) {
        KKCellModel *cellModel = section.cellDataList[indexPath.row];
        SearchRegistrationGoodsCellModel *cellData = cellModel.data;
        NSMutableDictionary *actionDic = @{}.mutableCopy;
        [actionDic setObject:@"registrationGoods" forKey:@"action"];
        
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:cellData.sn forKey:@"registrationNo"];
        [dic setObject:cellData.category forKey:@"goodsCategory"];
        [dic setObject:cellData.toxicity forKey:@"toxicity"];
        [dic setObject:cellData.name forKey:@"goodsName"];
        [dic setObject:cellData.company forKey:@"companyName"];
        [dic setObject:cellData.formulation forKey:@"formulation"];
       
        [actionDic setObject:dic forKey:@"parameters"];
        
        [[CMRouter sharedInstance]backToViewController:@"AddGoodsViewController" param:@{@"callBack":actionDic}];
    }
    
}
#pragma mark - event
- (void)onCancelAction {
    [[CMRouter sharedInstance]popViewController];
}
#pragma mark - getter,setter
- (SearchRegistrationGoodsModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SearchRegistrationGoodsModel alloc]init];
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins: UIEdgeInsetsZero];
        }
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSearchData)];
        _tableView.mj_footer.hidden = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (HNSearchController *)searchController {
    if (!_searchController) {
        _searchController = [[HNSearchController alloc] initWithSearchResultsController:nil];
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        if (@available(iOS 11, *)) {
            UIView *searchView = [[UIView alloc]init];
            searchView.backgroundColor = [UIColor clearColor];
            self.navigationItem.titleView = searchView;
            [searchView.heightAnchor constraintEqualToConstant:44].active = YES;
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            [searchView.widthAnchor constraintEqualToConstant:screenWidth - 60].active = YES;
            _searchController.hn_searchBar.frame = CGRectMake(0, 0, screenWidth - 60, 44);
            [searchView addSubview:_searchController.hn_searchBar];
        } else {
            _searchController.hn_searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width , 44);
            self.navigationItem.titleView = _searchController.hn_searchBar;
        }
    }
    return _searchController;
}
- (SearchRegistrationGoodsToast *)toastView {
    if (!_toastView) {
        _toastView = [SearchRegistrationGoodsToast searchRegistrationToast];
    }
    return _toastView;
}
@end
