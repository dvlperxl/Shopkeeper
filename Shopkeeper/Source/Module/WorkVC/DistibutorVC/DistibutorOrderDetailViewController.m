//
//  DistibutorOrderDetailViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderDetailViewController.h"

//views
#import "StockOrderDetailHeaderView.h"


//models
#import "DistibutorOrderDetailModel.h"

@interface DistibutorOrderDetailViewController ()

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)StockOrderDetailHeaderView *tableHeaderView;

@end

@implementation DistibutorOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    [self httpRequestQueryOrderDetail];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
}

#pragma mark - request

- (void)httpRequestQueryOrderDetail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share] httpRequestQueryDistibutorOrderDetailWithStoreId:nil
                                                                retailId:self.retailNo
                                                                 success:^(id responseObject) {
                                                                     
                                                                     [KKProgressHUD hideMBProgressForView:self.view];
                                                                     self.tableView.tableViewModel = [DistibutorOrderDetailModel orderDetailTableViewModel:responseObject];
                                                                     
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestQueryOrderDetail];
                                                                                   
                                                                               }] ];
        
    }];
}



#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"分销订单详情";
    [self.view addSubview:self.tableView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    return _tableView;
}

- (StockOrderDetailHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[StockOrderDetailHeaderView alloc]init];
        _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
    }
    return _tableHeaderView;
}



@end
