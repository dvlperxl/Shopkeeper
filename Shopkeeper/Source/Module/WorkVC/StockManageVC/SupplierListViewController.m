//
//  SupplierListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SupplierListViewController.h"
#import "SupplierListModel.h"
#import "SupplierListTableViewCell.h"

@interface SupplierListViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;

@end

@implementation SupplierListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    self.pageNo = 1;
    [self httpRequestSupplierList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - http request

- (void)httpRequestSupplierList
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestSupplierListWithStoreId:self.storeId
                                                   pageNo:self.pageNo
                                                 pageSize:20
                                                  success:^(NSDictionary *responseObject) {
                                                      
                                                      [KKProgressHUD hideMBProgressForView:self.view];
                                                      if (self.pageNo == 1)
                                                      {
                                                          [self.tableViewModel removeAllObjects];
                                                      }
                                                      KKSectionModel *sectionModel = [SupplierListModel sectionModelWithSupplierList:(NSArray*)responseObject];
                                                      [self.tableViewModel addSetionModel:sectionModel];
                                                      self.tableView.tableViewModel =  self.tableViewModel;
                                                      self.pageNo +=1;
                                                      self.tableView.mj_footer = self.footer;
                                                      if (responseObject.count==20)
                                                      {
                                                          [self.tableView.mj_footer endRefreshing];
                                                          
                                                      }else
                                                      {
                                                          [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                                      }

        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
        
        [KKProgressHUD hideMBProgressForView:self.view];
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestSupplierList];
                                                                                   
                                                                               }] ];
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    SupplierListTableViewCellModel *model = cellModel.data;
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:@"addSupplier" forKey:@"action"];
    [md setObject:model.uid forKey:@"id"];
    [md setObject:model.title forKey:@"name"];
    [[CMRouter sharedInstance]backToViewController:@"AddStockViewController" param:@{@"callBack":md}];
}

#pragma mark - on button action

- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"AddSupplierViewController" param:param];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"供应商列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增供应商" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
    
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
        _tableView.tableViewModel = self.tableViewModel;
    }
    return _tableView;
}

- (KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel = [SupplierListModel tableViewModel];
    }
    return _tableViewModel;
}

- (MJRefreshAutoGifFooter *)footer
{
    if (!_footer) {
        
        __weak SupplierListViewController *weakSelf = self;
        
        _footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            
            if (weakSelf) {
                
                [weakSelf httpRequestSupplierList];
            }
            
        }];
        
    }
    return _footer;
}


@end
