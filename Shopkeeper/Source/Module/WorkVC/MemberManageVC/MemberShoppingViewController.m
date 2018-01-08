//
//  MemberShoppingViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/25.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberShoppingViewController.h"
#import "OrderListModel.h"
#import "OrderListTableViewCell.h"
#import "MemberShoppingModel.h"

@interface MemberShoppingViewController ()

@property(nonatomic,strong)KKTableView *tableView;


@end

@implementation MemberShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消费记录";
    [self initSubviews];

    [self httpRequestOrderList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequestOrderList
{
    [[APIService share]httpRequestQueryOrderListWithStatus:nil
                                                   storeId:self.storeId
                                            farmercustomer:self.farmercustomer
                                                   success:^(NSDictionary *responseObject) {
                                                       
                                                       KKTableViewModel *tableViewModel = [MemberShoppingModel tableViewModel:(NSArray*)responseObject];
                                                       tableViewModel.noResultImageName = Default_nodata;
                                                       self.tableView.tableViewModel = tableViewModel;
                                                       
                                                   } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                       
                                                       [KKProgressHUD hideMBProgressForView:self.view];
                                                       __weak typeof(self) weakSelf = self;
                                                       [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                                                              tapBlock:^{
                                                                                                                                  
                                                                                                                                  [weakSelf httpRequestOrderList];
                                                                                                                                  
                                                                                                                              }] ];
                                                   }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    KKCellModel *cellModel = [self.tableView.tableViewModel cellModelAtIndexPath:indexPath];
//    OrderListTableViewCellModel *dataModel = cellModel.data;
//    NSMutableDictionary *param = @{}.mutableCopy;
//    [param setObject:dataModel.oid forKey:@"orderId"];
//    [[CMRouter sharedInstance]showViewController:@"OrderDetailViewController" param:param];
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
//        _tableView.delegate = self;
    }
    
    return _tableView;
}


@end
