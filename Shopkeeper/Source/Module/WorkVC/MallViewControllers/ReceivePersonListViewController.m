//
//  ReceivePersonListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReceivePersonListViewController.h"
#import "ReceivePersonListModel.h"

@interface ReceivePersonListViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;

@end

@implementation ReceivePersonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self httpRequestSupplierList];
}

#pragma mark - http request

- (void)httpRequestSupplierList
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestQueryStoreAddressList:self.storeId
                                                success:^(NSDictionary *responseObject) {
                                                    [KKProgressHUD hideMBProgressForView:self.view];
                                                 ReceivePersonListModel *model  = [[ReceivePersonListModel alloc]init];
                                                    self.tableView.tableViewModel = [model tableViewModel:(NSArray*)responseObject storeId:self.storeId selectAddressId:self.addressId];
                                                    
                                                } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                    
                                                    [KKProgressHUD hideMBProgressForView:self.view];
                                                    __weak typeof(self) weakSelf = self;
                                                    [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                                           tapBlock:^{
                                                                                                                               
                                                                                                                               [weakSelf httpRequestSupplierList];
                                                                                                                               
                                                                                                                           }] ];
                                                    
                                                }];
    

}

- (void)selectCell:(NSDictionary*)param
{
    NSMutableDictionary *callBack = @{}.mutableCopy;
    [callBack setObject:param forKey:@"parameters"];
    [callBack setObject:@"receivePerson" forKey:@"action"];
    [[CMRouter sharedInstance]backToViewController:@"MallOrderInfoViewController" param:@{@"callBack":callBack}];
}

#pragma mark - on button action

- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"AddReceivePeopleViewController" param:param];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"收货人信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
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

@end
