//
//  SMSRechargeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSRechargeViewController.h"

#import "WorkStoreModel.h"
#import "SMSRechargeModel.h"
#import "MallOrderPayCell.h"
#import "OrderDetailBottomView.h"
#import "SMSTableViewCell.h"
#import "KaKaPay.h"

@interface SMSRechargeViewController ()
<UITableViewDelegate,OrderDetailBottomViewDelegate,SMSTableViewCellDelegate>


@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,assign)BOOL selectAliPay;
@property(nonatomic,strong)OrderDetailBottomView *orderDetailBottomView;
@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSArray *smsconfig;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)NSString* content;
@property(nonatomic,strong)NSString* orderId;

@end

@implementation SMSRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectAliPay = YES;
    self.selectIndex = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [self.view addSubview:self.orderDetailBottomView];
    
    [self.orderDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        
    }];
    
    self.navigationItem.title = @"短信充值";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"充值记录"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(onRightButtonAction)];
    
    WorkStoreModel *storeModel = [WorkStoreModel lastChooseStore];
    self.storeId = storeModel.storeId;
    [self httpRequestGetSMS:storeModel.storeId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"SMSRechargeListViewController" param:param];
}

- (void)httpRequestGetSMS:(NSNumber*)storeId
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestGetStoreSmsWithStoreId:storeId
                                                 success:^(id responseObject) {
                                                     [KKProgressHUD hideMBProgressForView:self.view];
                                                     self.smsconfig = responseObject[@"smsconfig"];
                                                     self.tableView.tableViewModel = [SMSRechargeModel tableViewModel:responseObject];
                                                     
        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
    }];
}

- (void)httpRequestCreateStoreSmsOrder:(NSNumber*)smsAmount
                             smsNumber:(NSNumber*)smsNumber
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestCreateStoreSmsOrderWithStoreId:self.storeId
                                                          method:@"支付宝"
                                                       smsAmount:smsAmount
                                                       smsNumber:smsNumber
                                                         success:^(id responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
                                                             self.orderId = responseObject[@"id"];
                                                             [self httpRequestQueryPayInfo:self.orderId];
                                                             
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

    }];
}

- (void)httpRequestQueryPayInfo:(NSString*)orderId
{
    [[APIService share]httpRequestQueryOrderPayInfo:orderId
                                            payType:@"aliPay"
                                          orderType:@"1"
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
                                                                   [param setObject:self.content forKey:@"content"];

                                                                   [[CMRouter sharedInstance]presentControllerWithControllerName:@"SMSRecharegeViewController" param:param];
                                                               }];
                                                
                                                
                                                
                                            } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                
                                            }];
}

- (void)orderDetailBottomViewDidSelectBottomButtonIndex:(NSInteger)index
{
    if (self.selectAliPay == NO)
    {
        [KKToast makeToast:@"请选择支付方式"];
        return;
    }
    
    NSDictionary *dict = self.smsconfig[self.selectIndex];
    if (dict) {
        
        self.content = [NSString stringWithFormat:@"%@元 %@条短信",dict[@"smsAmount"],dict[@"smsNumber"]];
        [self httpRequestCreateStoreSmsOrder:dict[@"smsAmount"] smsNumber:dict[@"smsNumber"]];
    }
}

- (void)SMSTableViewCellDidSelectMenuIndex:(NSInteger)index
{
    self.selectIndex = index;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    KKCellModel *cellModel =[self.tableView.tableViewModel cellModelAtIndexPath:indexPath];
//    if ([cellModel.cellType isEqualToString:@"MallOrderPayCell"])
//    {
//        MallOrderPayCellModel *data =cellModel.data;
//        self.selectAliPay = !self.selectAliPay;
//        data.selectedImage = self.selectAliPay? [UIImage imageNamed:@"icon_orange_checkbox"] : [UIImage imageNamed:@"icon_grey_checkbox"];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath]];
//    }
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        footerView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = footerView;

    }
    return _tableView;
}

- (OrderDetailBottomView *)orderDetailBottomView
{
    if (!_orderDetailBottomView)
    {
        NSArray *titles = @[@"确认支付"];
        _orderDetailBottomView = [OrderDetailBottomView orderDetailBottomViewWithButtonTitles:titles];
        _orderDetailBottomView.delegate = self;
    }
    return _orderDetailBottomView;
}

- (void)setCallBack:(NSDictionary *)callBack
{
    NSString *action = callBack[@"actionName"];
    if ([action isEqualToString:@"repay"])
    {
        [self httpRequestQueryPayInfo:self.orderId];
    }
}


@end
