//
//  EditInfoViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/19.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "EditInfoViewController.h"
#import "AddStoreTableViewCell.h"
#import "AreaDataModel.h"
#import "KKModelController.h"
#import "HNDataBase.h"
#import "StoreModel.h"
#import "AddStoreQrCodeCell.h"
#import "UserBaseInfo.h"

#import "VillageChooseView.h"
#import "KKPresentationController.h"


@interface EditInfoViewController ()<UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,VillageChooseViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)UIView *tableFooterView;
@property(nonatomic,strong)NSMutableArray *pickerDataSource;

@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)KKModelController *mc;
@property(nonatomic,strong)NSMutableDictionary *cacheVillageMessage;
@property(nonatomic,strong)NSArray *areaList;

@property(nonatomic,strong)NSNumber *areaId;//省市区编号名称
@property(nonatomic,copy)NSString *village;//村、街道 名称
@property(nonatomic,strong)NSNumber *villageId;//村、街道 名称


@property(nonatomic,strong)VillageChooseView *villageChooseView;
@property(nonatomic,strong)KKPresentationController *pc;


@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cacheVillageMessage = @{}.mutableCopy;
    self.areaList =  [[HNDataBase share] areaList];
    self.navigationItem.title = @"完善个人信息";
    [self initSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  http request

- (void)httpRequestQueryUserInfo
{
    NSString *mobile = [KeyChain getMobileNo];
    [[APIService share]httpRequestQueryUserWithMobile:mobile
                                              success:^(NSDictionary *responseObject) {
                                                  
                                                  NSString *userId = responseObject[@"id"];
                                                  [KeyChain setUserId:userId];
                                                  UserBaseInfo *info = [UserBaseInfo share];
                                                  [info modelObjectWithDictionary:responseObject];
                                                  
                                              } failure:^(NSNumber *errorCode,
                                                          NSString *errorMsg,
                                                          NSDictionary *responseObject) {
                                                  
                                              }];
}

- (void)httpRequestSaveUserInfo:(NSString *)userName
                        address:(NSString*)address
                        village:(NSString *)village
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestSaveUserInfo:[KeyChain getMobileNo]
                                      userName:userName
                                       address:address
                                        areaId:self.areaId
                                       village:village
                                           uid:[KeyChain getUserId]
                                       success:^(NSDictionary *responseObject) {
                                           
                                           [self httpRequestQueryUserInfo];
                                           [KKProgressHUD hideMBProgressForView:self.view];
                                           [[CMRouter sharedInstance]showViewController:@"AddStoreViewController" param:nil];
                                           [[CMRouter sharedInstance]removeControllersWithRange:NSMakeRange(2, 1)];

                                           
                                           
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

    }];
}

- (void)httpRequestVillageListWithareaId:(NSNumber*)areaId
                                 success:(SuccessResponse)success
{
    [[APIService share]httpRequestVillageListWithareaId:areaId
                                                success:^(NSDictionary *responseObject) {
                                                    
                                                    [_cacheVillageMessage setObject:responseObject forKey:areaId];
                                                    if (success) {
                                                        success(responseObject);
                                                    }
                                                } failure:^(NSNumber *errorCode,
                                                            NSString *errorMsg,
                                                            NSDictionary *responseObject) {
                                                    [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
                                                }];
}

#pragma mark - on Button action

- (void)onSaveButtonAction
{
    
    NSDictionary *param = [StoreModel getSaveStoreParam:self.tableViewModel];
    
    NSString *storeName = [param objectForKey:@"storeName"];
    
    if ([param objectForKey:@"storeName"] == nil &&[[param objectForKey:@"storeName"] length]<1)
    {
        [[KKToast makeToast:@"请输入姓名"] show];
        return;
    }
    
    if ([[param objectForKey:@"storeName"] length]>16) {
        
        [[KKToast makeToast:@"最多输入16个字"] show];
        return;
    }
    
    if ([storeName firstLetterLegal])
    {
        [[KKToast makeToast:@"首字不能为特殊符号"] show];
        return;
    }

    
    [self httpRequestSaveUserInfo:storeName
                          address:[param objectForKey:@"address"]
                          village:[param objectForKey:@"village"]];
}

- (void)onPickerDataButton:(UIButton*)button
{
    if (self.pickerDataSource.count == 3) {
        
        if (button.tag == 1)
        {
            AreaDataModel *model0  = [self.pickerDataSource[0] objectAtIndex:[self.pickerView selectedRowInComponent:0]];
            AreaDataModel *model1  = [self.pickerDataSource[1] objectAtIndex:[self.pickerView selectedRowInComponent:1]];
            AreaDataModel *model2  = [self.pickerDataSource[2] objectAtIndex:[self.pickerView selectedRowInComponent:2]];
            self.areaId = @(model2.uid);
            [self httpRequestVillageListWithareaId:@(model2.uid) success:nil];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
            AddStoreTableViewCellModel *data = (AddStoreTableViewCellModel*)cellModel.data;
            data.content = [NSString stringWithFormat:@"%@%@%@",model0.name,model1.name,model2.name];
            [self.tableView reloadData];
            
        }
        
        
    }else
    {
        if (button.tag == 1)
        {
            AreaDataModel *model0  = [self.pickerDataSource[0] objectAtIndex:[self.pickerView selectedRowInComponent:0]];
            NSLog(@"%ld",(long)model0.uid);
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
            AddStoreTableViewCellModel *data = (AddStoreTableViewCellModel*)cellModel.data;
            data.content = model0.name;
            self.villageId = @(model0.uid);
            [self.tableView reloadData];
            
        }
    }
    
    [_mc dismiss];
}

- (void)showVillageChoose
{
    KKModelController *p = [KKModelController presentationControllerWithContentView:self.pickerBgView];
    _mc = p;
    //        self.pickerDataSource = [AreaDataModel getDefaultDisplayData:self.areaList areaId:self.areaId].mutableCopy;
    NSArray *villageList = [_cacheVillageMessage objectForKey:self.areaId];
    villageList = [AreaDataModel modelObjectListWithArray:villageList];
    self.pickerDataSource = @[villageList].mutableCopy;
    [p showInSuperView:self.navigationController.view];
    [self.pickerView reloadAllComponents];
}

#pragma mark - VillageChooseViewDelegate

- (void)villageChooseViewDidChooseVillage:(NSString *)village
{
    [_pc dismiss];
    self.village = village;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    AddStoreTableViewCellModel *data = (AddStoreTableViewCellModel*)cellModel.data;
    data.content = village;
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    if ([cellModel.cellType isEqualToString:@"区域"])
    {
        [tableView endEditing:YES];
        //        KKModelController *p = [KKModelController presentationControllerWithContentView:self.pickerBgView];
        //        _mc = p;
        //        self.pickerDataSource = [AreaDataModel getDefaultDisplayData:self.areaList areaId:self.areaId].mutableCopy;
        //        [p showInSuperView:self.navigationController.view];
        //        [self.pickerView reloadAllComponents];
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.areaId forKey:@"areaId"];
        [param setObject:@"EditInfoViewController" forKey:@"backClassName"];
        [[CMRouter sharedInstance]showViewController:@"AreaChooseViewController" param:param];
        
    }else if ([cellModel.cellType isEqualToString:@"街道/村"])
    {
        [tableView endEditing:YES];
        
        if (self.areaId == nil) {
            
            KKAlertAction *action = [KKAlertAction alertActionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(KKAlertAction *action) {
                
            }];
            [KKAlertView showAlertActionViewWithTitle:@"请选择所在地区" actions:@[action]];
            
            return;
        }
        
        
        NSArray *villageList = [_cacheVillageMessage objectForKey:self.areaId];
        if (!villageList)
        {
            [KKProgressHUD showMBProgressAddTo:self.view];
            [self httpRequestVillageListWithareaId:self.areaId
                                           success:^(NSDictionary *responseObject) {
                                               
                                               [KKProgressHUD hideMBProgressForView:self.view];
                                               KKPresentationController *pc = [KKPresentationController presentationControllerWithContentView:self.villageChooseView];
                                               _pc = pc;
                                               [self.villageChooseView reloadData:(NSArray*)responseObject];
                                               [pc showInSuperView:self.navigationController.view animation:YES];
                                               
                                           }];
        }else
        {
            KKPresentationController *pc = [KKPresentationController presentationControllerWithContentView:self.villageChooseView];
            _pc = pc;
            [self.villageChooseView reloadData:villageList];
            [pc showInSuperView:self.navigationController.view animation:YES];
        }
    }
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerDataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerDataSource[component] count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    AreaDataModel *model = self.pickerDataSource[component][row];
    return model.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerDataSource.count==3)
    {
        AreaDataModel *model = self.pickerDataSource[component][row];
        
        if (component == 0)
        {
            NSArray *result = [AreaDataModel queryAreaList:[HNDataBase share].areaList byPid:model.uid];
            [self.pickerDataSource replaceObjectAtIndex:1 withObject:result];
            [pickerView reloadComponent:1];
            
            AreaDataModel *m1 = result.firstObject;
            if (m1) {
                NSArray *result1 = [AreaDataModel queryAreaList:[HNDataBase share].areaList byPid:m1.uid];
                [self.pickerDataSource replaceObjectAtIndex:2 withObject:result1];
            }
            [pickerView reloadComponent:2];
            
        }
        
        if (component == 1)
        {
            NSArray *result = [AreaDataModel queryAreaList:[HNDataBase share].areaList byPid:model.uid];
            [self.pickerDataSource replaceObjectAtIndex:2 withObject:result];
            [pickerView reloadComponent:2];
            
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
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.delegate = self;
        _tableView.tableViewModel = self.tableViewModel;
        _tableView.tableFooterView = self.tableFooterView;
    }
    
    return _tableView;
}


-(KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel)
    {
        _tableViewModel = [KKTableViewModel new];
        NSArray *titles = @[@"姓名",@"区域",@"街道/村",@"详细地址"];
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
                data.contentKey = @"storeName";
            }
            
            if ([data.title isEqualToString:@"街道/村"]) {
                data.content = self.village;
                data.contentKey = @"village";
            }
            
            if ([data.title isEqualToString:@"详细地址"]) {
                data.contentKey = @"address";
            }
            
            data.edit = YES;
            if (i==2||i==1) {
                data.edit = NO;
                data.choose = YES;
            }
            cellModel.data = data;
            [section addCellModel:cellModel];
        }
        
    }
    return _tableViewModel;
}

- (UIView *)tableFooterView
{
    if (!_tableFooterView) {
        
        _tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        
        UIButton *saveButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveButton addTarget:self action:@selector(onSaveButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [saveButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [saveButton setTitle:@"完成" forState:UIControlStateNormal];
        [saveButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        saveButton.titleLabel.font = APPFONT(18);
        [saveButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
        
        [_tableFooterView addSubview:saveButton];
        [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(50);
            make.centerX.equalTo(_tableFooterView.mas_centerX);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(57);
            
        }];
        
    }
    return _tableFooterView;
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


- (VillageChooseView *)villageChooseView
{
    if (!_villageChooseView)
    {
        _villageChooseView = [[VillageChooseView alloc]initWithFrame:CGRectZero];
        _villageChooseView.delegate = self;
    }
    return _villageChooseView;
}



#pragma mark - callBack

- (void)setCallBack:(NSDictionary *)callBack
{
    if (callBack[@"id"])
    {
        self.village = @"";
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
        KKCellModel *cellModel1 = [self.tableViewModel cellModelAtIndexPath:indexPath1];
        AddStoreTableViewCellModel *data1 = (AddStoreTableViewCellModel*)cellModel1.data;
        data1.content =  self.village;
        
        
        self.areaId = callBack[@"id"];
        NSString *area = [AreaDataModel queryAreaName:self.areaList byArea:self.areaId.longValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
        
        AddStoreTableViewCellModel *data = (AddStoreTableViewCellModel*)cellModel.data;
        data.content = [NSString stringWithFormat:@"%@%@",area,[callBack objectForKey:@"name"]];
        
        [self.tableView reloadData];
        [self httpRequestVillageListWithareaId:self.areaId success:^(NSDictionary *responseObject) {
            
            if ([responseObject count] == 0)
            {
                self.areaId = @(self.areaId.longLongValue/100);
                data.content = area;
                self.village = [callBack objectForKey:@"name"];
                data1.content =  self.village;
                [self.tableView reloadData];
            }
            
        }];
    }
}



@end
