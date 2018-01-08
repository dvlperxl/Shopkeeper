//
//  AddStockViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddStockViewController.h"
#import "OrderDetailBottomView.h"
#import "AddStockModel.h"

@interface AddStockViewController ()<UITableViewDelegate,OrderDetailBottomViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)AddStockModel *addStockModel;
@property(nonatomic,strong)OrderDetailBottomView *orderDetailBottomView;
@property(nonatomic,strong)NSNumber *supplierId;

@end

@implementation AddStockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBackBtnAction
{
    [[CMRouter sharedInstance]popViewController];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-60);
    }];
    
    [self.orderDetailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.height.mas_equalTo(60);
       make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
}

#pragma mark - http request

- (void)httpRequestMergeStorePurchaseWithPurchase:(NSDictionary*)purchase
                                   purchaseDetail:(NSArray*)purchaseDetail
                                            index:(NSInteger)index
{
    
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestMergeStorePurchaseWithPurchase:purchase
                                                  purchaseDetail:purchaseDetail
                                                         success:^(NSDictionary *responseObject) {
                                                             
                                                             [KKProgressHUD hideMBProgressForView:self.view];
                                                             
                                                             if (index == 0) {
                                                                 
                                                                 [[CMRouter sharedInstance]popViewController];
                                                                 
                                                             }else
                                                             {
                                                                 NSMutableDictionary *param = @{}.mutableCopy;
                                                                 [param setObject:self.storeId forKey:@"storeId"];
                                                                 [[CMRouter sharedInstance]removeControllersWithRange:NSMakeRange(self.navigationController.viewControllers.count-1, 1)];
                                                                 [[CMRouter sharedInstance]showViewController:@"AddStockViewController" param:param];
                                                             }
        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
    }];
}

#pragma mark - OrderDetailBottomViewDelegate

- (void)orderDetailBottomViewDidSelectBottomButtonIndex:(NSInteger)index
{
    NSMutableDictionary *purchase = [self.addStockModel purchase];
    [purchase setObject:self.storeId forKey:@"storeId"];
    NSArray *purchaseDetail = [self.addStockModel purchaseDetail];
    
    if (purchase[@"supplierId"]==nil)
    {
        [[KKToast makeToast:@"请选择供应商"]show];
        return;
    }
    
    if (purchaseDetail.count == 0)
    {
        [[KKToast makeToast:@"请选择商品"]show];
        return;
    }
    
    NSString *finalAmount = purchase[@"finalAmount"];
    if (finalAmount == nil||finalAmount.floatValue==0)
    {
        [[KKToast makeToast:@"请输入结算金额"]show];
        return;
    }
    
    NSString *creditAmount = purchase[@"creditAmount"];
    
    if (creditAmount&&creditAmount.floatValue>finalAmount.floatValue)
    {
        [[KKToast makeToast:@"赊欠金额不能大于结算金额"]show];
        return;
    }
    
    NSString *remark = purchase[@"remark"];
    if (remark&&remark.length>0)
    {
        if ([remark firstLetterLegal]) {
            [[KKToast makeToast:@"备注首字不能为特殊符号"]show];
            return;
        }
        
        if (remark.length>50) {
            
            [[KKToast makeToast:@"备注最多50个字"]show];
            return;
        }
    }

    
    
    
    [self httpRequestMergeStorePurchaseWithPurchase:purchase
                                     purchaseDetail:purchaseDetail
                                              index:index];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKCellModel *cellModel = [self.tableView.tableViewModel cellModelAtIndexPath:indexPath];
    [self invokeMethodWithMethodName:cellModel.routerModel.methodName param:cellModel.routerModel.param];
    [[CMRouter sharedInstance]showViewControllerWithRouterModel:cellModel.routerModel];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"进货开单";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.orderDetailBottomView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
        tableFooterView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = tableFooterView;
        _tableView.tableViewModel = self.addStockModel.tableViewModel;
    }
    return _tableView;
}

- (OrderDetailBottomView *)orderDetailBottomView
{
    if (!_orderDetailBottomView)
    {
        NSArray *titles = @[@"保存",@"保存并新增"];
        _orderDetailBottomView = [OrderDetailBottomView orderDetailBottomViewWithButtonTitles:titles];
        _orderDetailBottomView.delegate = self;
    }
    return _orderDetailBottomView;
}

- (AddStockModel *)addStockModel
{
    if (!_addStockModel) {
        _addStockModel = [[AddStockModel alloc]init];
        _addStockModel.storeId = self.storeId;
        
        [RACObserve(_addStockModel.creditData, content) subscribeNext:^(id  _Nullable x) {
            [self changePrepaidData];
        }];
        [RACObserve(_addStockModel.finalAmountData, content) subscribeNext:^(id  _Nullable x) {

            [self changePrepaidData];
        }];
        
    }
    return _addStockModel;
}

#pragma mark callBack

- (void)setCallBack:(NSDictionary *)callBack
{
    NSString *action = callBack[@"action"];
    if ([action isEqualToString:@"addSupplier"])
    {
        self.supplierId = callBack[@"id"];
        self.addStockModel.supplierName = callBack[@"name"];
        self.addStockModel.supplierId = callBack[@"id"];
        self.tableView.tableViewModel = self.addStockModel.tableViewModel;
    }
    else if ([action isEqualToString:@"addGoods"])
    {
        NSLog(@"%@",callBack[@"goodsList"]);
        self.addStockModel.goodsList = callBack[@"goodsList"];
        self.addStockModel.tableViewModel = nil;
        self.addStockModel.finalAmountData.content = [self.addStockModel totalAmount];
        self.addStockModel.finalAmountData.inputMaxAmount = [self.addStockModel totalAmount];
        self.tableView.tableViewModel = self.addStockModel.tableViewModel;
    }
}

- (void)changePrepaidData
{
    if (self.addStockModel.finalAmountData.content&&self.addStockModel.finalAmountData.content.floatValue>0) {

        CGFloat prepaid = self.addStockModel.finalAmountData.content.floatValue - self.addStockModel.creditData.content.floatValue;
        NSLog(@"%@",@(prepaid));
        if (prepaid<0) {
            prepaid=0;
        }
        NSString *pre = [NSString stringWithFormat:@"已收金额：¥%@f",AMOUNTSTRING(@(prepaid))];
        self.addStockModel.prepaidData.content = [CMLinkTextViewItem attributeStringWithText:pre textFont:APPFONT(12) textColor:ColorWithHex(@"#262626") textAlignment:NSTextAlignmentRight];
    }else
    {
        self.addStockModel.prepaidData.content = [CMLinkTextViewItem attributeStringWithText:@"已收金额：¥0.00" textFont:APPFONT(12) textColor:ColorWithHex(@"#262626") textAlignment:NSTextAlignmentRight];
    }
    NSArray *indexPaths = [self.addStockModel.tableViewModel findCellModelIndexPathsWithCellType:@"prepaidAmount"];
    [self.tableView reloadRowsAtIndexPaths:indexPaths];
}

@end
