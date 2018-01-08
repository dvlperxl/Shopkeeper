//
//  MemberBasicInfoViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberBasicInfoViewController.h"
#import "AddStoreTableViewCell.h"

@interface MemberBasicInfoViewController ()

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;

@end

@implementation MemberBasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"基础信息";
    [self initSubviews];
    
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
        _tableView.tableViewModel = self.tableViewModel;
    }
    
    return _tableView;
}

-(KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel)
    {
        _tableViewModel = [KKTableViewModel new];
        NSArray *titles = @[@"姓名",@"手机号",@"所在地区",@"街道/村",@"详细地址"];
        KKSectionModel *section = [KKSectionModel new];
        [_tableViewModel addSetionModel:section];
        
        for (NSInteger i = 0;i<titles.count;i++)
        {
            KKCellModel *cellModel = [KKCellModel new];
            cellModel.height = 50;
            cellModel.cellClass = NSClassFromString(@"AddStoreTableViewCell");
            cellModel.cellType = titles[i];
            AddStoreTableViewCellModel *data = [AddStoreTableViewCellModel new];
            data.title = titles[i];
            if ([data.title isEqualToString:@"姓名"]) {
                data.content = self.name;
            }
            
            if ([data.title isEqualToString:@"手机号"]) {
                data.content = self.mobile;
            }

            if ([data.title isEqualToString:@"所在地区"]) {
                data.content = self.area;
            }

            if ([data.title isEqualToString:@"街道/村"]) {
                data.content = self.village;
            }
            
            if ([data.title isEqualToString:@"详细地址"]) {
                data.content = self.address;
            }
            
            data.edit = NO;
            data.choose = NO;
            cellModel.data = data;
            [section addCellModel:cellModel];
        }
        
    }
    return _tableViewModel;
}

@end
