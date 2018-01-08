//
//  ReicpePackageAddCropViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReicpePackageAddCropViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"

#import "RecipePackageChooseCropCollectionViewCell.h"
#import "ReicpePackageAddCropReusableHeaderView.h"
#import "ReicpePackageFooterReusableView.h"
#import "RecipePackageCropListView.h"
#import "RecipePackageCropListViewModel.h"


@interface ReicpePackageAddCropViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
CHTCollectionViewDelegateWaterfallLayout,
ReicpePackageFooterReusableViewDelegate,
RecipePackageCropListViewDelegate,
RecipePackageChooseCropCollectionViewCellDelegate>

@property(nonatomic,strong)CHTCollectionViewWaterfallLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSArray *croplist;

@end

@implementation ReicpePackageAddCropViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self httpRequestQueryAllCropList];
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequestQueryRecipePackageList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - http request

- (void)httpRequestQueryRecipePackageList
{
    [[APIService share]httpRequestQueryRecipePackageListWithStoreId:self.storeId
                                                             isFull:NO
                                                            success:^(NSDictionary *responseObject)
     {
         if ([responseObject isKindOfClass:[NSArray class]])
         {
             
             self.dataSource = responseObject.mutableCopy;
             if (self.dataSource.count>21)
             {
                 self.dataSource = [self.dataSource subarrayWithRange:NSMakeRange(0, 21)].mutableCopy;
             }
             [self.collectionView reloadData];
         }

         
     } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
         
         [KKProgressHUD hideMBProgressForView:self.view];
         __weak typeof(self) weakSelf = self;
         [self.view addSubview: [KKLoadFailureAndNotResultView loadFailViewWithErrorCode:errorCode.integerValue
                                                                                tapBlock:^{
                                                                                    
                                                                                    [weakSelf httpRequestQueryRecipePackageList];
                                                                                    
                                                                                }] ];
         
     }];
}



- (void)httpRequestQueryAllCropList
{
    [[APIService share]httpRequestQueryAllCropListSuccess:^(NSDictionary *responseObject) {
        
        self.croplist = (NSArray*)responseObject;
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
    }];
}

- (void)httpRequestAddCrop:(NSNumber*)baseCategoryId
                    corpId:(NSNumber*)corpId
          baseCategoryName:(NSString*)baseCategoryName
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestAddCropWithStoreId:self.storeId
                                      baseCategoryId:corpId
                                              corpId:nil
                                    baseCategoryName:baseCategoryName
                                             success:^(NSDictionary *responseObject) {
                                                 [KKProgressHUD hideMBProgressForView:self.view];
                                                 [self showReicpePackageAddPrescriptionViewController:responseObject];
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
        
    }];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"RecipePackageChooseCropCollectionViewCell";
    RecipePackageChooseCropCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell reloadData:_dataSource[indexPath.item][@"corpName"]];
    cell.delegate = self;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader])
    {
        ReicpePackageAddCropReusableHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"ReicpePackageAddCropReusableHeaderView" forIndexPath:indexPath];
        [view hideNoResult:self.dataSource.count!=0];
        return view;
    }else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter])
    {
       ReicpePackageFooterReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"ReicpePackageFooterReusableView" forIndexPath:indexPath];
        view.delegate = self;
        return view;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(0, 44);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    if (self.dataSource.count != 0) {
        
        return 40;
    }
    return 260;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section
{
    CGFloat height = SCREEN_HEIGHT-self.navBarHeight-40;
    
    if (self.dataSource.count>0)
    {
        NSInteger count = self.dataSource.count/3;
        if (self.dataSource.count%3>0) {
            count+=1;
        }
        height -=count*(44+10)+30;
        
    }else
    {
        height-=220;
    }
    if (height<150) {
        height=150;
    }
    NSLog(@"%@",@(height));
    return height;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//    TradeManageHomeCollectionViewCellModel *model = self.dataSource[indexPath.section][indexPath.item];
//    NSMutableDictionary *param = @{}.mutableCopy;
//    [param setObject:self.storeId forKey:@"storeId"];
//    [param setObject:model.status forKey:@"status"];
//    [param setObject:model.title forKey:@"navTitle"];
//    [[CMRouter sharedInstance]showViewController:model.actionName param:param.copy];
    
}

#pragma mark - show ReicpePackageAddPrescriptionViewController

- (void)showReicpePackageAddPrescriptionViewController:(NSDictionary*)crop
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:crop[@"id"] forKey:@"cropId"];
    [param setObject:crop[@"name"] forKey:@"cropName"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"ReicpePackageAddPrescriptionViewController" param:param];
}

#pragma mark - RecipePackageChooseCropCollectionViewCellDelegate

- (void)recipePackageChooseCropCollectionViewCellDidSelect:(UICollectionViewCell *)aCell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:aCell];
    NSDictionary *crop = self.dataSource[indexPath.item];
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:crop[@"corpId"] forKey:@"cropId"];
    [param setObject:crop[@"corpName"] forKey:@"cropName"];
    [[CMRouter sharedInstance]presentControllerWithControllerName:@"ReicpePackageAddPrescriptionViewController" param:param];
}

#pragma mark - ReicpePackageFooterReusableViewDelegate


- (void)reicpePackageFooterReusableViewDidSelectAddButton
{
    RecipePackageCropListView *list = [RecipePackageCropListView listViewWithCropList:self.croplist];
    list.delegate = self;
    [list showInSuperView:self.navigationController.view];
}

#pragma mark - RecipePackageCropListViewDelegate

- (void)recipePackageCropListViewDidSelectMenu:(RecipePackageCropModel *)model
{

//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"id == %@",model.cid];
//    NSArray *result = [self.dataSource.copy filteredArrayUsingPredicate:pred];
//    if (result.count>0)
//    {
//        NSDictionary *crop = result.firstObject;
//        [self showReicpePackageAddPrescriptionViewController:crop];
//
//    }else
//    {
//
//    }
    
    [self httpRequestAddCrop:model.pid corpId:model.cid baseCategoryName:model.name];
    
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.navigationItem.title = @"选择作物";
    [self.view addSubview:self.collectionView];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        
    }];
    [self setScrollViewInsets:@[self.collectionView]];
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        [_collectionView registerClass:[RecipePackageChooseCropCollectionViewCell class] forCellWithReuseIdentifier:@"RecipePackageChooseCropCollectionViewCell"];
        
        [_collectionView registerClass:[ReicpePackageAddCropReusableHeaderView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"ReicpePackageAddCropReusableHeaderView"];
        
        [_collectionView registerClass:[ReicpePackageFooterReusableView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"ReicpePackageFooterReusableView"];
        
    }
    return _collectionView;
    
}

- (CHTCollectionViewWaterfallLayout *)layout
{
    if (!_layout) {
        
        _layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        _layout.minimumColumnSpacing = 10;
        _layout.minimumInteritemSpacing = 10;
        _layout.columnCount = 3;
        _layout.sectionInset = UIEdgeInsetsMake(20,15,20, 15);
    
    }
    return _layout;
}

@end
