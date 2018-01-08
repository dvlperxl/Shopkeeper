//
//  StockGoodsListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockGoodsListViewController.h"
#import "StockGoodsListModel.h"
#import "GoodsCategoryTableViewCell.h"
#import "KKPresentationController.h"
#import "GoodsChooseAlertView.h"
#import "StockGoodsListTableViewCell.h"
#import "SelectGoodsListBottomView.h"
#import "KKTimer.h"


@interface StockGoodsListViewController ()
<UITableViewDelegate,
StockGoodsListTableViewCellDelegate,
GoodsChooseAlertViewDelegate,
SelectGoodsListBottomViewDelegate
>

@property(nonatomic,strong)KKTableView *categoryTableView;
@property(nonatomic,strong)KKTableView *goodsListTableView;
@property(nonatomic,strong)NSMutableDictionary *goodsListCache;
@property(nonatomic,strong)NSIndexPath *lastSelectIndexPath;
@property(nonatomic,strong)KKPresentationController *pc;
@property(nonatomic,strong)SelectGoodsListBottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *selectGoodsList;
@property(nonatomic,strong)StockGoodsListTableViewCellModel *modifyModel;
@property(nonatomic,strong)NSIndexPath *modifyIndexPath;

@end

@implementation StockGoodsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodsListCache = @{}.mutableCopy;

    [self initSubviews];
    [self httpRequestGoodsCategory];
    [self setScrollViewInsets:@[self.categoryTableView,self.goodsListTableView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(self.navBarHeight);
        make.left.offset(0);
       make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-60);
        make.width.mas_equalTo(100);
    }];
    
    [self.goodsListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(100);
       make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-60);
        make.top.offset(self.navBarHeight);
        make.right.offset(0);

    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.height.mas_equalTo(60);
       make.bottom.offset(0);
        
    }];
}
#pragma mark - http request

- (void)httpRequestGoodsCategory
{
    
    [[APIService share]httpRequestQueryGoodsCategoryWithStoreId:self.storeId
                                                       isOnline:self.vcType.integerValue
                                                        success:^(NSDictionary *responseObject) {
                                                            
                                                            NSArray *categories = responseObject[@"categories"];
                                                            KKTableViewModel *tableViewModel = [StockGoodsListModel categoryTableViewModel:categories];
                                                            if (categories.count>0)
                                                            {
                                                                self.categoryTableView.tableViewModel = tableViewModel;
                                                                self.lastSelectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                [self setCellSelectStatus:self.lastSelectIndexPath select:YES];
                                                                [self.categoryTableView reloadRowsAtIndexPaths:@[self.lastSelectIndexPath]];
                                                                [self httpRequestQueryGoodsList:[self getCategory:self.lastSelectIndexPath]];
                                                            }
                                         
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        
    }];
}

- (void)httpRequestQueryGoodsList:(NSString*)category
{
    KKTableViewModel *tableViewModel = [self.goodsListCache objectForKey:category];
    if (tableViewModel) {
        self.goodsListTableView.tableViewModel = tableViewModel;
        return;
    }
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestQueryStockGoodsListWithStoreId:self.storeId
                                                        category:category
                                                        isOnline:self.vcType.integerValue
                                                         success:^(NSDictionary *responseObject) {
                                                             
                                                             [self packageGoodsList:responseObject[@"goods"] category:category];
                                                             
                                                         } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                             NSArray *goods = responseObject[@"goods"];
                                                             
                                                             if (goods) {
                                                                 [self packageGoodsList:responseObject[@"goods"] category:category];
                                                             }else
                                                             {
                                                                 [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
                                                             }
                                                         }];
    
}

- (void)packageGoodsList:(NSArray*)goodsList category:(NSString*)category
{
    [KKProgressHUD hideMBProgressForView:self.view];
    KKTableViewModel *tableViewModel = [StockGoodsListModel goodsListTableViewModel:goodsList
                                                                    selectGoodsList:self.selectGoodsList
                                                                               type:[self.vcType integerValue]];
    self.goodsListTableView.tableViewModel = tableViewModel;
    [self.goodsListCache setObject:tableViewModel forKey:category];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.categoryTableView])
    {
        
        [self httpRequestQueryGoodsList:[self getCategory:indexPath]];
        if (![self.lastSelectIndexPath isEqual:indexPath])
        {
            [self setCellSelectStatus:indexPath select:YES];
            [self setCellSelectStatus:self.lastSelectIndexPath select:NO];
            [self.categoryTableView reloadRowsAtIndexPaths:@[indexPath,self.lastSelectIndexPath]];
            self.lastSelectIndexPath = indexPath;
        }
        
    }else
    {
        
    }
}

#pragma mark - GoodsChooseAlertViewDelegate

- (void)goodsChooseAlertViewDidSelectButton:(NSInteger)index price:(NSString *)price count:(NSString *)count total:(NSString *)total
{
    if (index == 1) {
        
        self.modifyModel.inputSale = price;
        self.modifyModel.count =count;
        self.modifyModel.total = total;
        NSString *output_sale_str = AMOUNTSTRING(price);
        CMLinkTextViewItem *item = [CMLinkTextViewItem new];
        item.textFont = APPFONT(15);
        item.textColor = ColorWithHex(@"f29700");
        item.textContent = @"¥";
        
        CMLinkTextViewItem *item1 = [CMLinkTextViewItem new];
        item1.textFont = APPFONT(22);
        item1.textColor = ColorWithHex(@"f29700");
        item1.textContent = output_sale_str;
        self.modifyModel.amount = [AttributedString attributeWithLinkTextViewItems:@[item,item1]];
        
        if (self.modifyIndexPath) {
            
            [self.goodsListTableView reloadRowsAtIndexPaths:@[self.modifyIndexPath]];
        }
        
        if (![self.selectGoodsList containsObject:self.modifyModel])
        {
            [self.selectGoodsList addObject:self.modifyModel];
        }
        [self.bottomView reloadData:self.selectGoodsList];
    }
    if (self.modifyIndexPath == nil)
    {
        [self.bottomView onTapAction];
    }
    [_pc dismiss];
}

#pragma mark - stockGoodsListTableViewCellDidSelectAddButton

- (void)stockGoodsListTableViewCell:(UITableViewCell *)aCell didSelectAddButtonWithModel:(StockGoodsListTableViewCellModel *)model
{
    [self showGoodsChooseAlertView:model modifyIndexPath:[self.goodsListTableView indexPathForCell:aCell]];
}

#pragma mark - SelectGoodsListBottomViewDelegate

- (void)selectGoodsListBottomViewDeleteGoodsIndex:(NSInteger)index
{
    StockGoodsListTableViewCellModel *model = self.selectGoodsList[index];
    model.count = nil;
    [self.goodsListTableView reloadData];
}

- (void)selectGoodsListBottomViewModifyGoodsIndex:(NSInteger)index
{
    StockGoodsListTableViewCellModel *model = self.selectGoodsList[index];
    [KKTimer startTimer:0.15 handle:^{
        [self showGoodsChooseAlertView:model modifyIndexPath:nil];
    }];
}

#pragma mark - show GoodsChooseAlertView

- (void)showGoodsChooseAlertView:(StockGoodsListTableViewCellModel*)model modifyIndexPath:(nullable NSIndexPath*)indexPath
{
    self.modifyModel = model;
    self.modifyIndexPath = indexPath;
    GoodsChooseAlertViewModel *alertModel = [[GoodsChooseAlertViewModel alloc]init];
    alertModel.title = model.title;
    alertModel.desc = model.desc;
    alertModel.count = model.count;
    NSArray *arr = [model.desc componentsSeparatedByString:@"/"];
    if (arr.count>1) {
        alertModel.unit = arr.lastObject;
    }
    NSString *price = model.inputSale;
    NSString *pricePlaceholder = @"进货单价";
    NSString *countPlaceholder = @"进货数量";
    BOOL priceEnable = YES;
    if ([self.vcType integerValue] == StockGoodsListViewControllerTypeReicpePackageAddPres) {   // 处方套餐新增商品
        price = [model.outputSale stringValue];
        pricePlaceholder = @"销售单价";
        countPlaceholder = @"数量";
        priceEnable = NO;
    }
    alertModel.priceEnable = priceEnable;
    alertModel.price = price;
    alertModel.pricePlaceholder = pricePlaceholder;
    alertModel.countPlaceholder = countPlaceholder;
    GoodsChooseAlertView *alertView = [GoodsChooseAlertView goodsChooseAlertView:alertModel];
    alertView.delegate = self;
    alertView.frame = CGRectMake(0, 0, 270, 316);
    KKPresentationController *p = [KKPresentationController presentationControllerWithContentView:alertView];
    [p showInCenterWithSuperView:self.navigationController.view];
    _pc = p;
}

#pragma mark -

- (void)onRightButtonAction
{
    NSLog(@"%@",self.selectGoodsList);
    if (self.selectGoodsList.count==0)
    {
        [[KKToast makeToast:@"请选择商品"] show];
        
    }else
    {
        NSMutableArray *goodsList = @[].mutableCopy;
        for (StockGoodsListTableViewCellModel *data in self.selectGoodsList)
        {
            [goodsList addObject:[data toDictionary]];
        }
        
        NSMutableDictionary *callBack = @{}.mutableCopy;
        [callBack setObject:@"addGoods" forKey:@"action"];
        [callBack setObject:goodsList.copy forKey:@"goodsList"];
        [[CMRouter sharedInstance]backToViewController:self.backClassName
                                                 param:@{@"callBack":callBack}];
    }
    
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"选择商品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
    
    [self.view addSubview:self.categoryTableView];
    [self.view addSubview:self.goodsListTableView];
    [self.view addSubview:self.bottomView];
}

- (KKTableView *)categoryTableView
{
    if (!_categoryTableView) {
        
        _categoryTableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _categoryTableView.backgroundColor = [UIColor clearColor];
        _categoryTableView.showsVerticalScrollIndicator = NO;
        _categoryTableView.delegate = self;
    }
    return _categoryTableView;
}

- (KKTableView *)goodsListTableView
{
    if (!_goodsListTableView) {
        
        _goodsListTableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _goodsListTableView.delegate = self;
    }
    return _goodsListTableView;
}

- (NSMutableArray*)selectGoodsList
{
    if (!_selectGoodsList) {
        
        _selectGoodsList = [StockGoodsListTableViewCellModel modelObjectListWithArray:self.goodsList].mutableCopy;
        // 处理数据
        for (StockGoodsListTableViewCellModel *model in _selectGoodsList) {
            [StockGoodsListModel handleModelAmountPropertyWithModel:model vcType:[self.vcType integerValue]];
        }
        [self.bottomView reloadData:_selectGoodsList];
    }
    return _selectGoodsList;
}

- (SelectGoodsListBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[SelectGoodsListBottomView alloc]init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (NSString*)getCategory:(NSIndexPath*)indexPath
{
    KKCellModel *model = [self.categoryTableView.tableViewModel cellModelAtIndexPath:indexPath];
    GoodsCategoryTableViewCellModel *data = model.data;
    return STRINGWITHOBJECT(data.gid);
}

- (void)setCellSelectStatus:(NSIndexPath*)indexPath select:(BOOL)select
{
    KKCellModel *model = [self.categoryTableView.tableViewModel cellModelAtIndexPath:indexPath];
    GoodsCategoryTableViewCellModel *data = model.data;
    data.select = select;
}

@end
