//
//  RecipePackageListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageListViewController.h"

#import "RecipePackageListModel.h"
#import "RecipePackageListHeaderView.h"


@interface RecipePackageListViewController ()
<RecipePackageListHeaderViewDelegate,UITableViewDelegate>

@property(nonatomic,strong)KKTableView *tableView;

@end

@implementation RecipePackageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequestQueryRecipePackageList];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);

    }];
    
}

#pragma mark - RecipePackageListHeaderViewDelegate

- (void)recipePackageListHeaderViewDidSelectWithCropId:(NSNumber *)cropId cropName:(NSString *)cropName
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:cropId forKey:@"cropId"];
    [param setObject:cropName forKey:@"cropName"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"ReicpePackageAddPrescriptionViewController" param:param];
}

#pragma mark - request

- (void)httpRequestQueryRecipePackageList
{
    [[APIService share]httpRequestQueryRecipePackageListWithStoreId:self.storeId
                                                             isFull:YES
                                                            success:^(NSDictionary *responseObject)
    {
        self.tableView.tableViewModel = [RecipePackageListModel tableViewModelWithRecipePackageList:(NSArray*)responseObject storeId:self.storeId];

    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD hideMBProgressForView:self.view];
        __weak typeof(self) weakSelf = self;
        [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                               tapBlock:^{
                                                                                   
                                                                                   [weakSelf httpRequestQueryRecipePackageList];
                                                                                   
                                                                               }] ];
        
    }];
}

#pragma mark - on button action

- (void)onRightButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [[CMRouter sharedInstance]showViewController:@"ReicpePackageAddCropViewController" param:param];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"处方套餐";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新建处方" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
    [self.view addSubview:self.tableView];
}

- (KKTableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
    }
    return _tableView;
}





@end

