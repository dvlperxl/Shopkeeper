//
//  SMSRechargeListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//15221758995 推送

#import "SMSRechargeListViewController.h"
#import "SMSRechargeListModel.h"

@interface SMSRechargeListViewController ()

@property(nonatomic,strong)KKTableView *tableView;

@end

@implementation SMSRechargeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"短信充值记录";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [self httpRequestOrderList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequestOrderList
{
    [KKProgressHUD showMBProgressAddTo:self.view];

    [[APIService share]httpRequestGetStoreSmsOrderListWithStoreId:self.storeId
                                                          success:^(id responseObject) {
                                                              [KKProgressHUD hideMBProgressForView:self.view];

                                                              self.tableView.tableViewModel = [SMSRechargeListModel tableViewModel:responseObject];
        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

    }];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
    }
    return _tableView;
}

@end
