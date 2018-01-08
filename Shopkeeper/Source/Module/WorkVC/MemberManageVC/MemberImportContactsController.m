//
//  MemberImportContactsController.m
//  Dev
//
//  Created by xl on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberImportContactsController.h"
#import "MemberImportContactsModel.h"
#import "MemberImportContactsBottomBar.h"
#import "MemberImportContactsToastView.h"

CGFloat const menberToastViewH = 40.0f;
CGFloat const menberBottomBarH = 60.0f;

@interface MemberImportContactsController ()<UITableViewDelegate,MemberImportContactsBottomBarDelegate,MemberImportContactsToastViewDelegate>

@property (nonatomic,strong) MemberImportContactsModel *viewModel;
@property (nonatomic,strong) MemberImportContactsToastView *toastView;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,strong) MemberImportContactsBottomBar *bottomBar;
@property (nonatomic,strong) KKLoadFailureAndNotResultView *resultView;
@property (nonatomic,strong) UIButton *setButton;

@end

@implementation MemberImportContactsController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    self.navigationItem.title = @"通讯录";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(self.navBarHeight);
        make.height.mas_equalTo(menberToastViewH);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(self.navBarHeight + menberToastViewH);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).with.offset(-menberBottomBarH);
    }];
}
- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel getAddressBookDataSuccess:^{
        weakSelf.tableView.tableViewModel = weakSelf.viewModel.tableViewModel;
        [weakSelf.bottomBar allSelectedTotal:weakSelf.viewModel.totalAvailableCount];
        [weakSelf httpRequestQueryFarmerList];
    } failure:^(NSError *error) {
        [weakSelf showSetAuthorizationView];
    }];
}
/** 请求获取会员列表*/
- (void)httpRequestQueryFarmerList {
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryFarmerCustomerList:nil
                                                  storeId:self.storeId
                                                querytype:@"desc"
                                                  orderBy:@"amount"
                                                 pageSize:@999
                                                   pageNo:@(1)
                                                  success:^(NSDictionary *responseObject)
     {
         [self.viewModel existFarmerlist:responseObject[@"result"]];
         self.tableView.tableViewModel = self.viewModel.tableViewModel;
         [self.bottomBar allSelectedTotal:self.viewModel.totalAvailableCount];
         [KKProgressHUD hideMBProgressForView:self.view];
         
     } failure:^(NSNumber *errorCode,
                 NSString *errorMsg,
                 NSDictionary *responseObject) {
         [KKProgressHUD hideMBProgressForView:self.view];
         
         __weak typeof(self) weakSelf = self;
         [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                tapBlock:^{

                                                                                    [weakSelf httpRequestQueryFarmerList];

                                                                                }] ];
     }];
}
- (void)showSetAuthorizationView {
    [self.view addSubview:self.resultView];
    if (_toastView) {
        [self.view bringSubviewToFront:self.toastView];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKSectionModel *section = self.tableView.tableViewModel.sectionDataList[indexPath.section];
    if (section) {
        KKCellModel *cellModel = section.cellDataList[indexPath.row];
        id cellData = cellModel.data;
        [self.viewModel selectedCellDataModel:cellData];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.bottomBar selectedCount:self.viewModel.selecteds.count];
        [self.bottomBar setAllSelectedTotalStatus:self.viewModel.isSelectedAllStatus];
    }
}
#pragma mark - MemberImportContactsBottomBarDelegate
/** 全选*/
- (void)bottomBar:(MemberImportContactsBottomBar *)bar tapSelectedAllStatus:(BOOL)status {
    [self.viewModel selectedAllStatus:status];
    [self.bottomBar selectedCount:self.viewModel.selecteds.count];
    [self.tableView reloadData];
}
/** 确认*/
- (void)bottomBarTapSureBtn:(MemberImportContactsBottomBar *)bar {
    
    [[APIService share]httpRequestQueryImportFarmerCustomerWithStoreId:self.storeId
                                                             inputList:self.viewModel.getInputList
                                                               success:^(NSDictionary *responseObject) {
                                                                   
        [[KKToast makeToast:@"导入成功"] show];
        [[CMRouter sharedInstance]popViewController];
                                                                   
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [[KKToast makeToast:errorMsg] show];
    }];
}
#pragma mark - MemberImportContactsToastViewDelegate
/** 关闭toast*/
- (void)toastViewTapCloseBtn:(MemberImportContactsToastView *)toastView {
    [UIView animateWithDuration:0.25 animations:^{
        [self.toastView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(self.navBarHeight - menberToastViewH);
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(self.navBarHeight);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.toastView removeFromSuperview];
        self.toastView = nil;
    }];
}
#pragma mark - event
/** 跳转设置*/
- (void)onSetButtonAction {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - getter
- (MemberImportContactsModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MemberImportContactsModel alloc]init];
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.sectionIndexColor = [UIColor colorWithHexString:@"#666666"];
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (MemberImportContactsBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[MemberImportContactsBottomBar alloc]init];
        _bottomBar.delegate = self;
        [self.view addSubview:_bottomBar];
        [_bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
            make.height.mas_equalTo(menberBottomBarH);
        }];
    }
    return _bottomBar;
}

- (KKLoadFailureAndNotResultView *)resultView
{
    if (!_resultView) {
        
        _resultView =  [KKLoadFailureAndNotResultView noResultViewWithImageName:Default_contactsetting];
        [_resultView addSubview:self.setButton];
        [self.setButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(_resultView.mas_centerX);
            make.height.mas_equalTo(57);
            make.width.mas_equalTo(300);
            make.top.offset(300);
            
        }];
        
    }
    return _resultView;
}

- (UIButton *)setButton
{
    if (!_setButton) {
        
        _setButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setButton addTarget:self action:@selector(onSetButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_setButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_setButton setTitle:@"马上设置" forState:UIControlStateNormal];
        [_setButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _setButton.titleLabel.font = APPFONT(18);
        [_setButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _setButton;
}


- (MemberImportContactsToastView *)toastView {
    if (!_toastView) {
        _toastView = [[MemberImportContactsToastView alloc]init];
        _toastView.delegate = self;
        [self.view addSubview:_toastView];
    }
    return _toastView;
}

@end
