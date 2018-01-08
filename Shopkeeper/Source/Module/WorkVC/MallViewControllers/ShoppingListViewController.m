//
//  ShoppingListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ShoppingListViewController.h"
#import "ShoppingListModel.h"
#import "ShoppingListBottomBar.h"
#import "KKTableView+handleData.h"
#import "MallGoodsNumModel.h"
#import "ShoppingListCell.h"

CGFloat const shoppingBottomBarHeight = 60.0f;
@interface ShoppingListViewController ()<UITableViewDelegate,ShoppingListBottomBarDelegate>

@property (nonatomic,strong) ShoppingListModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,strong) ShoppingListBottomBar *bottomBar;
@end

@implementation ShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
    
}

- (void)setupUI {
    self.navigationItem.title = @"购物车";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).with.offset(-shoppingBottomBarHeight);
    }];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(shoppingBottomBarHeight);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
- (void)loadData {
    [[APIService share]httpRequestQueryShopCartsListWithStoreId:self.storeId success:^(NSDictionary *responseObject) {
        NSArray *shopcarts = responseObject[@"shopcarts"];
        [self.viewModel inputShoopingListResponse:shopcarts];
        self.tableView.tableViewModel = self.viewModel.tableViewModel;
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf loadData];
                                                                                   
                                                                               }] ];
    }];
}
- (void)toMallHome {
    // 更新购物车
//    if (self.viewModel.changeShoppingList) {
//
//    }
    [[APIService share]httpRequestUpdateShopCartsListWithStoreId:self.storeId shopcarts:[self.viewModel synchShopCarts] success:^(NSDictionary *responseObject) {
        // 刷新购物车个数
        [[MallGoodsNumModel sharedInstance]loadShopCartsGoodsNumberForStoreId:self.storeId];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
    }];
    [[CMRouter sharedInstance]backToViewController:@"MallHomeViewController" param:nil];
}
- (void)onBackBtnAction {
//    // 更新购物车
//    if (self.viewModel.changeShoppingList) {
//
//    }
    [[APIService share]httpRequestUpdateShopCartsListWithStoreId:self.storeId shopcarts:[self.viewModel synchShopCarts] success:^(NSDictionary *responseObject) {
        // 刷新购物车个数
        [[MallGoodsNumModel sharedInstance]loadShopCartsGoodsNumberForStoreId:self.storeId];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
    [[CMRouter sharedInstance]popViewController];
}
#pragma mark - ShoppingListCellDelegate
- (void)shoppingCell:(ShoppingListCell *)cell errorNumber:(NSInteger)errorNumber {
//    [[KKToast makeToast:[NSString stringWithFormat:@"商品数不能为%ld",(long)errorNumber]] show];
}

- (void)shoppingCell:(ShoppingListCell *)cell number:(NSInteger)number
{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//
//    id cellData = [self.viewModel updateGoodsCount:@(number) indexPath:indexPath];
//    [self.tableView replaceDataModelForIndexPath:indexPath data:cellData];
    
    [self.bottomBar updateAllSelectedTotalStatus:self.viewModel.isSelectedAllStatus selectedTotalPrice:self.viewModel.selectedGoodsPrice selectedCount:self.viewModel.selectedGoodsCount payBtnEnabled:self.viewModel.selectedGoodsCount != 0];
}
// 删除商品操作
- (void)shoppingCellDeleteHandle:(ShoppingListCell *)cell
{
    [KKAlertView showAlertActionViewWithTitle:@"确认要删除该商品吗？" actions:@[[KKAlertAction alertActionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil],[KKAlertAction alertActionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(KKAlertAction *action) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        [self.tableView.tableViewModel removeCellModelWithIndexPaths:@[indexPath]];
        [self.tableView reloadData];
//        if ([self.viewModel deleteGoodsForIndexPath:indexPath])
//        {
//            [self.tableView deleteDataModelForIndexPath:indexPath];
//        }
        [self.bottomBar updateAllSelectedTotalStatus:self.viewModel.isSelectedAllStatus selectedTotalPrice:self.viewModel.selectedGoodsPrice selectedCount:self.viewModel.selectedGoodsCount payBtnEnabled:self.viewModel.selectedGoodsCount != 0];

    }]]];
}
#pragma mark - ShoppingListBottomBarDelegate
// 全选操作
- (void)bottomBar:(ShoppingListBottomBar *)bar tapSelectedAllStatus:(BOOL)status
{
    [self.viewModel selectedAll:status];
    [self.tableView reloadData];
    [self.viewModel setSelectGoods];
//    self.tableView.tableViewModel = self.viewModel.tableViewModel;
    [self.bottomBar updateAllSelectedTotalStatus:self.viewModel.isSelectedAllStatus selectedTotalPrice:self.viewModel.selectedGoodsPrice selectedCount:self.viewModel.selectedGoodsCount payBtnEnabled:self.viewModel.selectedGoodsCount != 0];
}
// 结算操作
- (void)bottomBarTapPayBtn:(ShoppingListBottomBar *)bar
{
//    [self.viewModel updateShopCarts];
    
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestUpdateShopCartsListWithStoreId:self.storeId shopcarts:[self.viewModel updateShopCarts] success:^(NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        // 更新购物车成功，跳转确认订单
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.storeId forKey:@"storeId"];
        [param setObject:@(YES) forKey:@"showShopping"];
        [[CMRouter sharedInstance]presentControllerWithControllerName:@"MallOrderInfoViewController" param:param];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
//        [self.viewModel cancelShopCarts];
        [KKProgressHUD hideMBProgressForView:self.view];
        [[KKToast makeToast:errorMsg] show];
    }];
    
}
//#pragma mark - UITableViewDelegate
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 50, 0, 0)];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 50, 0, 0)];
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 148;
//}
// 单行选中操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKCellModel *cellModel = [self.tableView.tableViewModel cellModelAtIndexPath:indexPath];
    ShoppingListCellModel *data = cellModel.data;
    data.select = !data.select;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]];
    [self.viewModel setSelectGoods];
    [self.bottomBar updateAllSelectedTotalStatus:self.viewModel.isSelectedAllStatus selectedTotalPrice:self.viewModel.selectedGoodsPrice selectedCount:self.viewModel.selectedGoodsCount payBtnEnabled:self.viewModel.selectedGoodsCount != 0];
    
}
#pragma mark - getter
- (ShoppingListModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShoppingListModel alloc]init];
        __weak typeof(self) weakSelf = self;
        _viewModel.listEmpty = ^() {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithImageName:Default_nocontent title:@"购物车还是空的" desc:nil btnTitle:@"去采购" tapBlock:^{
                [strongSelf toMallHome];
            }]];
        };
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
//        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            [_tableView setSeparatorInset: UIEdgeInsetsZero];
//        }
//        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//            [_tableView setLayoutMargins: UIEdgeInsetsZero];
//        }
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (ShoppingListBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[ShoppingListBottomBar alloc]init];
        _bottomBar.delegate = self;
        [self.view addSubview:_bottomBar];
    }
    return _bottomBar;
}
@end
