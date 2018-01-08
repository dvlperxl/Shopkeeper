//
//  WorkHomeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkHomeViewController.h"
#import "WorkHomeTableHeaderView.h"
#import "WorkHomeModel.h"
#import "WorkStoreModel.h"
#import "KKModelController.h"
#import "WorkHomeTableViewCell.h"
#import "HNFirstToastView.h"

@interface WorkHomeViewController ()<WorkHomeTableHeaderViewDelegate,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,WorkHomeTableViewCellDelegate>

@property(nonatomic,strong)WorkHomeModel *viewModel;
@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)WorkHomeTableHeaderView *tableHeaderView;
@property(nonatomic,strong)WorkStoreModel *selectStore;
@property(nonatomic,strong)NSArray *storeList;

@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,strong)HNFirstToastView *firstToastView;
@property(nonatomic,strong)NSMutableArray *pickerDataSource;
@property(nonatomic,strong)KKModelController *mc;


@end

@implementation WorkHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navView.alpha = 0;
    [self initSubviews];
    self.tableView.tableViewModel = [self.viewModel workHomeTableViewModel];
    self.selectStore = [WorkStoreModel lastChooseStore];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequestQueryStoresByUser];
}


- (void)onPickerDataButton:(UIButton*)button
{
    if (button.tag == 1)
    {
        self.selectStore = [self.storeList objectAtIndex:[self.pickerView selectedRowInComponent:0]];
        [self.tableHeaderView reloadData:self.selectStore.storeName showChooseButton:self.storeList.count>1];
        [self.selectStore save];
        
        [self httpRequestGetStoreRecharge:self.selectStore.storeId];
    }
    
    [_mc dismiss];
}

#pragma mark - httpRequest

- (void)httpRequestQueryStoresByUser
{
    NSString *userId = [KeyChain getUserId];

    [[APIService share]httpRequestQueryStoresByUser:userId
                                            success:^(NSDictionary *responseObject) {
                                                
                                                self.storeList = [WorkStoreModel modelObjectListWithArray:[responseObject objectForKey:@"stores"]];
                                                if (self.selectStore == nil && self.storeList.count>0)
                                                {
                                                    self.selectStore = self.storeList[0];
                                                }else
                                                {
                                                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"storeId = %@",self.selectStore.storeId];
                                                    NSArray *result = [self.storeList filteredArrayUsingPredicate:pred];
                                                    
                                                    if (result && result.count>0) {
                                                        
                                                        self.selectStore = result.firstObject;
                                                    }else
                                                    {
                                                        self.selectStore = nil;
                                                    }
                                                }
                                                [self.tableHeaderView reloadData:self.selectStore.storeName showChooseButton:self.storeList.count>1];
                                                
                                                [self.selectStore save];
                                                if (self.selectStore.storeId) {
                                                    [self httpRequestGetStoreRecharge:self.selectStore.storeId];
                                                }
                                                
                                            } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                
                                                [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
                                                
                                            }];
}


- (void)httpRequestGetStoreRecharge:(NSNumber*)storeId
{
    
    [[APIService share]httpRequestGetStoreRechargeWithStoreId:storeId
                                                      success:^(NSDictionary *responseObject) {
                                                          
                                                          self.viewModel.hasPurchaseMall = [responseObject[@"hasPurchaseMall"] boolValue];
                                                          
                                                          self.viewModel.showTips = [self.viewModel showMallToastForStoreId:storeId];
                                                          self.tableView.tableViewModel = [self.viewModel workHomeTableViewModel];
//                                                          self.firstToastView.hidden = ![self.viewModel showMallToastForStoreId:storeId];
        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        
        
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.storeList.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    WorkStoreModel *model = self.storeList[row];
    return model.storeName;
}



#pragma mark - WorkHomeTableHeaderViewDelegate

- (void)workHomeTableHeaderViewDidSelectChooseStoreButton
{
    if (self.storeList.count>0) {
        
        if (self.storeList.count == 1) {
            return;
        }
        KKModelController *p = [KKModelController presentationControllerWithContentView:self.pickerBgView];
        _mc = p;
        [p showInSuperView:self.tabBarController.view];
        
        if (self.selectStore) {
            
            
            if ([self.storeList indexOfObject:self.selectStore] != NSNotFound) {
                
                [self.pickerView selectRow:[self.storeList indexOfObject:self.selectStore] inComponent:0 animated:NO];
            }
        }
        
        [self.pickerView reloadAllComponents];

    }else
    {
        [[KKToast makeToast:@"请先添加门店"] show];
    }
}

#pragma mark - WorkHomeTableViewCellDelegate

- (void)workHomeTableViewCell:(WorkHomeTableViewCell*)aCell didSelectMenuWithActionName:(NSString*)actionName
{
    if (self.selectStore.storeId)
    {
        [[CMRouter sharedInstance]showViewController:actionName param:@{@"storeId":self.selectStore.storeId,@"leftButtonTitle":@"工作"}];
        if ([actionName isEqualToString:@"MallHomeViewController"]) {  // 采购商城页面
            [self.viewModel hasShowMallToastForStoreId:self.selectStore.storeId];
        }
    }else
    {
        [[KKToast makeToast:@"请先添加门店"] show];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
    
}

- (WorkHomeModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WorkHomeModel new];
    }
    return _viewModel;
}
- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.tableHeaderView;
    }
    
    return _tableView;
}

- (WorkHomeTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView)
    {
        _tableHeaderView = [[WorkHomeTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 116)];
        _tableHeaderView.delegate = self;
    }
    return _tableHeaderView;
}


- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = ColorWithRGB(216, 216, 216, 1);
    }
    return _pickerView;
}

- (UIView *)pickerBgView
{
    if (!_pickerBgView) {
        
        _pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        _pickerBgView.backgroundColor = [UIColor whiteColor];
        
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(onPickerDataButton:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.tag = 0;
        [_pickerBgView addSubview:leftButton];
        
        UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 44)];
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [rightButton setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(onPickerDataButton:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.tag = 1;
        [_pickerBgView addSubview:rightButton];
        [_pickerBgView addSubview:self.pickerView];
        
    }
    return _pickerBgView;
}

//- (HNFirstToastView *)firstToastView {
//    if (!_firstToastView) {
//        _firstToastView = [HNFirstToastView new];
//        _firstToastView.content = @"采购商城全新上线， 快来体验一下吧！";
//        _firstToastView.hidden = YES;
//        [self.tableView addSubview:_firstToastView];
//        [_firstToastView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(self.tableView.contentSize.width - 20 - 125);
//            make.right.equalTo(self.tableView.mas_right).with.offset(-20);
//            make.top.offset(self.tableView.contentSize.height);
//            make.bottom.offset(0);
//            make.width.mas_equalTo(125);
//        }];
//    }
//    return _firstToastView;
//}


@end
