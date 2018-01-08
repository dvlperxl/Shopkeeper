//
//  MyViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableHeaderView.h"
#import "MyTableViewCell.h"
#import "MyViewModel.h"

@interface MyViewController ()

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)MyTableHeaderView *tableHeaderView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navView.alpha = 0;
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.tableHeaderView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    KKCellModel *cellModel = [_tableViewModel cellModelAtIndexPath:indexPath];
//    if ([cellModel.cellType isEqualToString:@"我的门店"])
//    {
//        [[CMRouter sharedInstance]showViewController:@"MyShopListViewController" param:@{@"leftButtonTitle":@"我的"}];
//
//    }else if ([cellModel.cellType isEqualToString:@"服务中心"])
//    {
//        [[CMRouter sharedInstance]showViewController:@"ServiceCenterViewController" param:@{@"leftButtonTitle":@"我的"}];
//
//    }else if ([cellModel.cellType isEqualToString:@"关于我们"])
//    {
//        [[CMRouter sharedInstance]showViewController:@"AboutUSViewController" param:@{@"leftButtonTitle":@"我的"}];
//    }
//}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.delegate = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.tableViewModel = [MyViewModel tableViewModel];
    }
    
    return _tableView;
}

- (MyTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {

        _tableHeaderView = [[MyTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100+64)];
        _tableHeaderView.backgroundColor = ColorWithRGB(242, 151, 0, 1);
    }
    return _tableHeaderView;
}

//-(KKTableViewModel *)tableViewModel
//{
//    if (!_tableViewModel)
//    {
//        _tableViewModel = [KKTableViewModel new];
//        NSArray *images = @[@"ico_mystore",@"ico_intro",@"ico_aboutus"];
//        NSArray *titles = @[@"我的门店",@"服务中心",@"关于我们"];
//
//        for (NSInteger i = 0;i<images.count;i++)
//        {
//            KKSectionModel *section = [KKSectionModel new];
//            section.headerData.height = 10;
//            KKCellModel *cellModel = [KKCellModel new];
//            cellModel.height = 75;
//            cellModel.cellClass = NSClassFromString(@"MyTableViewCell");
//            cellModel.cellType = titles[i];
//            MyTableViewCellModel *data = [MyTableViewCellModel new];
//            data.iconImageName =images[i];
//            data.content = titles[i];
//            cellModel.data = data;
//            [section addCellModel:cellModel];
//            [_tableViewModel addSetionModel:section];
//        }
//    }
//    return _tableViewModel;
//}

@end
