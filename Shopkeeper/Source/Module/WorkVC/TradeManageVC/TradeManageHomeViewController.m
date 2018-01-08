//
//  TradeManageHomeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "TradeManageHomeViewController.h"
#import "TradeManageHomeCollectionViewCell.h"
#import "TradeManageModel.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "TradeManageCollectionReusableView.h"

@interface TradeManageHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)CHTCollectionViewWaterfallLayout *layout;

@end

@implementation TradeManageHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"销售管理";
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"TradeManageHomeCollectionViewCell";
    TradeManageHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell reloadData:_dataSource[indexPath.section][indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader])
    {
        TradeManageCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"TradeManageCollectionReusableView" forIndexPath:indexPath];
//        if (indexPath.section == 0)
//        {
//            [view reloadData:@"开单"];
//
//        }else
//        {
//        }
        [view reloadData:@"订单管理"];

        return view;
    }
    
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widht = (SCREEN_WIDTH-2) / 3 ;
    return CGSizeMake(widht, 110);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TradeManageHomeCollectionViewCellModel *model = self.dataSource[indexPath.section][indexPath.item];
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:model.status forKey:@"status"];
    [param setObject:model.title forKey:@"navTitle"];
    [[CMRouter sharedInstance]showViewController:model.actionName param:param.copy];
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);

    }];
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerNib:[UINib nibWithNibName:@"TradeManageHomeCollectionViewCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:@"TradeManageHomeCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"TradeManageCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"TradeManageCollectionReusableView"];
        
    }
    return _collectionView;
    
}

- (CHTCollectionViewWaterfallLayout *)layout
{
    if (!_layout) {
        
        _layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        _layout.minimumColumnSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.columnCount = 3;
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        
    }
    return _layout;
}

- (NSArray*)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [TradeManageModel dataSource];
    }
    return _dataSource;
}

@end
