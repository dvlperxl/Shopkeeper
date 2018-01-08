//
//  MemberDetailViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "MemberDetailModel.h"

@interface MemberDetailViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)MemberDetailModel *memberDetailModel;

@end

@implementation MemberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会员详情";
    [self initSubviews];
    [self httpRequestQueryFarmerDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)httpRequestQueryFarmerDetail
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryFarmerDetail:self.customerId
                                            success:^(NSDictionary *responseObject)
    {
                                                [KKProgressHUD hideMBProgressForView:self.view];
                                                MemberDetailModel *model = [MemberDetailModel modelObjectWithDictionary:responseObject];
                                                _memberDetailModel = model;
                                                self.tableView.tableViewModel = [model tableViewModel];
        
        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
        
        __weak typeof(self) weakself = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakself httpRequestQueryFarmerDetail];
                                                                                   
                                                                               }] ];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        NSString *name = self.memberDetailModel.customer[@"customerNme"];
        NSString *mobile = self.memberDetailModel.customer[@"customerPhone"];
        NSDictionary *areaDto = self.memberDetailModel.customer[@"areaDto"];
        NSMutableString *area = [NSMutableString stringWithCapacity:1];
        
        if (areaDto[@"province"])
        {
            [area appendString:areaDto[@"province"]];
        }
        if (areaDto[@"city"]) {
            
            [area appendString:areaDto[@"city"]];
        }
        
        if (areaDto[@"district"]) {
            
            [area appendString:areaDto[@"district"]];
        }
        NSString *village = areaDto[@"village"];
        if (village)
        {
            if (areaDto[@"town"]) {
                
                [area appendString:areaDto[@"town"]];
            }
        }else
        {
            village = areaDto[@"town"];
        }
        NSString *address = self.memberDetailModel.customer[@"address"];
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:name forKey:@"name"];
        [param setObject:mobile forKey:@"mobile"];
        [param setObject:area forKey:@"area"];
        [param setObject:village forKey:@"village"];
        [param setObject:address forKey:@"address"];
        [[CMRouter sharedInstance]showViewController:@"MemberBasicInfoViewController" param:param];

        
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            NSMutableDictionary *param = @{}.mutableCopy;
            [param setObject:self.storeId forKey:@"storeId"];
            [param setObject:self.customerId forKey:@"farmercustomer"];
            [[CMRouter sharedInstance]showViewController:@"MemberShoppingViewController" param:param];
        }else
        {
            NSMutableDictionary *param = @{}.mutableCopy;
            [param setObject:self.customerId forKey:@"customerId"];
            [[CMRouter sharedInstance]showViewController:@"MemberCreditViewController" param:param];
        }
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
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        //        _tableView.tableHeaderView = self.tableHeaderView;
    }
    
    return _tableView;
}


@end
