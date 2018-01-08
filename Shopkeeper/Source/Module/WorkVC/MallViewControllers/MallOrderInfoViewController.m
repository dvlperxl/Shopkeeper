//
//  MallOrderInfoViewController.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderInfoViewController.h"
#import "MallOrderInfoModel.h"
#import "MallOrderTabFooter.h"
#import "MallOrderGoodsHeader.h"
#import "MallOrderInvoiceHeader.h"
#import "MallOrderInvoiceCell.h"
#import "WorkStoreModel.h"
#import "MallGoodsNumModel.h"

@interface MallOrderInfoViewController ()<UITableViewDelegate,MallOrderInvoiceHeaderDelegate,MallOrderInvoiceCellDelegate,MallOrderTabFooterDelegate,MallOrderGoodsHeaderDelegate>

@property (nonatomic,strong) MallOrderInfoModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,weak) MallOrderTabFooter *tabFooter;
@end

@implementation MallOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.storeId == nil) {
        
        WorkStoreModel *model = [WorkStoreModel lastChooseStore];
        self.storeId = (NSNumber*)model.storeId;
    }
    [self setupUI];
    
    [self loadData];
}
- (void)setupUI {
    self.navigationItem.title = @"确认订单";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
}
- (void)loadData {
    [[APIService share]httpRequestQueryPreRetailWithStoreId:self.storeId wholesaleId:self.wholesaleId goodsId:self.goodsId goodsWrapId:self.goodsWrapId count:self.count success:^(NSDictionary *responseObject) {
        [self.viewModel inputOrderInfoResponse:responseObject showShopping:[self.showShopping boolValue]];
        [self reloadUI];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{

                                                                                   [weakSelf loadData];

                                                                               }] ];
    }];
}
- (void)reloadUI {
    self.tableView.tableViewModel = self.viewModel.tableViewModel;
    self.tabFooter.hidden = NO;
    [self.tabFooter bindingViewModel:self.viewModel.tableFooterModel];
}
#pragma mark - MallOrderTabFooterDelegate
// 提交订单
- (void)tabFooterDidTapSubmitBtn:(MallOrderTabFooter *)footer {
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestMergeWholesaleRetailWithStoreId:self.storeId storeName:[WorkStoreModel lastChooseStore].storeName totalAmount:@(self.viewModel.totalAmount) payType:self.viewModel.payName needInvoice:@(self.viewModel.needInvoice) head:self.viewModel.invoiceHeader taxNo:self.viewModel.invoiceTaxNo receiverName:self.viewModel.receiverName receiverAddress:self.viewModel.receiverAddress receiverAreaId:self.viewModel.receiverAreaId receiverMobile:self.viewModel.receiverMobile wholesaleOrder:self.viewModel.wholesaleOrder success:^(NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        [[KKToast makeToast:@"下单成功，商家会尽快确认订单"] show];
        // 刷新购物车个数
        [[MallGoodsNumModel sharedInstance]loadShopCartsGoodsNumberForStoreId:self.storeId];
        [[CMRouter sharedInstance]backToViewController:@"MallHomeViewController" param:nil];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        [[KKToast makeToast:errorMsg] show];
    }];
}
#pragma mark - MallOrderGoodsHeaderDelegate
// 返回购物车
- (void)goodsHeaderTapBackShopping:(MallOrderGoodsHeader *)header {
    if (![[CMRouter sharedInstance]backToViewController:@"ShoppingListViewController" param:nil]) {
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.storeId forKey:@"storeId"];
        [[CMRouter sharedInstance]removeControllersWithRange:NSMakeRange(self.navigationController.viewControllers.count-1, 1)];
        [[CMRouter sharedInstance]showViewController:@"ShoppingListViewController" param:param];
    }
}
#pragma mark - MallOrderInvoiceHeaderDelegate
// 是否需要发票
- (void)invoiceHeader:(MallOrderInvoiceHeader *)header switchOn:(BOOL)on {
    [self.viewModel setInvoiceOn:on];
    [self reloadUI];
}
#pragma mark - MallOrderInvoiceCellDelegate
- (void)invoiceCell:(MallOrderInvoiceCell *)cell didEndEditingText:(NSString *)text {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.viewModel setInvoiceInfoForRow:indexPath.row text:text];
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
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithHexString:@"#F5F5F5"];
    ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:NSClassFromString(@"MallOrderPayCell")]) {  // 支付类型cell
        [self.viewModel setPayTypeForRow:indexPath.row];
        [self reloadUI];
    } else if ([cell isKindOfClass:NSClassFromString(@"MallOrderReceiverInfoCell")]) {  // 收货信息cell
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.storeId forKey:@"storeId"];
        [param setObject:self.viewModel.addressId forKey:@"addressId"];
        [[CMRouter sharedInstance]showViewController:@"ReceivePersonListViewController" param:param];
    }
}
#pragma mark - 回调
- (void)setCallBack:(NSDictionary *)callBack {
    NSString *action = callBack[@"action"];
    if ([action isEqualToString:@"receivePerson"]) {
        NSDictionary *receiverInfo = callBack[@"parameters"];
        [self.viewModel inputReceivePerson:receiverInfo];
        [self reloadUI];
    }
}
#pragma mark - getter
- (MallOrderInfoModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MallOrderInfoModel alloc]init];
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins: UIEdgeInsetsZero];
        }
        [self.view addSubview:_tableView];
        MallOrderTabFooter *tableFooter = [[MallOrderTabFooter alloc]init];
        tableFooter.delegate = self;
        tableFooter.frame = CGRectMake(0, 0, 0, 60);
        _tableView.tableFooterView = tableFooter;
        tableFooter.hidden = YES;
        _tabFooter = tableFooter;
    }
    return _tableView;
}
@end
