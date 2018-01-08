//
//  StockGoodsListTableViewCell.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockGoodsListTableViewCell.h"

@interface StockGoodsListTableViewCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *amountLab;
@property(nonatomic,strong)UIButton *addButton;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)StockGoodsListTableViewCellModel *model;

@end

@implementation StockGoodsListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)reloadData:(StockGoodsListTableViewCellModel*)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.descLab.text = model.desc;
    self.amountLab.attributedText = model.amount;   //icon_editgoods
    
    NSString *imgName = @"icon_addgoods";
    if (model.count>0) {
        imgName = @"icon_editgoods";
    }
    [_addButton setImage:Image(imgName) forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(42);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(120);
        make.top.offset(42);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.height.mas_equalTo(23);
        make.bottom.offset(-14);
        make.right.equalTo(self.addButton.mas_left).offset(-5);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.mas_equalTo(52);
        make.right.offset(-15);
        make.bottom.offset(-7);

    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.bottom.offset(0);
        make.height.mas_equalTo(1.0/SCREEN_SCALE);
    }];
}

#pragma mark - on button action

- (void)onAddButtonAction
{
    if ([self.delegate respondsToSelector:@selector(stockGoodsListTableViewCell:didSelectAddButtonWithModel:)]) {
        [self.delegate stockGoodsListTableViewCell:self didSelectAddButtonWithModel:self.model];
    }
}

#pragma mark - initSubviews

- (void)initSubviews
{
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.descLab];
    [self addSubview:self.amountLab];
    [self addSubview:self.addButton];
    [self addSubview:self.line];
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = APPFONT(17);
        _titleLab.textColor = ColorWithHex(@"#333333");
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (!_contentLab)
    {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = ColorWithHex(@"#999999");
        _contentLab.font = APPFONT(15);
    }
    return _contentLab;
}

- (UILabel *)descLab
{
    if (!_descLab) {
        
        _descLab = [[UILabel alloc]init];
        _descLab.textColor =  ColorWithHex(@"#999999");
        _descLab.font = APPFONT(15);
    }
    return _descLab;
}

- (UILabel *)amountLab
{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
    }
    
    return _amountLab;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:Image(@"icon_addgoods") forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(onAddButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addButton;
}

-(UIView *)line
{
    if (!_line)
    {
        _line = [[UIView alloc]init];
        _line.backgroundColor = ColorWithRGB(235, 235, 235, 1);
    }
    return _line;
}

@end

@implementation StockGoodsListTableViewCellModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"outputSale":@"retailAmount",@"inputSale":@"purchasePrice",@"count":@"purchaseNum"};
}

- (NSDictionary*)toDictionary
{
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:self.title forKey:@"title"];
    [md setObject:self.desc forKey:@"desc"];
    [md setObject:self.content forKey:@"content"];
    [md setObject:self.outputSale forKey:@"retailAmount"];
    [md setObject:self.inputSale forKey:@"purchasePrice"];
    [md setObject:self.count forKey:@"purchaseNum"];
    [md setObject:self.goodsId forKey:@"goodsId"];

    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:self.inputSale];
    NSDecimalNumber *count = [NSDecimalNumber decimalNumberWithString:self.count];
    NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                      decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                      scale:2
                                      raiseOnExactness:NO
                                      raiseOnOverflow:NO
                                      raiseOnUnderflow:NO
                                      raiseOnDivideByZero:YES];
    NSDecimalNumber *toatl = [price decimalNumberByMultiplyingBy:count withBehavior:roundUp];
    NSString *finalAmount = AMOUNTSTRING(toatl.description);
    [md setObject:finalAmount forKey:@"finalAmount"];
    
    return md.copy;
}

//-(NSAttributedString *)amount
//{
//    if (!_amount)
//    {
//        if (self.inputSale != nil|| [self.inputSale floatValue]>0)
//        {
//            NSString *input_sale_str = [NSString stringWithFormat:@"%.2f",self.inputSale.doubleValue];
//            CMLinkTextViewItem *item = [CMLinkTextViewItem new];
//            item.textFont = APPFONT(15);
//            item.textColor = ColorWithHex(@"f29700");
//            item.textContent = @"¥";
//            CMLinkTextViewItem *item1 = [CMLinkTextViewItem new];
//            item1.textFont = APPFONT(22);
//            item1.textColor = ColorWithHex(@"f29700");
//            item1.textContent = input_sale_str;
//            _amount = [AttributedString attributeWithLinkTextViewItems:@[item,item1]];
//        }else
//        {
//            _amount = [CMLinkTextViewItem attributeStringWithText:@"暂无进货价" textFont:APPFONT(22) textColor:ColorWithHex(@"#f29700")];
//        }
//
//    }
//
//    return _amount;
//}

@end
