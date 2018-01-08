//
//  MyShopListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MyShopListViewController.h"
#import "StoreModel.h"
#import "UserBaseInfo.h"

@interface MyShopListViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)UIButton *addStoreButton;
@property(nonatomic,strong)NSArray *stores;
@property(nonatomic,strong)KKLoadFailureAndNotResultView *resultView;

@end

@implementation MyShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的门店";
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequestQueryStoresByUser];
}

#pragma mark - httpRequest

- (void)httpRequestQueryStoresByUser
{
    NSString *userId = [KeyChain getUserId];
    if (self.tableView.tableViewModel == nil)
    {
        [KKProgressHUD showMBProgressAddTo:self.view];
    }
    [[APIService share]httpRequestQueryStoresByUser:userId
                                            success:^(NSDictionary *responseObject) {
                                                
                                                _stores = [responseObject objectForKey:@"stores"];
                                                
                                                self.tableView.tableViewModel = [StoreModel tableViewModelWithStoreList:_stores];
                                                [self.tableView reloadData];
                                                
                                                if (self.stores.count == 0)
                                                {
                                                    [self.view addSubview:self.resultView];
                                                    [self.view addSubview:self.addStoreButton];

                                                    [self.addStoreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                                                        make.centerX.equalTo(self.view.mas_centerX);
                                                        make.height.mas_equalTo(57);
                                                        make.width.mas_equalTo(300);
                                                        make.top.offset(380);
                                                    }];
                                                    
                                                }else
                                                {
                                                    [self.view addSubview:self.addStoreButton];
                                                    [self.resultView removeFromSuperview];
                                                    [self.addStoreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                                                        make.centerX.equalTo(self.view.mas_centerX);
                                                        make.height.mas_equalTo(57);
                                                        make.width.mas_equalTo(300);
                                                        make.bottom.offset(0);
                                                    }];
                                                }
                                                
                                                [KKProgressHUD hideMBProgressForView:self.view];
                                                
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
        __weak typeof(self) weakSelf = self;

        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestQueryStoresByUser];
                                                                                   
                                                                               }] ];

        
    }];
}

#pragma mark - on button action

- (void)onAddStoreButtonAction
{
    [[CMRouter sharedInstance]showViewController:@"AddStoreViewController" param:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *param = [StoreModel addStoreParam:_stores[indexPath.row]];
    
    [[CMRouter sharedInstance]showViewController:@"AddStoreViewController" param:param];
    
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addStoreButton];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-60);
        make.top.equalTo(self.mas_topLayoutGuide);

    }];


}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (UIButton *)addStoreButton
{
    if (!_addStoreButton) {
        
        _addStoreButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addStoreButton addTarget:self action:@selector(onAddStoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_addStoreButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [_addStoreButton setTitle:@"添加门店" forState:UIControlStateNormal];
        [_addStoreButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        _addStoreButton.titleLabel.font = APPFONT(18);
        [_addStoreButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    }
    return _addStoreButton;
}

- (KKLoadFailureAndNotResultView *)resultView
{
    if (!_resultView) {
        
        _resultView =  [KKLoadFailureAndNotResultView noResultViewWithTitle:@"你还没添加门店" desc:@"添加后，可进行门店管理"];

    }
    return _resultView;
}

@end
