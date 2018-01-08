//
//  DistibutorOrderSearchViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderSearchViewController.h"
#import "HNSearchController.h"
#import "DistibutorOrderSearchViewModel.h"

@interface DistibutorOrderSearchViewController ()<HNSearchControllerDelegate>

/** searchcontroller*/
@property(nonatomic, strong) HNSearchController *searchController;
@property(nonatomic, strong) KKTableView *tableView;
@property(nonatomic, strong) KKTableViewModel *tableViewModel;
@property(nonatomic, strong) DistibutorOrderSearchViewModel *model;

@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;
@property(nonatomic,strong)NSString *searchString;

@end

@implementation DistibutorOrderSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    self.tableView.tableViewModel = [self.model tableModel:@[] searchString:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchController.hn_searchBar becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchController.hn_searchBar resignFirstResponder];
}

- (void)httpRequestGetOrderList:(NSString*)searchString
{
    [[APIService share]httpRequestQueryDistibutorOrderListWithStoreId:self.storeId
                                                                param:nil
                                                                state:self.state
                                                               pageNo:self.pageNo
                                                             pageSize:20
                                                              success:^(id responseObject) {
                                                                  
                                                                  if (self.pageNo == 1)
                                                                  {
                                                                      self.model = nil;
                                                                  }
                                                                  
                                                                  self.tableView.tableViewModel = [self.model tableModel:responseObject searchString:searchString];
                                                                  
                                                                  self.pageNo +=1;
                                                                  self.tableView.mj_footer = self.footer;
                                                                  if ([responseObject count]==20)
                                                                  {
                                                                      [self.tableView.mj_footer endRefreshing];
                                                                      
                                                                  }else
                                                                  {
                                                                      [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                                                  }

                                                                  
                                                              } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                                  [self.tableView.mj_footer endRefreshing];

                                                                  if (self.tableView.tableViewModel.sectionDataList == 0) {
                                                                      
                                                                      [KKProgressHUD hideMBProgressForView:self.view];
                                                                      __weak typeof(self) weakSelf = self;
                                                                      
                                                                      KKLoadFailureAndNotResultView *resultView = [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                                                                                  tapBlock:^{
                                                                                                                                                                      
                                                                                                                                                                      [weakSelf httpRequestGetOrderList:searchString];
                                                                                                                                                                      
                                                                                                                                                                  }];
                                                                      
                                                                      [self.view addSubview:resultView];
                                                                      
                                                                      [resultView mas_remakeConstraints:^(MASConstraintMaker *make) {
                                                                          
                                                                          make.edges.equalTo(self.view);
                                                                      }];
                                                                      
                                                                  }else
                                                                  {
                                                                      [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
                                                                  }
                                                                  
                                                              }];
}

#pragma mark - event
- (void)onCancelAction {
    [[CMRouter sharedInstance]popViewController];
}

#pragma mark - HNSearchControllerDelegate
/**  字符改变的回调方法*/
- (void)hn_updateSearchResultsForSearchController:(HNSearchController *)searchController searchText:(NSString *)searchText {
    
}
/** 点击搜索回调方法*/
- (void)hn_SearchControllerSearchButtonClick:(HNSearchController *)searchController {
    
    self.pageNo = 1;
    self.model = nil;
    self.searchString = searchController.hn_searchBar.text;
    [self httpRequestGetOrderList:searchController.hn_searchBar.text];
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
}


#pragma mark - getter,setter


- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.delegate = self;
//        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            [_tableView setSeparatorInset: UIEdgeInsetsZero];
//        }
//        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//            [_tableView setLayoutMargins: UIEdgeInsetsZero];
//        }
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSearchData)];
//        _tableView.mj_footer.hidden = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (DistibutorOrderSearchViewModel *)model
{
    if (!_model) {
        
        _model = [DistibutorOrderSearchViewModel new];
    }
    return _model;
}


- (HNSearchController *)searchController {
    if (!_searchController) {
        _searchController = [[HNSearchController alloc] initWithSearchResultsController:nil];
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.hn_searchBar.placeholder = @"输入订单号、供应商名称";
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

- (MJRefreshAutoGifFooter *)footer
{
    if (!_footer) {
        
        __weak DistibutorOrderSearchViewController *weakSelf = self;
        
        _footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            
            if (weakSelf) {
                
                [weakSelf httpRequestGetOrderList:self.searchString];
            }
            
        }];
        
    }
    return _footer;
}

@end
