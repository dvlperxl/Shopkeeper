//
//  MallOrderDetailViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderDetailViewController.h"
#import "MallOrderDetailModel.h"
#import "StockOrderDetailHeaderView.h"
#import "OrderDetailBottomView.h"
#import "KaKaPay.h"

@interface MallOrderDetailViewController ()
<OrderDetailBottomViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)StockOrderDetailHeaderView *tableHeaderView;
@property(nonatomic,strong)OrderDetailBottomView *orderDetailBottomView;
@property(nonatomic,copy)NSString *orderStatus;
@property(nonatomic,copy)NSArray *goods;
@property(nonatomic,strong)NSDictionary *orderInfo;

@end

@implementation MallOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self httpRequestQueryMallOrderDetail];
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

- (void)httpRequestQueryMallOrderDetail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestQueryMallOrderDetail:self.wholeSaleRetailId
                                                status:self.status
                                               success:^(NSDictionary *responseObject)
     {
         [KKProgressHUD hideMBProgressForView:self.view];
         
         NSString *orderStatus = responseObject[@"retailStatus"];
         self.orderStatus = orderStatus;
         if ([orderStatus isEqualToString:@"7"])
         {
             self.orderDetailBottomView.hidden = NO;
             [self.orderDetailBottomView reloadData:@[@"立即支付"]];
             
         }else if ([orderStatus isEqualToString:@"2"])
         {
             self.orderDetailBottomView.hidden = NO;
             [self.orderDetailBottomView reloadData:@[@"确认收货"]];
         }
         else
         {
             self.orderDetailBottomView.hidden = YES;
         }
         
         MallOrderDetailModel *mallModel = [[MallOrderDetailModel alloc]init];
         self.tableView.tableViewModel  = [mallModel mallOrdetailTableViewModel:responseObject];
         self.goods = responseObject[@"goodsList"];
         [self.tableHeaderView reloadData:self.tableView.tableViewModel.headerViewModel];
         
     } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
         
         [KKProgressHUD hideMBProgressForView:self.view];
         __weak typeof(self) weakSelf = self;
         [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                tapBlock:^{
                                                                                    
                                                                                    [weakSelf httpRequestQueryMallOrderDetail];
                                                                                    
                                                                                }] ];
         
     }];
    
}

- (void)httpRequestConfirmOrder
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    NSMutableArray *goods = [NSMutableArray array];
    for (NSDictionary *dict in self.goods)
    {
        NSMutableDictionary *md = dict.mutableCopy;
        [md removeObjectForKey:@"contentUnit"];
        [md removeObjectForKey:@"contentUnit"];
        [goods addObject:md];
    }
    
    [[APIService share]httpRequestMallConfirmOrder:self.wholeSaleRetailId
                                             goods:goods.copy
                                           storeId:self.storeId
                                           success:^(NSDictionary *responseObject) {
                                               [KKProgressHUD hideMBProgressForView:self.view];
                                               [self httpRequestQueryMallOrderDetail];
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
    }];
}

- (void)httpRequestQueryPayInfo
{
    [[APIService share]httpRequestQueryOrderPayInfo:self.wholeSaleRetailId
                                            payType:@"aliPay"
                                          orderType:@"4"
                                            success:^(NSDictionary *responseObject) {
                                                
                                                NSMutableDictionary *param = @{}.mutableCopy;
                                                [param setObject:responseObject forKey:@"orderInfo"];
                                                [[KaKaPay share]kakaPay:nil
                                                                payType:@"alipay"
                                                                payInfo:param
                                                               payBlock:^(BOOL success) {

                                                                   NSNumber  *payCompletionType = success?@0:@1;
                                                                   NSMutableDictionary *param = @{}.mutableCopy;
                                                                   [param setObject:payCompletionType forKey:@"payCompletionType"];
                                                                   [param setObject:self.storeId forKey:@"storeId"];
                                                                   [[CMRouter sharedInstance]presentControllerWithControllerName:@"MallPayCompletionViewController" param:param];
                                                }];


    
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
}

#pragma mark - OrderDetailBottomViewDelegate

- (void)orderDetailBottomViewDidSelectBottomButtonIndex:(NSInteger)index
{
    if (self.orderStatus.integerValue == 2)
    {
        [self httpRequestConfirmOrder];
        
    }else if(self.orderStatus.integerValue == 7)
    {
        //支付
        [self httpRequestQueryPayInfo];
        
    }
}


#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"商城订单详情";
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
        NSArray *titles = @[@"立即支付"];
        _orderDetailBottomView = [OrderDetailBottomView orderDetailBottomViewWithButtonTitles:titles];
        _orderDetailBottomView.delegate = self;
        _orderDetailBottomView.hidden = YES;
    }
    return _orderDetailBottomView;
}


- (void)setCallBack:(NSDictionary *)callBack
{
    NSString *action = callBack[@"actionName"];
    if ([action isEqualToString:@"repay"])
    {
        [self httpRequestQueryPayInfo];
    }
}


@end
