//
//  AddSupplierViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddSupplierViewController.h"
#import "VillageChooseView.h"
#import "AddSupplierModel.h"
#import "KKModelController.h"
#import "KKPresentationController.h"
#import "ChooseTableViewCell.h"
#import "InputTableViewCell.h"

#import "AreaDataModel.h"
#import "HNDataBase.h"


@interface AddSupplierViewController ()<UITableViewDelegate,VillageChooseViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)UIView *tableFooterView;

@property(nonatomic,strong)NSMutableDictionary *cacheVillageMessage;
@property(nonatomic,strong)VillageChooseView *villageChooseView;
@property(nonatomic,strong)KKModelController *mc;
@property(nonatomic,strong)KKPresentationController *pc;

@property(nonatomic,strong)NSNumber *areaId;
@property(nonatomic,copy)NSString *village;//村、街道 名称
@property(nonatomic,strong)NSArray *areaList;
@property(nonatomic,strong)NSIndexPath *selectIndexPath;
@property(nonatomic,strong)UIButton *saveButton;

@end

@implementation AddSupplierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cacheVillageMessage = @{}.mutableCopy;
    self.areaList =  [[HNDataBase share] areaList];
    [self initSubviews];
}

#pragma mark - request

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


- (void)httpRequestAddSupplier:(NSDictionary*)param
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    
    [[APIService share]httpRequestAddSupplierWithStoreId:self.storeId
                                                   param:param
                                                 success:^(NSDictionary *responseObject) {
                                                     [KKProgressHUD hideMBProgressForView:self.view];
                                                     NSMutableDictionary *md = responseObject.mutableCopy;
                                                     [md setObject:@"addSupplier" forKey:@"action"];
                                                     [[CMRouter sharedInstance]backToViewController:@"AddStockViewController" param:@{@"callBack":md}];
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

    }];
}


#pragma mark - onSaveButtonAction

- (void)onSaveButtonAction
{
    NSMutableDictionary *param = [AddSupplierModel getAddSupplierParam:self.tableViewModel].mutableCopy;
    NSString *name = param[@"name"];
    
    if (name.length<1) {
        
        [[KKToast makeToast:@"供应商名字不能为空"]show];
        return;
    }
    if (name.length>16)
    {
        [[KKToast makeToast:@"供应商名字最多16个字"]show];
        return;
    }
    
    if ([name firstLetterLegal])
    {
        [[KKToast makeToast:@"供应商名字首字不能为特殊符号"]show];
        return;
    }
    
    
    NSString *contactName = param[@"contactName"];
    
    if (contactName.length<1) {
        
        [[KKToast makeToast:@"联系人姓名不能为空"]show];
        return;
    }
    
    if (contactName.length>16)
    {
        [[KKToast makeToast:@"联系人姓名最多16个字"]show];
        return;
    }
    
    if ([contactName firstLetterLegal])
    {
        [[KKToast makeToast:@"联系人姓名首字不能为特殊符号"]show];
        return;
    }
    
    NSString *contactPhone = param[@"contactPhone"];
    
    if (contactPhone.length<1) {
        
        [[KKToast makeToast:@"手机号不能为空"]show];
        return;
    }
    
    if ([contactPhone validateMobile] == NO)
    {
        [[KKToast makeToast:@"手机号格式不正确"]show];
        return;
    }
    
    if (self.areaId == nil)
    {
        [[KKToast makeToast:@"请选择所在地区"]show];
        return;
    }
    
    if (self.village == nil || self.village.length<1)
    {
        [[KKToast makeToast:@"请选择街道/村"]show];
        return;
    }
    
    NSString *address = param[@"address"];
    
    if ([address firstLetterLegal])
    {
        [[KKToast makeToast:@"详细地址首字不能为特殊符号"]show];
        return;
    }
    
    if (address.length>32)
    {
        [[KKToast makeToast:@"详细地址最多32个字"]show];
        return;
    }
    
    
    NSString *remark = param[@"remark"];
    if ([remark firstLetterLegal])
    {
        [[KKToast makeToast:@"备注首字不能为特殊符号"]show];
        return;
    }
    
    if (remark.length>50)
    {
        [[KKToast makeToast:@"备注最多50个字"]show];
        return;
    }
    
    [param setObject:self.areaId forKey:@"areaId"];
    
    [self httpRequestAddSupplier:param];
}

#pragma mark - VillageChooseViewDelegate

- (void)villageChooseViewDidChooseVillage:(NSString *)village
{
    [_pc dismiss];
    self.village = village;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    ChooseTableViewCellModel *data = (ChooseTableViewCellModel*)cellModel.data;
    data.content = village;
    data.desc = nil;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndexPath = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    if ([cellModel.cellType isEqualToString:@"areaId"])
    {
        [tableView endEditing:YES];
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:self.areaId forKey:@"areaId"];
        [param setObject:@"AddSupplierViewController" forKey:@"backClassName"];
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
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"新增供应商";

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

- (KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel = [AddSupplierModel tableViewModel];
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
        _saveButton = saveButton;
    }
    return _tableFooterView;
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
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:4 inSection:0];
        KKCellModel *cellModel1 = [self.tableViewModel cellModelAtIndexPath:indexPath1];
        ChooseTableViewCellModel *data1 = (ChooseTableViewCellModel*)cellModel1.data;
        data1.content =  self.village;
        
        self.areaId = callBack[@"id"];
        
        NSString *area = [AreaDataModel queryAreaName:self.areaList byArea:self.areaId.longValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
        
        ChooseTableViewCellModel *data = (ChooseTableViewCellModel*)cellModel.data;
        if ([callBack[@"type"] integerValue]==5)
        {
            data.content = area;
            self.village = [callBack objectForKey:@"name"];
            
        }else
        {
            data.content = [NSString stringWithFormat:@"%@%@",area,[callBack objectForKey:@"name"]];
            data.desc = nil;
            
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
                data1.desc = nil;
                [self.tableView reloadData];
            }
        }];
    }
}


@end
