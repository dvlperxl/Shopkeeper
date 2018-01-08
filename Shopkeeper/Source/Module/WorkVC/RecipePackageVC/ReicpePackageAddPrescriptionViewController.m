//
//  ReicpePackageAddPrescriptionViewController.m
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddPrescriptionViewController.h"
#import "ReicpePackageAddPrescriptionModel.h"
#import "GoodsCategoryPickerView.h"
#import "ReicpePackageAddPrescriptionHeader.h"

@interface ReicpePackageAddPrescriptionViewController ()<ReicpePackageAddPrescriptionTabHeaderDelegate,ReicpePackageAddPrescriptionTabFooterDelegate,GoodsCategoryPickerViewDataSource,GoodsCategoryPickerViewDelegate,ReicpePackageAddPrescriptionHeaderDelegate,UITableViewDelegate,ReicpePackageAddPrescriptionCellDelegate>

@property (nonatomic,strong) ReicpePackageAddPrescriptionModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,weak) ReicpePackageAddPrescriptionTabHeader *tableHeader;
@property (nonatomic,weak) ReicpePackageAddPrescriptionTabFooter *tableFooter;
@property (nonatomic,strong) GoodsCategoryPickerView *pickerView;
@end

@implementation ReicpePackageAddPrescriptionViewController

- (void)dealloc {
    if (_tableHeader) {
        [self.tableHeader removeObserver:self forKeyPath:@"prescriptionNameView.contentTxtField.text"];
    }
    if (_tableFooter) {
        [self.tableFooter removeObserver:self forKeyPath:@"salePriceView.contentTxtField.text"];
        [self.tableFooter removeObserver:self forKeyPath:@"descriptionView.contentTxtField.text"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self reloadUI];
    
}

- (void)setupUI {
    self.navigationItem.title = self.prescriptionDic ? @"编辑处方套餐" : @"新建处方套餐";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveButtonAction:)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    NSMutableDictionary *crop = @{}.mutableCopy;
    [crop setObject:self.cropName forKey:@"cropName"];
    [crop setObject:self.cropId forKey:@"cropId"];
    [self.viewModel inputCrop:crop];
    [self.viewModel inputPrescriptionDic:self.prescriptionDic];
}
- (void)reloadUI {
    [self.tableHeader bindingViewModel:self.viewModel.tabHeaderModel];
    self.tableView.tableViewModel = self.viewModel.tableViewModel;
    [self.tableFooter bindingViewModel:self.viewModel.tabFooterModel];
}
#pragma mark - ReicpePackageAddPrescriptionHeaderDelegate
- (void)tapSectionHeader:(ReicpePackageAddPrescriptionHeader *)sectionHeader {
    // 跳转选择商品页面
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:NSStringFromClass([self class]) forKey:@"backClassName"];
    [param setObject:@(1) forKey:@"vcType"];
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:self.viewModel.stockGoodsListVCGoodsList forKey:@"goodsList"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"StockGoodsListViewController" param:param];
}
#pragma mark - GoodsCategoryPickerViewDataSource,GoodsCategoryPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.viewModel.pickerComponentsCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.viewModel pickerRowsInComponent:component];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    NSString *text = [self.viewModel pickerTitleForRow:row forComponent:component];
    
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 2;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setText:text];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    BOOL reload = [self.viewModel pickerReplaceObjectInRow:row inComponent:component];
    if (reload) {
        [pickerView reloadComponent:component+1];
    }
}
- (void)goodsPickerView:(GoodsCategoryPickerView *)view pickerView:(UIPickerView *)pickerView selectedRows:(NSArray *)rows {
    self.pickerView = nil;
    [self.viewModel pickerUpdateDataWithSelectedRows:rows];
    [self reloadUI];
}
- (void)goodsPickerViewDidDismiss:(GoodsCategoryPickerView *)view {
    self.pickerView = nil;
}
#pragma mark - ReicpePackageAddPrescriptionTabHeaderDelegate
- (void)tapSpecRowTabHeader:(ReicpePackageAddPrescriptionTabHeader *)tabHeader {
    self.viewModel.pickerType = AddPrescriptionModelPickerTypeSpec;
    [self.pickerView showInController:self.navigationController];
}
#pragma mark - ReicpePackageAddPrescriptionTabFooterDelegate
- (void)tapIntegrationRowTabFooter:(ReicpePackageAddPrescriptionTabFooter *)tabFooter {
    self.viewModel.pickerType = AddPrescriptionModelPickerTypeIntegration;
    [self.pickerView showInController:self.navigationController];
}
#pragma mark - ReicpePackageAddPrescriptionCellDelegate
- (void)prescriptionCell:(ReicpePackageAddPrescriptionCell *)cell useSpcContent:(NSString *)useSpcContent {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.viewModel setGoodsUseNumber:useSpcContent index:indexPath.row];
    [self reloadUI];
}
- (void)prescriptionCell:(ReicpePackageAddPrescriptionCell *)cell number:(NSInteger)number {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.viewModel setGoodsNumber:number index:indexPath.row];
    [self reloadUI];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[ReicpePackageAddPrescriptionTabHeader class]]) {
        if ([keyPath isEqualToString:@"prescriptionNameView.contentTxtField.text"]) {
            [self.viewModel setPrescriptionName:change[@"new"]];
        }
    } else if ([object isKindOfClass:[ReicpePackageAddPrescriptionTabFooter class]]) {
        if ([keyPath isEqualToString:@"salePriceView.contentTxtField.text"]) {
            [self.viewModel setSalePrice:change[@"new"]];
        } else if ([keyPath isEqualToString:@"descriptionView.contentTxtField.text"]) {
            [self.viewModel setPrescriptionDescription:change[@"new"]];
        }
    }
    
}
#pragma mark - event
- (void)onSaveButtonAction:(UIBarButtonItem *)barButton {
    barButton.enabled = NO;
    [self.view endEditing:YES];
    NSString *errorMsg = [self.viewModel checkParamWithErrorMsg];
    if (errorMsg) {
        [[KKToast makeToast:errorMsg] show];
        barButton.enabled = YES;
        return;
    }
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestAddRecipePackageWithStoreId:self.storeId integration:self.viewModel.reqIntegration storeCorpId:self.cropId description:self.viewModel.reqDescription name:self.viewModel.reqName salePrice:self.viewModel.reqSalePrice prescriptionSpecName:self.viewModel.reqPrescriptionSpecName goodsList:self.viewModel.reqGoodsList prescriptionId:self.viewModel.reqPrescriptionId success:^(NSDictionary *responseObject) {
        barButton.enabled = YES;
        [KKProgressHUD hideMBProgressForView:self.view];
        [[CMRouter sharedInstance]backToViewController:@"RecipePackageListViewController" param:nil];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        [[KKToast makeToast:errorMsg] show];
        barButton.enabled = YES;
    }];
}
#pragma mark - callBack
- (void)setCallBack:(NSDictionary *)callBack {
    NSString *action = callBack[@"action"];
    if ([action isEqualToString:@"addGoods"]) {
        NSArray *goodList = callBack[@"goodsList"];
        [self.viewModel addGoodsList:goodList];
        [self reloadUI];
    }
}
#pragma mark - getter
- (ReicpePackageAddPrescriptionModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ReicpePackageAddPrescriptionModel alloc]init];
        _viewModel.toastBlock = ^(NSString *toast) {
            [[KKToast makeToast:toast] show];
        };
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
        ReicpePackageAddPrescriptionTabHeader *tableHeader = [[ReicpePackageAddPrescriptionTabHeader alloc]init];
        tableHeader.delegate = self;
        tableHeader.frame = CGRectMake(0, 0, 0, 190);
        _tableView.tableHeaderView = tableHeader;
        _tableHeader = tableHeader;
        [tableHeader addObserver:self forKeyPath:@"prescriptionNameView.contentTxtField.text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        ReicpePackageAddPrescriptionTabFooter *tableFooter = [[ReicpePackageAddPrescriptionTabFooter alloc]init];
        tableFooter.delegate = self;
        tableFooter.frame = CGRectMake(0, 0, 0, 170);
        _tableView.tableFooterView = tableFooter;
        _tableFooter = tableFooter;
        [tableFooter addObserver:self forKeyPath:@"salePriceView.contentTxtField.text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [tableFooter addObserver:self forKeyPath:@"descriptionView.contentTxtField.text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
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
