//
//  DistibutorOrderListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderListViewController.h"
#import "DistibutorManageModel.h"

@interface DistibutorOrderListViewController ()

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)DistibutorManageModel *model;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;


@end

@implementation DistibutorOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    self.pageNo = 1;
    [self httpRequestGetOrderList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - http request

- (void)httpRequestGetOrderList
{
    [KKProgressHUD showMBProgressAddTo:self.view];

    [[APIService share]httpRequestQueryDistibutorOrderListWithStoreId:self.storeId
                                                                param:nil
                                                                state:self.state
                                                               pageNo:self.pageNo
                                                             pageSize:20
                                                              success:^(id responseObject) {
                                                                  
                                                                  [KKProgressHUD hideMBProgressForView:self.view];
                                                                  
                                                                  if (self.pageNo == 1)
                                                                  {
                                                                      self.model = nil;
                                                                  }
        
                                                                  self.tableView.tableViewModel = [self.model tableViewModel:responseObject];
                                                                  
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
                                                                                                            
                                                                                                            [weakSelf httpRequestGetOrderList];
                                                                                                            
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

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(DistibutorManageModel *)model
{
    if (!_model) {
        
        _model = [DistibutorManageModel new];
    }
    return _model;
}

- (MJRefreshAutoGifFooter *)footer
{
    if (!_footer) {
        
        __weak DistibutorOrderListViewController *weakSelf = self;
        
        _footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            
            if (weakSelf) {
                
                [weakSelf httpRequestGetOrderList];
            }
            
        }];
        
    }
    return _footer;
}


@end
