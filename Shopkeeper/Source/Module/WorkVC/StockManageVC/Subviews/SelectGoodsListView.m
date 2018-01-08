//
//  SelectGoodsListView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/21.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SelectGoodsListView.h"
#import "StockGoodsListTableViewCell.h"
#import "UITableView+DequeueReusableCell.h"
#import "SelectGoodsListTableViewCell.h"


@interface SelectGoodsListView ()<UITableViewDelegate,UITableViewDataSource,SelectGoodsListTableViewCellDelegate>

@property(nonatomic,strong)KKTableView *tableView;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;

@end

@implementation SelectGoodsListView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(KKTableViewModel*)tableViewModel
{
    self.tableViewModel = tableViewModel;
    self.tableView.tableViewModel = tableViewModel;
    KKSectionModel *sectionModel = tableViewModel.sectionDataList.firstObject;
    CGFloat height = 0;
    if (sectionModel)
    {
        height = sectionModel.cellDataList.count*115;
        if (height>400)
        {
            height = 400;
        }
    }
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(height);
    }];
}


- (void)showInCenterWithSuperView:(UIView *)aView
{
    [aView addSubview:self];
    self.alpha = 0;
    self.tableView.transform = CGAffineTransformIdentity;
    self.tableView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 1;
                         self.tableView.transform = CGAffineTransformMakeTranslation(0, 0);
                         
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
                         self.tableView.transform = CGAffineTransformMakeTranslation(0,SCREEN_HEIGHT);
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         completionBlock();
                     }];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    KKSectionModel *sectionModel = self.tableViewModel.sectionDataList[section];
    return sectionModel.cellDataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithClass:cellModel.cellClass];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    if ([cell respondsToSelector:@selector(reloadData:)]) {
        [cell performSelector:@selector(reloadData:) withObject:cellModel.data];
    }
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self];
    }
#pragma clang diagnostic pop
    
    return cell;
}

#pragma mark - UITableViewDelegate


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES; //YES here makes a red delete button appear when I swipe
}


- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        KKCellModel *cellModel = [self.tableViewModel cellModelAtIndexPath:indexPath];
        StockGoodsListTableViewCellModel *data = cellModel.data;
        if (data)
        {
            data.count=@"0";
        }
        [self.tableViewModel removeCellModelWithIndexPaths:@[indexPath]];
        [self reloadData:self.tableViewModel];
        
        if ([self.delegate respondsToSelector:@selector(selectGoodsListViewDidDeleteCellWithIndexPath:)])
        {
            [self.delegate selectGoodsListViewDidDeleteCellWithIndexPath:indexPath];
        }
        
    }];
    action.backgroundColor = ColorWithHex(@"#F29700");
    return @[action];
}



#pragma mark - SelectGoodsListTableViewCellDelegate

-(void)selectGoodsListTableViewCellDidSelectModifyButton:(UITableViewCell *)aCell
{
    if ([self.delegate respondsToSelector:@selector(selectGoodsListViewDidModifyCellWithIndexPath:)]) {
        [self.delegate selectGoodsListViewDidModifyCellWithIndexPath:[self.tableView indexPathForCell:aCell]];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.backgroundColor = [ColorWithHex(@"1f293e") colorWithAlphaComponent:0.6];
    [self addSubview:self.tableView];
}

- (KKTableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [KKTableView tableViewWithStyle:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];

    }
    return _tableView;
}

@end

@implementation SelectGoodsListViewModel

+ (KKTableViewModel *)tableViewModel:(NSArray<StockGoodsListTableViewCellModel*>*)list
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    
    for (StockGoodsListTableViewCellModel *data in list) {
        
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 115;
        cellModel.cellClass = NSClassFromString(@"SelectGoodsListTableViewCell");
        cellModel.data = data;
        [sectionModel addCellModel:cellModel];
    }
    return  tableViewModel;
}

@end
