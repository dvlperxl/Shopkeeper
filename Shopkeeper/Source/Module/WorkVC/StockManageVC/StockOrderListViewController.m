//
//  StockOrderListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockOrderListViewController.h"
#import "StockManageModel.h"

@interface StockOrderListViewController ()

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)StockManageModel *stockManageModel;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;

@end

@implementation StockOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
//    [self setScrollViewInsets:@[self.tableView]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.pageNo = 1;
    [self httpRequestGetConfirmedOrderList];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}


#pragma mark - http request

- (void)httpRequestGetConfirmedOrderList
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestGetMallOrderList:self.storeId
                                            pageNo:self.pageNo
                                          pageSize:20
                                          retailNo:nil
                                            status:self.status
                                          fromType:self.fromType
                                           success:^(NSDictionary *responseObject) {
                                               
                                               [KKProgressHUD hideMBProgressForView:self.view];
                                               
                                               if (self.pageNo == 1)
                                               {
                                                   self.stockManageModel = nil;
                                               }
                                               
                                               KKTableViewModel *tableViewModel = [self.stockManageModel tableViewModelInsertDataList:(NSArray*)responseObject];
                                               self.tableView.tableViewModel = tableViewModel;
                                               
                                               self.pageNo +=1;
                                               self.tableView.mj_footer = self.footer;
                                               if (responseObject.count==20)
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
                                                                                                            
                                                                                                            [weakSelf httpRequestGetConfirmedOrderList];
                                                                                                            
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
    
//
//    [[APIService share]httpRequestGetConfirmedPurchasesByCond:self.storeId
//                                                       pageNo:self.pageNo
//                                                     pageSize:20
//                                                     retailNo:nil
//                                                      success:^(NSDictionary *responseObject) {
//
//
//
//
//
//                                                      } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
//
//
//                                                      }];
}


#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}


- (StockManageModel *)stockManageModel
{
    if (!_stockManageModel) {
        
        _stockManageModel = [StockManageModel new];
        _stockManageModel.status = self.status;
        _stockManageModel.fromType = self.fromType;
        _stockManageModel.storeId = self.storeId;
    }
    return _stockManageModel;
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


- (MJRefreshAutoGifFooter *)footer
{
    if (!_footer) {
        
        __weak StockOrderListViewController *weakSelf = self;
        
        _footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            
            if (weakSelf) {
                
                [weakSelf httpRequestGetConfirmedOrderList];
            }
            
        }];
        
    }
    return _footer;
}


@end
