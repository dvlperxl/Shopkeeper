//
//  NoticeListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "NoticeListViewController.h"
#import "NoticeListModel.h"

@interface NoticeListViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)NSArray *dataSource;


@end

@implementation NoticeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"公告列表";
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequestNoticeList];
}


- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"PublishNoticeViewController" param:param];
}

#pragma mark - httpRequest

- (void)httpRequestNoticeList
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryNoticeList:[KeyChain getUserId]
                                          success:^(NSDictionary *responseObject) {
                                              
                                              [KKProgressHUD hideMBProgressForView:self.view];
                                              _dataSource = (NSArray*)responseObject;
                                              self.tableView.tableViewModel = [NoticeListModel tableViewModel:_dataSource];
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
        
        __weak typeof(self) weakSelf = self;
        
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestNoticeList];
                                                                                   
                                                                               }] ];
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *notice = _dataSource[indexPath.section];
    if ([notice[@"reSend"] integerValue]==1)
    {
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:notice[@"title"] forKey:@"titleStr"];
        [param setObject:notice[@"mainBody"] forKey:@"mainBody"];
        [param setObject:notice[@"contacts"] forKey:@"contacts"];
        [param setObject:self.storeId forKey:@"storeId"];
        [[CMRouter sharedInstance]showViewController:@"PublishNoticeViewController" param:param];
    }
}

#pragma mark - initSubviews


- (void)initSubviews
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布公告" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
    
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
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    
    return _tableView;
}


@end
