//
//  CommodityListViewController.m
//  Dev
//
//  Created by xl on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "CommodityListViewController.h"
#import "CommodityListModel.h"
#import "GoodsCategoryPickerView.h"
#import "CommodityListHeader.h"
#import "KaKaCache.h"

@interface CommodityListViewController ()<GoodsCategoryPickerViewDataSource,GoodsCategoryPickerViewDelegate,CommodityListHeaderDelegate,UITableViewDelegate>

@property (nonatomic,strong) CommodityListModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,strong) GoodsCategoryPickerView *pickerView;

@end

@implementation CommodityListViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadDataWithCategoryId:nil];

}

- (void)setupUI {
    self.navigationItem.title = @"商品列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(onAddGoodsButtonAction)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
- (void)loadDataWithCategoryId:(NSString *)categoryId {
    __weak typeof(self) weakSelf = self;
    [self.viewModel tableViewModelWithCategoryId:categoryId success:^(KKTableViewModel *tableViewModel) {
        weakSelf.tableView.tableViewModel = tableViewModel;
    } failure:^(NSString *errorMsg) {
        
    }];
}
#pragma mark - CommodityListHeaderDelegate
- (void)tapHeader:(CommodityListHeader *)header {
    [self.pickerView showInController:self.navigationController];
}
#pragma mark - GoodsCategoryPickerViewDataSource,GoodsCategoryPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.viewModel.pickerViewDataSource count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.viewModel.pickerViewDataSource[component] count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    CommodityCategoryModel *category = self.viewModel.pickerViewDataSource[component][row];
    
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 2;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setText:category.name];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        CommodityCategoryModel *category = self.viewModel.pickerViewDataSource[component][row];
        [self.viewModel.pickerViewDataSource replaceObjectAtIndex:1 withObject:[self.viewModel pickerViewDataSourceWithCategory:category]];
        [pickerView reloadComponent:1];
    }
}
- (void)goodsPickerView:(GoodsCategoryPickerView *)view pickerView:(UIPickerView *)pickerView selectedRows:(NSArray *)rows {
    NSInteger firstComponentSelectedRow = [rows[0] integerValue];
    CommodityCategoryModel *bigCategory = self.viewModel.pickerViewDataSource[0][firstComponentSelectedRow];
    [self.viewModel.pickerViewDataSource replaceObjectAtIndex:1 withObject:[self.viewModel pickerViewDataSourceWithCategory:bigCategory]];
    
    NSInteger secondComponentSelectedRow = [rows[1] integerValue];
    CommodityCategoryModel *category = self.viewModel.pickerViewDataSource[1][secondComponentSelectedRow];
    
    [self loadDataWithCategoryId:category.id];
    
}
#pragma mark - UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [KKAlertView showAlertActionViewWithTitle:@"该商品关联的热卖或处方商品也将被删除" actions:@[[KKAlertAction alertActionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil],[KKAlertAction alertActionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(KKAlertAction *action) {
            KKSectionModel *section = self.tableView.tableViewModel.sectionDataList[indexPath.section];
            if (section) {
                KKCellModel *cellModel = section.cellDataList[indexPath.row];
                CommodityListCellModel *cellData = cellModel.data;
                [KKProgressHUD showMBProgressAddTo:self.view];
                [[APIService share]httpRequestDeleteGoodsWthId:cellData.commodityId success:^(NSDictionary *responseObject) {
                    [KKProgressHUD hideMBProgressForView:self.view];
                    __weak typeof(self) weakSelf = self;
                    [self.viewModel deleteRowCellModelWithCommodityId:cellData.commodityId success:^(KKTableViewModel *tableViewModel) {
                        weakSelf.tableView.tableViewModel = tableViewModel;
                    } failure:nil];
                } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                    [KKProgressHUD hideMBProgressForView:self.view];
                    [[KKToast makeToast:errorMsg] show];
                }];
            }
        }]]];
    }];
    return @[action];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KKSectionModel *section = self.tableView.tableViewModel.sectionDataList[indexPath.section];
    if (section) {
        KKCellModel *cellModel = section.cellDataList[indexPath.row];
        CommodityListCellModel *cellData = cellModel.data;
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.storeId forKey:@"storeId"];
        [param setObject:self.viewModel.categoryList forKey:@"categoryList"];
        [param setObject:cellData.commodityId forKey:@"goodsId"];
        [[CMRouter sharedInstance]showViewController:@"GoodsDetailViewController" param:param];
    }
}
#pragma mark - event
- (void)onAddGoodsButtonAction {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    NSArray *categoryList = self.viewModel.categoryList;
    if (!categoryList) {
        id responseObject = [KaKaCache objectForKey:@"server_findGoodCategoryByPid"];
        categoryList = [NSArray yy_modelArrayWithClass:[CommodityCategoryModel class] json:responseObject];
    }
    [param setObject:categoryList forKey:@"categoryList"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"AddGoodsViewController" param:param];
}
#pragma mark - getter,setter
- (void)setCallBack:(NSDictionary *)callBack {
    NSString *action = callBack[@"action"];
    if ([action isEqualToString:@"addGoods"]) {
        // 添加商品成功回调，刷新列表
        __weak typeof(self) weakSelf = self;
        [self.viewModel newestTableViewModelWithCategoryId:[callBack objectForKey:@"categoryId"] success:^(KKTableViewModel *tableViewModel) {
            weakSelf.tableView.tableViewModel = tableViewModel;
        } failure:nil];
    }
}
- (void)setStoreId:(NSString *)storeId {
    _storeId = storeId;
    if (_viewModel) {
        _viewModel = nil;
    }
}
- (CommodityListModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CommodityListModel alloc]initWithStoreId:self.storeId];
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        [_tableView setValue:self forKey:@"kkDataSource"];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins: UIEdgeInsetsZero];
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (GoodsCategoryPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[GoodsCategoryPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
@end
