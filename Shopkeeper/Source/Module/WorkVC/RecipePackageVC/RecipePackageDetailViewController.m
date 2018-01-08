//
//  RecipePackageDetailViewController.m
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageDetailViewController.h"
#import "RecipePackageDetailTabHeader.h"
#import "RecipePackageDetailTabFooter.h"
#import "RecipePackageDetailModel.h"

@interface RecipePackageDetailViewController ()<UITableViewDelegate>

@property (nonatomic,strong) RecipePackageDetailModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,weak) RecipePackageDetailTabHeader *tableHeader;
@property (nonatomic,weak) RecipePackageDetailTabFooter *tableFooter;
@end

@implementation RecipePackageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}
- (void)setupUI {
    self.navigationItem.title = @"处方套餐详情";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
- (void)loadData {
    [[APIService share]httpRequestQueryStorePrescriptionWitId:self.prescriptionId success:^(NSDictionary *responseObject) {
        [self.viewModel inputPrescriptionDic:responseObject];
        [self reloadUI];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
}

- (void)reloadUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onEditAction)];
    [self.tableHeader bindingViewModel:self.viewModel.tabHeaderModel];
    self.tableView.tableViewModel = self.viewModel.tableViewModel;
    [self.tableFooter bindingViewModel:self.viewModel.tabFooterModel];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - event
- (void)onEditAction {
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:self.cropId forKey:@"cropId"];
    [param setObject:self.cropName forKey:@"cropName"];
    [param setObject:self.viewModel.prescriptionDic forKey:@"prescriptionDic"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"ReicpePackageAddPrescriptionViewController" param:param];
}
#pragma mark - getter
- (RecipePackageDetailModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RecipePackageDetailModel alloc]init];
        _viewModel.cropName = self.cropName;
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins: UIEdgeInsetsZero];
        }
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        RecipePackageDetailTabHeader *tableHeader = [[RecipePackageDetailTabHeader alloc]init];
        tableHeader.frame = CGRectMake(0, 0, 0, 190);
        _tableView.tableHeaderView = tableHeader;
        _tableHeader = tableHeader;
        RecipePackageDetailTabFooter *tableFooter = [[RecipePackageDetailTabFooter alloc]init];
        tableFooter.frame = CGRectMake(0, 0, 0, 170);
        _tableView.tableFooterView = tableFooter;
        _tableFooter = tableFooter;
    }
    return _tableView;
}
@end
