//
//  StockManageViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockManageViewController.h"
#import "StockManageModel.h"
#import "StockOrderListViewController.h"
#import "ScrollPageView.h"
#import "ChooseCardTypeView.h"


@interface StockManageViewController ()
<ChooseCardTypeViewDelegate,ScrollPageViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;

@property(nonatomic,strong)StockManageModel *stockManageModel;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;

@property(nonatomic,strong)UISegmentedControl *segment;

@property(nonatomic,strong)ChooseCardTypeView * mallChooseCardTypeView;
@property(nonatomic,strong)ScrollPageView * mallScrollPageView;
@property(nonatomic,copy)NSArray * mallChildViewControllers;

@property(nonatomic,strong)ChooseCardTypeView * zyChooseCardTypeView;
@property(nonatomic,strong)ScrollPageView * zyScrollPageView;
@property(nonatomic,copy)NSArray * zyChildViewControllers;

@end

@implementation StockManageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    [self.mallChooseCardTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.offset(self.navBarHeight);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(45);
//    }];
//
//    [self.zyChooseCardTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.offset(self.navBarHeight);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(45);
//    }];
}

#pragma mark - ChooseCardTypeViewDelegate

- (void)chooseCardTypeView:(ChooseCardTypeView *)aView didSelectIndex:(NSInteger)index
{
    if ([aView isEqual:self.zyChooseCardTypeView]) {
        
        [self.zyScrollPageView setSelectPage:index];
    }else
    {
        [self.mallScrollPageView setSelectPage:index];
    }
}

#pragma mark - on button action

- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"AddStockViewController" param:param];
}

- (void)onSegmentValueChange:(UISegmentedControl*)segment
{
    if (segment.selectedSegmentIndex == 0) {
        
        [self.view bringSubviewToFront:self.mallChooseCardTypeView];
        [self.view bringSubviewToFront:self.mallScrollPageView];
        
    }else if (segment.selectedSegmentIndex == 1)
    {
        [self.view bringSubviewToFront:self.zyChooseCardTypeView];
        [self.view bringSubviewToFront:self.zyScrollPageView];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"进货管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"进货开单" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
    
    [self.view addSubview:self.zyChooseCardTypeView];
    [self.view addSubview:self.zyScrollPageView];
    
    NSArray *statusList0 = @[@"2",@"3",@"10"];

    NSMutableArray * zyArray = [NSMutableArray array];
    for (NSInteger i=0; i<3; i++) {
        
        StockOrderListViewController * VC = [[CMRouter sharedInstance]getObjectWithClassName:@"StockOrderListViewController"];
        VC.storeId = self.storeId;
        VC.fromType = @"1";
        VC.status = statusList0[i];
        [self addChildViewController:VC];
        [self.zyScrollPageView addPage:VC.view];
        [zyArray addObject:VC];
    }
    self.zyChildViewControllers=[zyArray copy];
    
    [self.view addSubview:self.mallChooseCardTypeView];
    [self.view addSubview:self.mallScrollPageView];
    
//    状态 1：待确认，2：待送货 3:已收货，4 撤销 7 待支付
    NSArray *statusList1 = @[@"1",@"7",@"2",@"3",@"10"];
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i=0; i<5; i++) {
        
        StockOrderListViewController * VC = [[CMRouter sharedInstance]getObjectWithClassName:@"StockOrderListViewController"];
        VC.storeId = self.storeId;
        VC.fromType = @"0";
        VC.status = statusList1[i];
        [self addChildViewController:VC];
        [self.mallScrollPageView addPage:VC.view];
        [array addObject:VC];
    }
    self.mallChildViewControllers=[array copy];
    
    
    self.navigationItem.titleView = self.segment;
}

- (ChooseCardTypeView *)mallChooseCardTypeView
{
    if (!_mallChooseCardTypeView) {
        
        _mallChooseCardTypeView = [[ChooseCardTypeView alloc]initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, 45)];
        [_mallChooseCardTypeView setHeadTitleArray:@[@"待确认",@"待支付",@"待收货",@"已收货",@"退货"]];
        _mallChooseCardTypeView.delegate = self;
    }
    
    return _mallChooseCardTypeView;
}

- (ChooseCardTypeView *)zyChooseCardTypeView
{
    if (!_zyChooseCardTypeView) {
        
        _zyChooseCardTypeView = [[ChooseCardTypeView alloc]initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, 45)];
        [_zyChooseCardTypeView setHeadTitleArray:@[@"待收货",@"已收货",@"退货"]];
        _zyChooseCardTypeView.delegate = self;
    }
    
    return _zyChooseCardTypeView;
}

- (ScrollPageView*)mallScrollPageView
{
    if (_mallScrollPageView == nil) {
        
        _mallScrollPageView = [[ScrollPageView alloc]initWithFrame:CGRectMake(0, self.navBarHeight+55, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight-55)];
        _mallScrollPageView.delagate = self;
        [_mallScrollPageView scrollEnabled:NO];
    }
    return _mallScrollPageView;
}

- (ScrollPageView*)zyScrollPageView
{
    if (_zyScrollPageView == nil) {
        
        _zyScrollPageView = [[ScrollPageView alloc]initWithFrame:CGRectMake(0, self.navBarHeight+55, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight-55)];
        _zyScrollPageView.delagate = self;
        [_zyScrollPageView scrollEnabled:NO];
    }
    return _zyScrollPageView;
}

- (UISegmentedControl *)segment
{
    if (!_segment) {
        
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"商城订单",@"自营订单"]];
        _segment.frame = CGRectMake(-14, 0, 160, 32);
        _segment.tintColor = ColorWithHex(@"#80848F");
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(onSegmentValueChange:) forControlEvents:UIControlEventValueChanged];
        _segment.layer.masksToBounds = YES;
        _segment.layer.cornerRadius = 16;
        _segment.layer.borderColor =  ColorWithHex(@"#80848F").CGColor;
        _segment.layer.borderWidth =  1;

    }
    return _segment;
}

- (void)setCallBack:(NSDictionary *)callBack
{
    NSString *actionName = callBack[@"actionName"];
    if ([actionName isEqualToString:@"queryMallOrderList"])
    {
        [self.segment setSelectedSegmentIndex:0];
        [self.mallChooseCardTypeView setSelectIndex:2];
        [self.mallScrollPageView setSelectPage:2];
    }
}

@end
