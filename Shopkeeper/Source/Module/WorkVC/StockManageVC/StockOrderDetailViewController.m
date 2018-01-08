//
//  StockOrderDetailViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockOrderDetailViewController.h"
#import "StockOrderDetailHeaderView.h"
#import "OrderDetailBottomView.h"
#import "StockOrderDetailModel.h"

@interface StockOrderDetailViewController ()
<OrderDetailBottomViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)StockOrderDetailHeaderView *tableHeaderView;
@property(nonatomic,strong)OrderDetailBottomView *orderDetailBottomView;

@end

@implementation StockOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self httpRequestQueryStorePurchaseById];
    [self initSubviews];
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
    
    [self.orderDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        
    }];
}


#pragma mark - request

- (void)httpRequestQueryStorePurchaseById
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryStorePurchaseById:self.orderId
                                                  status:self.status
                                                     tag:self.tag
                                                 success:^(NSDictionary *responseObject) {
                                                     
                                                     [KKProgressHUD hideMBProgressForView:self.view];
                                                     self.tableView.tableViewModel = [StockOrderDetailModel tableViewModel:responseObject tag:self.tag status:self.status];
                                                     [self.tableHeaderView reloadData:self.tableView.tableViewModel.headerViewModel];
                                                     
                                                     NSString *retailStatus = responseObject[@"retailStatus"];
                                                     if ([retailStatus isEqualToString:@"2"])
                                                     {
                                                         self.orderDetailBottomView.hidden  = NO;
                                                     }else
                                                     {
                                                         self.orderDetailBottomView.hidden  = YES;
                                                     }
                                                     
                                                 } failure:^(NSNumber *errorCode,
                                                             NSString *errorMsg,
                                                             NSDictionary *responseObject) {
                                                     
                                                     [KKProgressHUD hideMBProgressForView:self.view];
                                                     __weak typeof(self) weakSelf = self;
                                                     [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                                            tapBlock:^{
                                                                                                                                
                                                                                                                                [weakSelf httpRequestQueryStorePurchaseById];
                                                                                                                                
                                                                                                                            }] ];
                                                     
                                                 }];
}

- (void)httpReuqestConfirmReceipt
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestConfirmReceipt:self.orderId
                                         storeId:self.storeId
                                         success:^(NSDictionary *responseObject) {
                                             
                                             [KKProgressHUD hideMBProgressForView:self.view];
                                             [[CMRouter sharedInstance]popViewController];
                                             
                                         } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                             
                                             [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
                                             
                                         }];
    
}


- (void)orderDetailBottomViewDidSelectBottomButtonIndex:(NSInteger)index
{
    [self httpReuqestConfirmReceipt];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"自营订单详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.orderDetailBottomView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.tableHeaderView;
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        footerView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = footerView;
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

- (OrderDetailBottomView *)orderDetailBottomView
{
    if (!_orderDetailBottomView)
    {
        NSArray *titles = @[@"确认收货"];
        _orderDetailBottomView = [OrderDetailBottomView orderDetailBottomViewWithButtonTitles:titles];
        _orderDetailBottomView.delegate = self;
        _orderDetailBottomView.hidden = YES;
    }
    return _orderDetailBottomView;
}


@end
