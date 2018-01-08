//
//  ChooseMemberViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ChooseMemberViewController.h"
#import "ChooseMemberModel.h"

@interface ChooseMemberViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *chooseButton;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)UIButton *bottomButton;
@property(nonatomic,assign)BOOL selectAll;
@property(nonatomic,assign)NSInteger selectCount;

@end

@implementation ChooseMemberViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubviews];
    // Do any additional setup after loading the view.
    [self httpRequestQueryFarmerList];
}

- (void)httpRequestQueryFarmerList
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryFarmerCustomerList:nil
                                                  storeId:self.storeId
                                                querytype:@"desc"
                                                  orderBy:@"amount"
                                                 pageSize:@999
                                                   pageNo:@(1)
                                                  success:^(NSDictionary *responseObject)
     {
         
         NSArray *memberList = [ChooseMemberModel modelObjectListWithArray:responseObject[@"result"]];
         _bottomLab.text = [NSString stringWithFormat:@"全选(共%@人)",@(memberList.count)];
         self.tableView.tableViewModel = [ChooseMemberModel tableViewModelWithMemberList:memberList contacts:self.contacts];
         [KKProgressHUD hideMBProgressForView:self.view];
         self.selectCount = [ChooseMemberModel getSelectCellCountWithTableViewModel:self.tableView.tableViewModel];
         
         if (self.selectCount == memberList.count)
         {
             self.selectAll = YES;
             UIImage *image = self.selectAll?Image(@"icon_orange_checkbox"):Image(@"icon_grey_checkbox");
             [_chooseButton setImage:image forState:UIControlStateNormal];
         }
         
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{

    
    [super viewWillLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.offset(-51);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.right.left.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.width.height.mas_equalTo(26);
        make.centerY.equalTo(self.bottomView.mas_centerY);
    }];
    
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(61);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.offset(0);
        make.width.mas_equalTo(160);
    }];
    
    
}

#pragma mark - on button action

- (void)onChooseButtonAction
{
    if (self.selectAll) {
        
        [ChooseMemberModel removeAllCellSelectWithTableViewModel:self.tableView.tableViewModel];
        [self.tableView reloadData];
        
    }else
    {
        [ChooseMemberModel setAllCellSelectWithTableViewModel:self.tableView.tableViewModel];
        [self.tableView reloadData];
    }
    self.selectAll = !self.selectAll;
    UIImage *image = self.selectAll?Image(@"icon_orange_checkbox"):Image(@"icon_grey_checkbox");
    [_chooseButton setImage:image forState:UIControlStateNormal];
    self.selectCount = [ChooseMemberModel getSelectCellCountWithTableViewModel:self.tableView.tableViewModel];
}

- (void)onConformButtonAction
{
    if (self.selectCount<1)
    {
        [[KKToast makeToast:@"请选择会员"]show];
        
    }else
    {
        NSMutableDictionary *callBack = @{}.mutableCopy;
        
        [callBack setObject:STRINGWITHOBJECT(@(self.selectCount)) forKey:@"count"];
        [callBack setObject:@"chooseMember" forKey:@"action"];
        NSString *contacts = [ChooseMemberModel getChooseIdsWithTableViewModel:self.tableView.tableViewModel];
        [callBack setObject:contacts forKey:@"contacts"];
        [[CMRouter sharedInstance]backToViewController:@"PublishNoticeViewController" param:@{@"callBack":callBack}];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ChooseMemberModel setSelectIndexPath:indexPath tableViewModel:self.tableView.tableViewModel];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.selectCount = [ChooseMemberModel getSelectCellCountWithTableViewModel:self.tableView.tableViewModel];
    self.selectAll = self.selectCount == self.tableView.tableViewModel.sectionDataList.firstObject.cellDataList.count;
    UIImage *image = self.selectAll?Image(@"icon_orange_checkbox"):Image(@"icon_grey_checkbox");
    [_chooseButton setImage:image forState:UIControlStateNormal];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"选择会员";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.chooseButton];
        [_bottomView addSubview:self.bottomLab];
        [_bottomView addSubview:self.bottomButton];
    }
    return _bottomView;
}

- (UIButton *)chooseButton
{
    if (!_chooseButton) {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseButton setImage:Image(@"icon_grey_checkbox") forState:UIControlStateNormal];
        [_chooseButton addTarget:self action:@selector(onChooseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

- (UILabel *)bottomLab
{
    if (!_bottomLab) {
        
        _bottomLab = [[UILabel alloc]init];
        _bottomLab.font = APPFONT(15);
        _bottomLab.textColor = ColorWithHex(@"#030303");
        _bottomLab.text = @"全选(共2人)";
    }
    return _bottomLab;
}

- (UIButton *)bottomButton
{
    if (!_bottomButton) {
        
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setBackgroundColor:ColorWithHex(@"#f29700")];
        _bottomButton.titleLabel.font = APPFONT(18);
        [_bottomButton setTitleColor:ColorWithHex(@"ffffff") forState:UIControlStateNormal];
        [_bottomButton setTitle:@"确认(0人)" forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(onConformButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

- (void)setSelectCount:(NSInteger)selectCount
{
    _selectCount = selectCount;
    [_bottomButton setTitle:[NSString stringWithFormat:@"确认(%@人)",@(selectCount)] forState:UIControlStateNormal];
}

@end
