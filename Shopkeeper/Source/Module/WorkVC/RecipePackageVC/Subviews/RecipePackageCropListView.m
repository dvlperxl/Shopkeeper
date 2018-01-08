//
//  RecipePackageCropListView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageCropListView.h"

#import "RecipePackageCropListViewModel.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "RecipePackageChooseCropCollectionViewCell.h"
#import "SectionIndexTitlesView.h"

@interface RecipePackageCropListView ()
<UITableViewDelegate,
UICollectionViewDataSource,
CHTCollectionViewDelegateWaterfallLayout,
RecipePackageChooseCropCollectionViewCellDelegate,
SectionIndexTitlesViewDelegate>

@property(nonatomic,strong)KKTableView *categoryTableView;
//@property(nonatomic,strong)KKTableView *cropListTableView;
@property(nonatomic,strong)NSArray *cropList;
@property(nonatomic,strong)NSArray *childCropList;
@property(nonatomic,strong)NSArray *sectionIndexList;
@property(nonatomic,strong)NSIndexPath *categorySelectIndexPath;

@property(nonatomic,strong)CHTCollectionViewWaterfallLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)SectionIndexTitlesView *sectionIndexTitlesView;
@property(nonatomic,strong)UIButton *tapButton;


@end

@implementation RecipePackageCropListView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initSubviews];
        [self.categoryTableView setContentInsetAdjustmentBehaviorNever];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.offset(0);
        make.height.mas_equalTo(400);
        make.width.mas_equalTo(100);
        
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(100);
        make.height.mas_equalTo(400);
        make.right.bottom.offset(0);
    }];
    [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.offset(0);
        make.bottom.equalTo(self.collectionView.mas_top).offset(0);
    }];
}

+ (instancetype)listViewWithCropList:(NSArray*)cropList
{
    RecipePackageCropListView *listView = [[RecipePackageCropListView alloc]init];
    listView.cropList = cropList;
    listView.categoryTableView.tableViewModel = [RecipePackageCropListViewModel categoryTableViewModel:cropList];
    listView.categorySelectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *childCategories = cropList[0][@"childCategories"];
    listView.childCropList = [RecipePackageCropModel modelObjectListWithArray:childCategories];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"groupStr" ascending:YES];
    listView.childCropList = [listView.childCropList sortedArrayUsingDescriptors:@[sort]];
    listView.sectionIndexList = [RecipePackageCropModel sectionGroups:listView.childCropList];
    [listView.sectionIndexTitlesView reloadData:listView.sectionIndexList];
    return listView;
}

- (void)showInSuperView:(UIView*)aView
{
    [aView addSubview:self];
    [self.collectionView reloadData];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    self.alpha = 0;
    self.categoryTableView.transform = CGAffineTransformIdentity;
    self.collectionView.transform = CGAffineTransformIdentity;

    self.categoryTableView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
    self.collectionView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);

    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 1;
                         self.categoryTableView.transform = CGAffineTransformMakeTranslation(0, 0);
                         self.collectionView.transform = CGAffineTransformMakeTranslation(0, 0);
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
}


- (void)dismiss:(void (^)(void))completionBlock
{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 0;
                         self.categoryTableView.transform = CGAffineTransformMakeTranslation(0,SCREEN_HEIGHT);
                         self.collectionView.transform = CGAffineTransformMakeTranslation(0,SCREEN_HEIGHT);

                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         if (completionBlock) {
                             completionBlock();
                         }
                     }];
}

- (void)onTapButtonAction
{
    [self dismiss:nil];
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.categoryTableView])
    {
        if (![indexPath isEqual:self.categorySelectIndexPath])
        {
            [RecipePackageCropListViewModel setCategoryTableView:self.categoryTableView.tableViewModel cellIndexPath:indexPath selected:YES];
            [RecipePackageCropListViewModel setCategoryTableView:self.categoryTableView.tableViewModel cellIndexPath:self.categorySelectIndexPath selected:NO];
            [self.categoryTableView reloadRowsAtIndexPaths:@[indexPath,self.categorySelectIndexPath]];
            self.categorySelectIndexPath = indexPath;
            
            NSArray *childCategories = self.cropList[indexPath.row][@"childCategories"];
            self.childCropList = [RecipePackageCropModel modelObjectListWithArray:childCategories];
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"groupStr" ascending:YES];
            self.childCropList = [self.childCropList sortedArrayUsingDescriptors:@[sort]];
            self.sectionIndexList = [RecipePackageCropModel sectionGroups:self.childCropList];
            [self.sectionIndexTitlesView reloadData:self.sectionIndexList];
//            _layout.headerHeight = 20;
            [self.collectionView reloadData];
            
        }
    }
}

#pragma mark -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childCropList.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"RecipePackageChooseCropCollectionViewCell";
    RecipePackageChooseCropCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    RecipePackageCropModel *model = self.childCropList[indexPath.item];
    [cell reloadData:model.name];
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(0, 44);
}

#pragma mark -

- (void)recipePackageChooseCropCollectionViewCellDidSelect:(UICollectionViewCell*)aCell
{
    if ([self.delegate respondsToSelector:@selector(recipePackageCropListViewDidSelectMenu:)]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:aCell];
        RecipePackageCropModel *model = self.childCropList[indexPath.item];
        [self.delegate recipePackageCropListViewDidSelectMenu:model];
    }
    [self dismiss:^{
        
    }];
}

-(void)sectionIndexTitlesViewDidSelectTitle:(NSString*)title withIndex:(NSInteger)index
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"groupStr == %@",title];
    NSArray *result = [self.childCropList filteredArrayUsingPredicate:pred];
    if (result.count>0)
    {
        RecipePackageCropModel *model = result.firstObject;
        NSInteger idx = [self.childCropList indexOfObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.backgroundColor = [ColorWithHex(@"1f293e") colorWithAlphaComponent:0.6];
    [self addSubview:self.categoryTableView];
    [self addSubview:self.collectionView];
    [self addSubview:self.sectionIndexTitlesView];
    [self addSubview:self.tapButton];
}

- (KKTableView *)categoryTableView
{
    if (!_categoryTableView) {
        
        _categoryTableView = [KKTableView tableViewWithStyle:UITableViewStylePlain];
        _categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _categoryTableView.showsVerticalScrollIndicator = NO;
        _categoryTableView.delegate = self;
        _categoryTableView.backgroundColor = ColorWithHex(@"#f5f5f5");
    }
    return _categoryTableView;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        [_collectionView registerClass:[RecipePackageChooseCropCollectionViewCell class] forCellWithReuseIdentifier:@"RecipePackageChooseCropCollectionViewCell"];
    }
    return _collectionView;
}

- (CHTCollectionViewWaterfallLayout *)layout
{
    if (!_layout) {
        
        _layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        _layout.minimumColumnSpacing = 10;
        _layout.minimumInteritemSpacing = 10;
        _layout.columnCount = 2;
        _layout.sectionInset = UIEdgeInsetsMake(20,20,20,28);
//        _layout.headerHeight = 20;
    }
    return _layout;
}

- (SectionIndexTitlesView *)sectionIndexTitlesView
{
    if (!_sectionIndexTitlesView) {
        
        _sectionIndexTitlesView  = [[SectionIndexTitlesView alloc]init];
        _sectionIndexTitlesView.delegate = self;
        _sectionIndexTitlesView.frame = CGRectMake(SCREEN_WIDTH-20, SCREEN_HEIGHT-400, 20, 400);
    }
    return _sectionIndexTitlesView;
}

-(UIButton *)tapButton
{
    if (!_tapButton) {
        _tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tapButton addTarget:self action:@selector(onTapButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapButton;
}

@end
