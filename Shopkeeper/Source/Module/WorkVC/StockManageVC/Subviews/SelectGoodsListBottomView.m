//
//  SelectGoodsListBottomView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/21.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SelectGoodsListBottomView.h"
#import "SelectGoodsListView.h"

@interface SelectGoodsListBottomView ()
<SelectGoodsListViewDelegate>

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@property(nonatomic,assign)BOOL unfold;
@property(nonatomic,strong)SelectGoodsListView *listView;
@property(nonatomic,strong)NSMutableArray *goodsList;

@end

@implementation SelectGoodsListBottomView

-(void)reloadData:(NSMutableArray*)goodsList
{
    _titleLab.text = [NSString stringWithFormat:@"共%@件商品",@(goodsList.count)];
    _goodsList = goodsList;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.unfold = NO;
        [self initSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.offset(10);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(70);
        make.top.offset(9);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(70);
        make.bottom.offset(-8);
        make.height.mas_equalTo(19);
    }];
}

- (void)onTapAction
{
    UIViewController *vc = (UIViewController*)self.delegate;
    self.unfold = !self.unfold;
    _iconImageView.image = self.unfold? Image(@"icon_arrowdown"):Image(@"icon_arrowup");
    if (self.unfold)
    {
        if (self.delegate) {
            
            KKTableViewModel *tbm = [SelectGoodsListViewModel tableViewModel:self.goodsList];
            [self.listView reloadData:tbm];
            [self.listView showInCenterWithSuperView:vc.navigationController.view];
            [vc.navigationController.view addSubview:self];
        }
        
    }else
    {
        [self.listView dismiss:^{
            [vc.view addSubview:self];
        }];
    }
}

#pragma mark - SelectGoodsListViewDelegate

- (void)selectGoodsListViewDidDeleteCellWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectGoodsListBottomViewDeleteGoodsIndex:)]) {
        
        [self.delegate selectGoodsListBottomViewDeleteGoodsIndex:indexPath.row];
    }
    
    [self.goodsList removeObjectAtIndex:indexPath.row];
    _titleLab.text = [NSString stringWithFormat:@"共%@件商品",@(self.goodsList.count)];
    
    if (self.goodsList.count==0)
    {
        [self onTapAction];
    }
}

- (void)selectGoodsListViewDidModifyCellWithIndexPath:(NSIndexPath*)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectGoodsListBottomViewModifyGoodsIndex:)])
    {
        [self.delegate selectGoodsListBottomViewModifyGoodsIndex:indexPath.row];
    }
    [self onTapAction];

}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.backgroundColor = ColorWithHex(@"#333333");
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addGestureRecognizer:self.tap];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]initWithImage:Image(@"icon_arrowup")];
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"共0件商品";
        _titleLab.textColor = ColorWithHex(@"#F29700");
        _titleLab.font = APPFONT(17);
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab)
    {
        _contentLab = [[UILabel alloc]init];
        _contentLab.text = @"点击查看所选商品清单";
        _contentLab.font = APPFONT(14);
        _contentLab.textColor = ColorWithHex(@"#ffffff");
    }
    return _contentLab;
}

- (UITapGestureRecognizer *)tap
{
    if (!_tap) {
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction)];
    }
    return _tap;
}

- (SelectGoodsListView *)listView
{
    if (!_listView) {
        
        _listView = [[SelectGoodsListView alloc]init];
        _listView.delegate = self;
        _listView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60);
    }
    return _listView;
}

@end
