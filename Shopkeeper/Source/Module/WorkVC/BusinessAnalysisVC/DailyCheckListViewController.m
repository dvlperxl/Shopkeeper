//
//  DailyCheckListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "DailyCheckListViewController.h"
#import "NSDate+DateFormatter.h"
#import "DailyCheckModel.h"
#import "DailyCheckHeaderView.h"
#import "KKModelController.h"


@interface DailyCheckListViewController ()<DailyCheckHeaderViewDelgegate,UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,strong)KKModelController *mc;

@end

@implementation DailyCheckListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"每日对账";
    [self initSubviews];
    
    NSString *queryDate = [[NSDate date] stringWithDateFormatter:YYYY_MM_dd];
    [self httpRequestDailyCheckList:queryDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpRequestDailyCheckList:(NSString*)queryDate
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryDailyCheckWithStoreId:self.storeId
                                                   queryDate:queryDate
                                                     success:^(NSDictionary *responseObject) {
                                                         
                                                         [KKProgressHUD hideMBProgressForView:self.view];
                                                         DailyCheckModel *model = [DailyCheckModel modelObjectWithDictionary:responseObject];
                                                         model.dateString = queryDate;
                                                         
                                                         self.tableView.tableViewModel = [model tableViewModel];
                                                         
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
        
        __weak typeof(self) weakSelf = self;
        
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestDailyCheckList:queryDate];
                                                                               }] ];
        
    }];
}

- (void)onPickerDataButton:(UIButton*)button
{
    if (button.tag == 1)
    {
        NSString *queryDate = [self.datePicker.date stringWithDateFormatter:YYYY_MM_dd];
        [self httpRequestDailyCheckList:queryDate];
    }
    [_mc dismiss];
}

#pragma mark - DailyCheckHeaderViewDelgegate

- (void)dailyCheckHeaderViewDidSelectChooseDateTime
{
    KKModelController *p = [KKModelController presentationControllerWithContentView:self.pickerBgView];
    _mc = p;
    [p showInSuperView:self.navigationController.view];
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
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIDatePicker*)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = ColorWithRGB(216, 216, 216, 1);
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        _datePicker.maximumDate = [NSDate date];
    }
    return _datePicker;
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
        [_pickerBgView addSubview:self.datePicker];
    }
    return _pickerBgView;
}

@end
