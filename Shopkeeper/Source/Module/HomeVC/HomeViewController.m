//
//  HomeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "UITabBar+Badge.h"
#import "JPush.h"

@interface HomeViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    [self initSubviews];
    self.tableView.tableViewModel = [HomeModel tableViewModel:@0];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [self httpRequest];
}

- (void)httpRequest
{
    [[APIService share]httpRequestQuerySystemUnreadMessageCountSuccess:^(NSDictionary *responseObject) {
        
        if ([responseObject isKindOfClass:[NSNumber class]])
        {
            NSNumber *count = (NSNumber*)responseObject;
            self.tableView.tableViewModel = [HomeModel tableViewModel:count];
            [self.tabBarController.tabBar showBadgeOnItemIndex:2 count:count.integerValue];
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count.integerValue];
            [JPush setBadge:count.integerValue];
        }
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [[CMRouter sharedInstance]showViewController:@"MessageListViewController" param:@{@"leftButtonTitle":@"聊聊"}];

    }else
    {
        [[CMRouter sharedInstance]showViewController:@"AppNoticeListViewController" param:@{@"leftButtonTitle":@"聊聊"}];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
//        _tableView.tableHeaderView = self.tableHeaderView;
//        _tableView.tableViewModel = self.tableViewModel;
    }
    return _tableView;
}



@end
