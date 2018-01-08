//
//  AddGoodsViewController.m
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddGoodsViewController.h"
#import "AddGoodsModel.h"
#import "AddGoodsPickerCell.h"
#import "GoodsCategoryPickerView.h"
#import "GoodsDatePicker.h"
#import "AddGoodsImageCell.h"
#import "AddGoodsHeaderView.h"

@interface AddGoodsViewController ()<UITableViewDelegate,GoodsCategoryPickerViewDataSource,GoodsCategoryPickerViewDelegate,GoodsDatePickerDelegate,AddGoodsImageCellDelegate,AddGoodsHeaderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) AddGoodsModel *viewModel;
@property (nonatomic,strong) KKTableView *tableView;
@property (nonatomic,strong) GoodsCategoryPickerView *pickerView;
@property (nonatomic,strong) GoodsDatePicker *datePicker;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@end

@implementation AddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
    
}
- (void)setupUI {
    self.navigationItem.title = self.goodsDic ? @"编辑商品" : @"新增商品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(onDoneAction:)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}
- (void)loadData {
    __weak typeof(self)weakSelf = self;
    self.viewModel.registrationNum = ^() {
        [weakSelf toSearchRegistrationNumVC];
    };
    self.viewModel.showPicker = ^() {
        [weakSelf.pickerView showInController:weakSelf.navigationController];
    };
    self.viewModel.showDataPicker = ^(NSDate *miniDate, NSDate *maxDate) {
        weakSelf.datePicker.minimumDate = miniDate;
        weakSelf.datePicker.maximumDate = maxDate;
        [weakSelf.datePicker showInController:weakSelf.navigationController];
    };
    [self.viewModel getGoodsSpeciInfoSuccess:^{
        weakSelf.tableView.tableViewModel = [weakSelf.viewModel addGoodsTableViewModel];
    } failure:^(NSString *errorMsg) {
        
    }];
}
- (void)toSearchRegistrationNumVC {
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"SearchRegistrationGoodsViewController" param:nil];
}
- (void)saveGoodsPosOperationWithBarButton:(UIBarButtonItem *)barButton {
    barButton.enabled = NO;
    [KKProgressHUD showMBProgressAddTo:self.view];
    NSString *requestStr = [self.viewModel requestGoodsParameterStr];
    [[APIService share]httpRequestMergeGoodsPosWithGoods:requestStr success:^(NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        barButton.enabled = YES;
        NSString *categoryId = responseObject[@"goodsCategory"];
        if ([categoryId isKindOfClass:[NSNumber class]]) {
            categoryId = [(NSNumber *)categoryId stringValue];
        }
        NSMutableDictionary *actionDic = @{}.mutableCopy;
        [actionDic setObject:@"addGoods" forKey:@"action"];
        [actionDic setObject:categoryId forKey:@"categoryId"];
        [[CMRouter sharedInstance]backToViewController:@"CommodityListViewController" param:@{@"callBack":actionDic}];
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        [KKProgressHUD hideMBProgressForView:self.view];
        [[KKToast makeToast:errorMsg] show];
        barButton.enabled = YES;
    }];
}
#pragma mark - event
- (void)onDoneAction:(UIBarButtonItem *)barButton {
    barButton.enabled = NO;
    [self.view endEditing:YES];
    NSString *errorMsg = [self.viewModel checkRequestParametersErrorMsg];
    if (errorMsg) {
        [[KKToast makeToast:errorMsg] show];
        barButton.enabled = YES;
        return;
    }
    if ([self.viewModel checkInputPriceGtOutputPrice]) {  // 判断进货价是否大于售价
        barButton.enabled = YES;
        [KKAlertView showAlertActionViewWithTitle:@"进货单价大于销售单价，确定发布商品？" actions:@[[KKAlertAction alertActionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil],[KKAlertAction alertActionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(KKAlertAction *action) {
            [self saveGoodsPosOperationWithBarButton:barButton];
        }]]];
        return;
    }
    [self saveGoodsPosOperationWithBarButton:barButton];
}
#pragma mark - AddGoodsImageCellDelegate
- (void)addGoodsImageCellTapAddImage:(AddGoodsImageCell *)cell {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (@available(iOS 11.0, *)){
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}
- (void)addGoodsImageCell:(AddGoodsImageCell *)cell deleteImageWithIndex:(NSInteger)index {
    [self.viewModel deleteImageDataWithIndex:index];
    self.tableView.tableViewModel = [self.viewModel addGoodsTableViewModel];
}
#pragma mark - AddGoodsHeaderViewDelegate
- (void)tapHeader:(AddGoodsHeaderView *)header {
    [self.viewModel openOrCloseMoreInfo];
    self.tableView.tableViewModel = [self.viewModel addGoodsTableViewModel];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    UIGraphicsBeginImageContext(CGSizeMake(70 * 2, 70 * 2));
//    [image drawInRect:CGRectMake(0, 0, 70*2, 70*2)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    NSMutableArray *datas = @[].mutableCopy;
    [datas addObject:imageData];
    [[APIService share]httpRequestUpLoadImageRequestWithImagesData:datas success:^(NSArray *result) {
        NSString *url = result[0];
        if (url) {
            url = [BASE_IMAGE_URL stringByAppendingString:url];
            [self.viewModel addImageDataWithImageUrl:url];
            self.tableView.tableViewModel = [self.viewModel addGoodsTableViewModel];
        }
    } failure:^(id failResult) {
        
    } progress:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (@available(iOS 11.0, *)){
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (@available(iOS 11.0, *)){
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
#pragma mark - GoodsCategoryPickerViewDataSource,GoodsCategoryPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.viewModel pickerComponentsCount];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.viewModel pickerRowsInComponent:component];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    NSString *text = [self.viewModel pickerTitleForRow:row forComponent:component];
    
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 2;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setText:text];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    BOOL reload = [self.viewModel pickerReplaceObjectInRow:row inComponent:component];
    if (reload) {
        [pickerView reloadComponent:component+1];
    }
}
- (void)goodsPickerView:(GoodsCategoryPickerView *)view pickerView:(UIPickerView *)pickerView selectedRows:(NSArray *)rows {
    self.pickerView = nil;
    [self.viewModel pickerUpdateDataWithSelectedRows:rows];
    self.tableView.tableViewModel = [self.viewModel addGoodsTableViewModel];
}
- (void)goodsPickerViewDidDismiss:(GoodsCategoryPickerView *)view {
    self.pickerView = nil;
}
#pragma mark - GoodsDatePickerDelegate
- (void)datePickerView:(GoodsDatePicker *)view datePicker:(UIDatePicker *)datePicker selectedDate:(NSDate *)date {
    [self.viewModel updateDateDataWithDate:date];
    self.tableView.tableViewModel = [self.viewModel addGoodsTableViewModel];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithHexString:@"#F5F5F5"];
    ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 16, 0, 0)];
    }
}
#pragma mark - getter
- (void)setCallBack:(NSDictionary *)callBack {
    NSString *action = callBack[@"action"];
    if ([action isEqualToString:@"registrationGoods"]) {
        NSDictionary *parameters = callBack[@"parameters"];
        [self.viewModel updateDataWithRegistrationGoodsDic:parameters];
        self.tableView.tableViewModel = [self.viewModel addGoodsTableViewModel];
    }
}
- (void)setCategoryList:(NSArray *)categoryList {
    _categoryList = categoryList;
    self.viewModel.categoryList = categoryList;
}
- (void)setGoodsDic:(NSDictionary *)goodsDic {
    _goodsDic = goodsDic;
    [self.viewModel inputExistGoodsDic:goodsDic];
}
- (AddGoodsModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AddGoodsModel alloc]initWithStoreId:self.storeId];
    }
    return _viewModel;
}
- (KKTableView *)tableView {
    if (!_tableView) {
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"#EBEBEB"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins: UIEdgeInsetsZero];
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (GoodsCategoryPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[GoodsCategoryPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
- (GoodsDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[GoodsDatePicker alloc]init];
        _datePicker.delegate = self;
    }
    return _datePicker;
}
- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.navigationBar.barTintColor = [UIColor whiteColor];
        _imagePicker.navigationBar.tintColor = [UIColor colorWithHexString:@"#F29700"];
        _imagePicker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}
@end
