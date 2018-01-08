//
//  OrderListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListModel.h"
#import "OrderListTableViewCell.h"

@interface OrderListViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;

@end

@implementation OrderListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.navTitle;
    [self initSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.status.integerValue == 9) {
        
        [self httpRequestQueryStoreReturnList];
        
    }else
    {
        [self httpRequestOrderList];
    }

}

- (void)httpRequestOrderList
{
    [[APIService share]httpRequestQueryOrderListWithStatus:self.status
                                                   storeId:self.storeId
                                            farmercustomer:nil
                                                   success:^(NSDictionary *responseObject) {
                                                       self.tableView.tableViewModel = [OrderListModel tableViewModel:(NSArray*)responseObject status:self.status];
                                                       
                                                   } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                       __weak typeof(self) weakSelf = self;
                                                       [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                                              tapBlock:^{
                                                                                                                                  
                                                                                                                                  [weakSelf httpRequestOrderList];
                                                                                                                                  
                                                                                                                              }] ];

                                                
                                                       
                                                   }];
}

- (void)httpRequestQueryStoreReturnList
{
    [[APIService share]httpRequestQueryStoreReturnList:self.storeId
                                               success:^(NSDictionary *responseObject) {
                                                   
                                                   self.tableView.tableViewModel = [OrderListModel tableViewModel:(NSArray*)responseObject status:self.status];

        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        __weak typeof(self) weakSelf = self;

        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestQueryStoreReturnList];
            
        }] ];
        
 
        
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KKCellModel *cellModel = [self.tableView.tableViewModel cellModelAtIndexPath:indexPath];
    OrderListTableViewCellModel *dataModel = cellModel.data;
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:dataModel.oid forKey:@"orderId"];
    [param setObject:self.status forKey:@"status"];
    [[CMRouter sharedInstance]showViewController:@"OrderDetailViewController" param:param];
}



- (void)initSubviews
{
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
