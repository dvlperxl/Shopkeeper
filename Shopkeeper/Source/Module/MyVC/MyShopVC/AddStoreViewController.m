//
//  AddStoreViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddStoreViewController.h"
#import "AddStoreTableViewCell.h"
#import "AreaDataModel.h"
#import "KKModelController.h"
#import "HNDataBase.h"
#import "StoreModel.h"
#import "AddStoreQrCodeCell.h"
#import "VillageChooseView.h"
#import "KKPresentationController.h"
#import "MyQRCodeView.h"
#import "UserBaseInfo.h"
#import "AddStoreModel.h"
#import "MemberImportContactsToastView.h"

CGFloat const ToastViewH = 40.0f;

@interface AddStoreViewController ()

<UITableViewDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource,
VillageChooseViewDelegate,
MemberImportContactsToastViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)UIView *tableFooterView;
@property(nonatomic,strong)NSMutableArray *pickerDataSource;

@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)KKModelController *mc;
@property(nonatomic,strong)NSMutableDictionary *cacheVillageMessage;
@property(nonatomic,strong)NSArray *areaList;

@property(nonatomic,strong)VillageChooseView *villageChooseView;
@property(nonatomic,strong)KKPresentationController *pc;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)AddStoreModel *addStoreModel;
@property(nonatomic,strong)MemberImportContactsToastView *toastView;

@end

@implementation AddStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UserBaseInfo *userInfo = [UserBaseInfo share];
    self.userName = userInfo.userName;
    _cacheVillageMessage = @{}.mutableCopy;
    
    self.areaList =  [[HNDataBase share] areaList];
    self.navigationItem.title = self.storeId?@"门店资料":@"添加门店";
    [self initSubviews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  http request

- (void)httpRequestSaveStoreWithAddress:(NSString*)address
                                village:(NSString*)village
                              storeName:(NSString*)storeName
                               userName:(NSString*)userName
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestSaveStoreWithAddress:address
                                               village:village
                                             storeName:storeName
                                                areaId:self.areaId
                                                userId:[KeyChain getUserId]
                                               storeId:self.storeId
                                              userName:userName
                                         isApplyDevice:NO
                                               success:^(NSDictionary *responseObject) {
                                                   if (userName) {
                                                       UserBaseInfo *userInfo = [UserBaseInfo share];
                                                       userInfo.userName = userName;
                                                   }
                                                   [KKProgressHUD hideMBProgressForView:self.view];
                                                   [[CMRouter sharedInstance]popViewController];
                                                   
        
    } failure:^(NSNumber *errorCode,
                NSString *errorMsg,
                NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        
    }];
}

- (void)httpRequestVillageListWithareaId:(NSNumber*)areaId
                                 success:(SuccessResponse)success
{
    [[APIService share]httpRequestVillageListWithareaId:areaId
                                                success:^(NSDictionary *responseObject) {
                                                    
                                                    if ([responseObject count]==0) {
                                                        
                                                    }else
                                                    {
                                                        [_cacheVillageMessage setObject:responseObject forKey:areaId];
                                                    }
                                                    
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
    
    NSString *userName;
    if (self.addStoreModel.eidtUserName)
    {
        userName = param[@"userName"];
        if (userName == nil || userName.length<1)
        {
            [[KKToast makeToast:@"请输入店主姓名"] show];
            return;
        }
        
        if (userName.length>16)
        {
            [[KKToast makeToast:@"店主姓名最多16个字"] show];
            return;
        }
        
        if ([userName firstLetterLegal])
        {
            [[KKToast makeToast:@"店主姓名首字不能为特殊符号"] show];
            return;
        }
    }
    
    NSString *storeName = [param objectForKey:@"storeName"];

    if ([param objectForKey:@"storeName"] == nil || [[param objectForKey:@"storeName"] length]<1)
    {
        [[KKToast makeToast:@"请输入门店名称"] show];
        return;
    }
    
    if ([[param objectForKey:@"storeName"] length]>32) {
        
        [[KKToast makeToast:@"门店名称最多输入32个字"] show];
        return;
    }
    
    if ([storeName firstLetterLegal])
    {
        [[KKToast makeToast:@"门店名称首字不能为特殊符号"] show];
        return;
    }
    
    if (self.areaId==nil) {
        [[KKToast makeToast:@"请选择所在地区"] show];
        return;
    }
    if (self.village==nil||self.village.length<1) {
        [[KKToast makeToast:@"请选择街道/村"] show];
        return;
    }
    
    NSString *address = [param objectForKey:@"address"];

    if (address == nil || address.length < 1)
    {
        [[KKToast makeToast:@"请输入详细地址"] show];
        return;
    }
    
    if (address.length>32) {
        
        [[KKToast makeToast:@"详细地址最多输入32个字"] show];
        return;
    }
    
    if ([address firstLetterLegal])
    {
        [[KKToast makeToast:@"详细地址首字不能为特殊符号"] show];
        return;
    }
    
    
    [self httpRequestSaveStoreWithAddress:[param objectForKey:@"address"]
                                  village:[param objectForKey:@"village"]
                                storeName:[param objectForKey:@"storeName"]
                                 userName:userName
     ];
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
            KKCellModel *cellModel = [[self.tableViewModel findCellModelWithCellType:@"areaId"] firstObject];
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
            KKCellModel *cellModel = [[self.tableViewModel findCellModelWithCellType:@"village"] firstObject];
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
    KKCellModel *cellModel = [[self.tableViewModel findCellModelWithCellType:@"village"] firstObject];
    
    AddStoreTableViewCellModel *data = (AddStoreTableViewCellModel*)cellModel.data;
    data.content = village;
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    if ([cellModel.cellType isEqualToString:@"areaId"])
    {
        [tableView endEditing:YES];
//        KKModelController *p = [KKModelController presentationControllerWithContentView:self.pickerBgView];
//        _mc = p;
//        self.pickerDataSource = [AreaDataModel getDefaultDisplayData:self.areaList areaId:self.areaId].mutableCopy;
//        [p showInSuperView:self.navigationController.view];
//        [self.pickerView reloadAllComponents];
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.areaId forKey:@"areaId"];
        [param setObject:@"AddStoreViewController" forKey:@"backClassName"];
        [[CMRouter sharedInstance]showViewController:@"AreaChooseViewController" param:param];

    }else if ([cellModel.cellType isEqualToString:@"village"])
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
    
    if (indexPath.section == 1)
    {
        MyQRCodeView  *view = [MyQRCodeView myQRCodeWithContent:STRINGWITHOBJECT(self.storeId)];
        [self.navigationController.view addSubview:view];
    }
    
}

#pragma mark - MemberImportContactsToastViewDelegate
/** 关闭toast*/
- (void)toastViewTapCloseBtn:(MemberImportContactsToastView *)toastView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.toastView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(self.navBarHeight - ToastViewH);
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(self.navBarHeight);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.toastView removeFromSuperview];
        self.toastView = nil;
    }];
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
            
            AreaDataModel *m1 = result[[self.pickerView selectedRowInComponent:1]];
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
    [self.view addSubview:self.toastView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.right.bottom.offset(0);
        make.top.offset(self.navBarHeight + ToastViewH);
    }];
    
    [self.toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(self.navBarHeight);
        make.height.mas_equalTo(ToastViewH);
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
        _tableViewModel = [self.addStoreModel tableViewModel];
    }
    return _tableViewModel;
}

- (AddStoreModel*)addStoreModel
{
    if (!_addStoreModel) {
        
        UserBaseInfo *userInfo = [UserBaseInfo share];
        self.userName = userInfo.userName;
        
        _addStoreModel = [AddStoreModel new];
        _addStoreModel.storeName = self.storeName;
        if (userInfo.userName==nil || userInfo.userName.length<1)
        {
            _addStoreModel.eidtUserName = YES;
            
        }else
        {
            _addStoreModel.eidtUserName = NO;
        }
        _addStoreModel.userName = self.userName;
        _addStoreModel.area = self.area;
        _addStoreModel.village = self.village;
        _addStoreModel.address = self.address;
        _addStoreModel.storeId = self.storeId;
        
    }
    return _addStoreModel;
}

- (UIView *)tableFooterView
{
    if (!_tableFooterView) {
        
        _tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        UIButton *saveButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveButton addTarget:self action:@selector(onSaveButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [saveButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
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

- (MemberImportContactsToastView *)toastView {
    if (!_toastView) {
        _toastView = [[MemberImportContactsToastView alloc]init];
        _toastView.delegate = self;
        _toastView.tipsStr = @"店主姓名填写后，不可更改";
    }
    return _toastView;
}


#pragma mark - callBack

- (void)setCallBack:(NSDictionary *)callBack
{
    if (callBack[@"id"])
    {
        self.village = @"";
        
        KKCellModel *cellModel1 = [[self.tableViewModel findCellModelWithCellType:@"village"] firstObject];
        AddStoreTableViewCellModel *data1 = (AddStoreTableViewCellModel*)cellModel1.data;
        data1.content =  self.village;
        
        self.areaId = callBack[@"id"];
        NSString *area = [AreaDataModel queryAreaName:self.areaList byArea:self.areaId.longValue];
        KKCellModel *cellModel = [[self.tableViewModel findCellModelWithCellType:@"areaId"] firstObject];
        
        AddStoreTableViewCellModel *data = (AddStoreTableViewCellModel*)cellModel.data;
        if ([callBack[@"type"] integerValue]==5)
        {
            data.content = area;
            self.village = [callBack objectForKey:@"name"];

        }else
        {
            data.content = [NSString stringWithFormat:@"%@%@",area,[callBack objectForKey:@"name"]];

        }
        data1.content =  self.village;
        
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
