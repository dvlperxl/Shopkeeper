//
//  BusinessAnalysisHomeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BusinessAnalysisHomeViewController.h"
#import "BAHomeModel.h"
#import "BAHomeTableHeaderView.h"

@interface BusinessAnalysisHomeViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)BAHomeTableHeaderView *tableHeaderView;

@end

@implementation BusinessAnalysisHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"经营分析";
    [self initSubviews];
    [self httpRequestStoreAnalys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)httpRequestStoreAnalys
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestQueryStoreAnalys:self.storeId
                                           success:^(NSDictionary *responseObject) {
                                               
                                               [KKProgressHUD hideMBProgressForView:self.view];
                                               BAHomeTableHeaderViewModel *headerModel = [BAHomeTableHeaderViewModel modelObjectWithDictionary:responseObject];
                                               [self.tableHeaderView reloadData:headerModel];
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
    }];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    
    if (indexPath.row == 0)
    {
        [[CMRouter sharedInstance]showViewController:@"DailyCheckListViewController" param:param.copy];
        
    }else
    {
        NSArray *paths = @[@"",@"/api/pages/managementAnalysis/transactionAnalysis.html",
                           @"/api/pages/managementAnalysis/MembershipAnalysis.html",
                           @"/api/pages/managementAnalysis/commodityAnalysis.html"];
        NSString *path = [self pathAppendBaseURL:paths[indexPath.row]];
        NSLog(@"%@",path);
        
        NSString *url = [self urlAppendBaseParam:path];
        NSLog(@"%@",url);
        [[CMRouter sharedInstance]showViewController:@"WebViewController" param:@{@"url":url}];
    }
}

#pragma mark - initSubviews

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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.tableViewModel = [BAHomeModel tableViewModel];
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    
    return _tableView;
}

- (BAHomeTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[BAHomeTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        
    }
    return _tableHeaderView;
}

@end
