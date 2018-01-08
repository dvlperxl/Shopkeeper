//
//  MemberListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberListViewController.h"
#import "MemberModel.h"
#import "MemberListTableViewCell.h"


@interface MemberListViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)KKSectionModel *sectionModel;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;

@end

@implementation MemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    self.navigationItem.title = @"会员列表";
    self.tableView.tableViewModel = self.tableViewModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pageNo =1;
    [self httpRequestQueryFarmerList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request

- (void)httpRequestQueryFarmerList
{
    
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryFarmerCustomerList:nil
                                                  storeId:self.storeId
                                                querytype:@"desc"
                                                  orderBy:@"amount"
                                                 pageSize:@20
                                                   pageNo:@(self.pageNo)
                                                  success:^(NSDictionary *responseObject)
    {
        
        NSArray *memberList = [MemberModel modelObjectListWithArray:responseObject[@"result"]];
        NSNumber *total = responseObject[@"total"];
        if (self.pageNo == 1) {
            [self.sectionModel removeAllObjects];
        }
        [self.sectionModel addCellModelList:[MemberModel cellModelList:memberList]];
        self.tableView.tableViewModel = self.tableViewModel;
        self.pageNo +=1;
        self.tableView.mj_footer = self.footer;
        if (total.integerValue>self.sectionModel.cellDataList.count)
        {
            [self.tableView.mj_footer endRefreshing];

        }else
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
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

#pragma mark - onButtonClick

/**
 新增会员
 */
- (void)onAddMemberButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"AddMemberViewController" param:param];
}

/**
 会员导入
 */
- (void)onImportMemberButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"MemberImportContactsController" param:param];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKCellModel *model = [self.tableViewModel cellModelAtIndexPath:indexPath];
    MemberListTableViewCellModel *data = model.data;
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:data.customerId forKey:@"customerId"];
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"MemberDetailViewController" param:param];
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
    

    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(onAddMemberButtonAction)];
    UIBarButtonItem *importBtn = [[UIBarButtonItem alloc]initWithTitle:@"导入" style:UIBarButtonItemStylePlain target:self action:@selector(onImportMemberButtonAction)];
    self.navigationItem.rightBarButtonItems = @[importBtn,addBtn];
    
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel = [KKTableViewModel new];
        _tableViewModel.noResultImageName = Default_nodata;
        [_tableViewModel addSetionModel:self.sectionModel];
        
    }
    return _tableViewModel;
}

- (MJRefreshAutoGifFooter *)footer
{
    if (!_footer) {
        
        __weak MemberListViewController *weakSelf = self;
        
        _footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            
            if (weakSelf) {
                
                [weakSelf httpRequestQueryFarmerList];
            }
            
        }];
        
    }
    return _footer;
}

- (KKSectionModel *)sectionModel
{
    if (!_sectionModel) {
        
        _sectionModel  = [KKSectionModel new];
        _sectionModel.headerData.height = 50;
        _sectionModel.headerData.cellClass = NSClassFromString(@"MemberTableHeaderView");
    }
    return _sectionModel;
}

@end
