//
//  OrderDetailViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailModel.h"
#import "OrderDetailMerchandiseCell2.h"
#import "OrderDetailBottomView.h"


@interface OrderDetailViewController ()
<OrderDetailMerchandiseCell2Delegate,
UITableViewDelegate,
OrderDetailBottomViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)OrderDetailModel *dataModel;
@property(nonatomic,strong)OrderDetailBottomView *orderDetailBottomView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    [self initSubviews];

    if (self.status.integerValue == 9)
    {
        [self httpRequestReturnOrderDetail];

    }else
    {
        [self httpRequestOrderDetail];

    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.dataModel) {
        
        if ([self.dataModel showBottomView])
        {
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.right.offset(0);
                 make.top.equalTo(self.mas_topLayoutGuide);
                make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-60);
             }];
            
            [self.view addSubview:self.orderDetailBottomView];
            [self.orderDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.offset(0);
                make.height.mas_equalTo(60);
               make.bottom.equalTo(self.mas_bottomLayoutGuide);

            }];
            
        }else
        {
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
                make.top.equalTo(self.mas_topLayoutGuide);
               make.bottom.equalTo(self.mas_bottomLayoutGuide);
                
            }];
        }
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - http reuest


/**
 获取订单详情
 */
- (void)httpRequestOrderDetail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryOrderDetail:self.orderId
                                           success:^(NSDictionary *responseObject)
    {
                                               [KKProgressHUD hideMBProgressForView:self.view];
                                               self.dataModel = [OrderDetailModel orderDetailModel:responseObject orderStatus:self.status];
                                               self.tableView.tableViewModel = [self.dataModel tableViewModel];
    
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
       
        [KKProgressHUD hideMBProgressForView:self.view];

        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestOrderDetail];
                                                                                   
                                                                               }] ];
        
    }];
}

/**
 获取退货订单详情
 */
- (void)httpRequestReturnOrderDetail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryReturnDetail:self.orderId
                                            success:^(NSDictionary *responseObject)
     {
                                                [KKProgressHUD hideMBProgressForView:self.view];
         self.dataModel = [OrderDetailModel orderDetailModel:responseObject orderStatus:self.status];
         self.tableView.tableViewModel = [self.dataModel tableViewModel];
    
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
        
        __weak typeof(self) weakSelf = self;
        
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestReturnOrderDetail];
                                                                                   
                                                                               }] ];
    }];
}


/**
 待确认订单-撤销订单

 @param type type=0(撤销订单)  1(确认)
 @param retail 订单详情
 */
- (void)httpRequestConfirmStoreRetailWithType:(NSNumber*)type
                                       retail:(NSDictionary*)retail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestConfirmStoreRetailWithType:type
                                                      retail:retail
                                                     success:^(NSDictionary *responseObject) {
                                                         
                                                         [KKProgressHUD showReminder:self.view message:@"操作成功"];
                                                         [[CMRouter sharedInstance]popViewController];

        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
       
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

    }];
}

- (void)httpRequestSetStoreRetailStatus:(NSString*)retailNo
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestSetStoreRetailStatusWithRetailId:retailNo
                                                           success:^(NSDictionary *responseObject) {
                                                               [KKProgressHUD showReminder:self.view message:@"操作成功"];
                                                               [[CMRouter sharedInstance]popViewController];
                                                               
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

    }];
}

- (void)httpRequestDealRetailReturnWithRetailId:(NSString*)retailNo
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestDealRetailReturnWithRetailId:retailNo
                                                       success:^(NSDictionary *responseObject) {
                                                           [KKProgressHUD showReminder:self.view message:@"操作成功"];
                                                           [[CMRouter sharedInstance]popViewController];
                                                           
                                                       } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                           
                                                           [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

                                                       }];
}

#pragma mark - OrderDetailMerchandiseCell2Delegate

- (void)orderDetailMerchandiseCell2:(OrderDetailMerchandiseCell2*)aCell didSelectOpenButton:(BOOL)open retailId:(NSString *)retailId
{

    if (open) {
        
        self.dataModel.selectRetailId = retailId;
        self.tableView.tableViewModel = [self.dataModel tableViewModel];

    }else
    {
        self.dataModel.selectRetailId = nil;
        self.tableView.tableViewModel = [self.dataModel tableViewModel];
    }

}

#pragma mark - OrderDetailBottomViewDelegate

- (void)orderDetailBottomViewDidSelectBottomButtonIndex:(NSInteger)index
{
    if (self.status.integerValue == 1)
    {
        NSMutableDictionary *md = self.dataModel.retail.mutableCopy;
        if ([md objectForKey:@"shareProfit"] == nil) {
            [md setObject:@0 forKey:@"shareProfit"];
        }
        if ([md objectForKey:@"whoSend"] == nil) {
            [md setObject:@0 forKey:@"whoSend"];
        }
 
        [self httpRequestConfirmStoreRetailWithType:@(index) retail:md];
        
    }else if (self.status.integerValue == 2)
    {
        [self httpRequestSetStoreRetailStatus:self.orderId];
        
    }else if (self.status.integerValue == 3)
    {
        [self httpRequestDealRetailReturnWithRetailId:self.orderId];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
        tableFooterView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = tableFooterView;
    }
    return _tableView;
}

- (OrderDetailBottomView *)orderDetailBottomView
{
    if (!_orderDetailBottomView)
    {
        NSArray *titles = @[@"确认退货"];
        
        if (self.status.integerValue == 1) {
            
            titles = @[@"撤销订单",@"确认订单"];
            
        }else if (self.status.integerValue == 2)
        {
            titles = @[@"确认收货"];
        }
        _orderDetailBottomView = [OrderDetailBottomView orderDetailBottomViewWithButtonTitles:titles];
        _orderDetailBottomView.delegate = self;
    }
    return _orderDetailBottomView;
}


@end
