//
//  DistibutorManageViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorManageViewController.h"
#import "ChooseCardTypeView.h"
#import "DistibutorOrderListViewController.h"

@interface DistibutorManageViewController ()<ChooseCardTypeViewDelegate>

@property(nonatomic,strong)ChooseCardTypeView * chooseCardTypeView;

@property(nonatomic,strong)DistibutorOrderListViewController *vc1;
@property(nonatomic,strong)DistibutorOrderListViewController *vc2;
@property(nonatomic,strong)DistibutorOrderListViewController *vc3;
@property(nonatomic,strong)DistibutorOrderListViewController *vc4;
@property(nonatomic,strong)NSNumber *state;

@end

@implementation DistibutorManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"分销订单";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(onRightButtonAction)];
    [self initSubviews];
    [self chooseCardTypeView:nil didSelectIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:self.state forKey:@"state"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"DistibutorOrderSearchViewController" param:param];
//    [[CMRouter sharedInstance]showViewController:@"DistibutorOrderSearchViewController" param:param];
}

#pragma mark - ChooseCardTypeViewDelegate

- (void)chooseCardTypeView:(ChooseCardTypeView *)aView didSelectIndex:(NSInteger)index
{
    DistibutorOrderListViewController *vc;
    
    switch (index)
    {
        case 0:
            vc = self.vc1;
            break;
        case 1:
            vc = self.vc2;
            break;
        case 2:
            vc = self.vc3;
            break;
        case 3:
            vc = self.vc4;
            break;
        default:
            break;
    }
    
    if (vc) {
        
        self.state = vc.state;
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.bottom.equalTo(self.mas_bottomLayoutGuide);
            make.top.equalTo(self.chooseCardTypeView.mas_bottom).offset(10);
        }];
        [self.view bringSubviewToFront:vc.view];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.chooseCardTypeView];
}

- (ChooseCardTypeView *)chooseCardTypeView
{
    if (!_chooseCardTypeView) {
        
        _chooseCardTypeView = [[ChooseCardTypeView alloc]initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, 45)];
        [_chooseCardTypeView setHeadTitleArray:@[@"待确认",@"待支付",@"待收货",@"已收货"]];
        _chooseCardTypeView.delegate = self;
    }
    
    return _chooseCardTypeView;
}

- (DistibutorOrderListViewController *)vc1
{
    if (!_vc1)
    {
        _vc1 =  [[DistibutorOrderListViewController alloc]init];
        _vc1.state = @1;
        _vc1.storeId = self.storeId;
        
    }
    return _vc1;
}

- (DistibutorOrderListViewController *)vc2
{
    if (!_vc2)
    {
        _vc2 =  [[DistibutorOrderListViewController alloc]init];
        _vc2.state = @7;
        _vc2.storeId = self.storeId;
        
    }
    return _vc2;
}


- (DistibutorOrderListViewController *)vc3
{
    if (!_vc3)
    {
        _vc3 =  [[DistibutorOrderListViewController alloc]init];
        _vc3.state = @2;
        _vc3.storeId = self.storeId;
        
    }
    return _vc3;
}

- (DistibutorOrderListViewController *)vc4
{
    if (!_vc4)
    {
        _vc4 =  [[DistibutorOrderListViewController alloc]init];
        _vc4.state = @3;
        _vc4.storeId = self.storeId;
        
    }
    return _vc4;
}



@end
