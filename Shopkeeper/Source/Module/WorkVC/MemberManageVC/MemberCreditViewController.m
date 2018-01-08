//
//  MemberCreditViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberCreditViewController.h"
#import "MemberCreditModel.h"


@interface MemberCreditViewController ()

@property(nonatomic,strong)KKTableView *tableView;

@end

@implementation MemberCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"赊欠记录";
    [self initSubviews];
    [self httpRequestQueryFarmerRetail];
}

- (void)httpRequestQueryFarmerRetail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestQueryFarmerRetailAndCreditPay:self.customerId
                                                        success:^(NSDictionary *responseObject) {
                                                            
                                                            [KKProgressHUD hideMBProgressForView:self.view];
                                                            KKTableViewModel *tableViewModel = [MemberCreditModel tableViewModel:responseObject[@"creditDtos"]];
                                                            tableViewModel.noResultImageName = Default_nodata;
                                                            self.tableView.tableViewModel = tableViewModel;
                                                            
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
        
        __weak typeof(self) weakSelf = self;
        
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestQueryFarmerRetail];
                                                                                   
                                                                               }] ];
        
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    }
    
    return _tableView;
}



@end
