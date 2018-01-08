//
//  AddStockModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddStockModel.h"
#import "ChooseTableViewCell.h"
#import "GoodsCountTableViewCell.h"
#import "AttributedString.h"
#import "SettlementAmountTableViewCell.h"
#import "InputTableViewCell.h"
#import "OrderDetailMerchandiseCell.h"

@interface AddStockModel ()

//@property(nonatomic,readwrite)KKTableViewModel  *tableViewModel;
//totalAmountCellModel
@property(nonatomic,strong)ChooseTableViewCellModel  *applierData;
@property(nonatomic,strong)InputTableViewCellModel *remarkData;
@property(nonatomic,strong)KKCellModel *totalAmountCellModel;


@end

@implementation AddStockModel

- (instancetype)init
{
    self = [super init];
    
    
    return self;
}

- (KKTableViewModel*)tableViewModel
{
    if (!_tableViewModel) {
        
        KKTableViewModel *tableViewModel = [[KKTableViewModel alloc]init];
        [tableViewModel addSetionModel:[self applierSectionModel]];
        [tableViewModel addSetionModel:[self goodsSectionModel]];
        [tableViewModel addSetionModel:[self goodsListSectionModel]];
        [tableViewModel addSetionModel:[self goodsCountSectionModel]];
        [tableViewModel addSetionModel:[self remarkSectionModel]];
        _tableViewModel = tableViewModel;
        
    }
    return _tableViewModel;
}

- (KKSectionModel*)applierSectionModel
{
    KKSectionModel *section = [KKSectionModel new];
    section.footerData.height = 10;
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellType = @"applier";
    cellModel.cellClass = NSClassFromString(@"ChooseTableViewCell");
    
    if (_applierData==nil) {
        
        ChooseTableViewCellModel *data = [ChooseTableViewCellModel new];
        data.title = @"供应商";
        data.hideLine = YES;
        data.desc = [CMLinkTextViewItem attributeStringWithText:@"请选择" textFont:APPFONT(17) textColor:ColorWithHex(@"#8F8E94") textAlignment:NSTextAlignmentRight];// selec #F29700 100%
        data.contentKey = @"applier";
        data.hideLine = YES;
        data.attriStrcontent = [CMLinkTextViewItem attributeStringWithText:@"必填" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999") textAlignment:NSTextAlignmentLeft];// selec #F29700 100%
        cellModel.data = data;
        _applierData = data;
        
    }else
    {
        cellModel.data = _applierData;
    }

    [section addCellModel:cellModel];
    RouterModel *routerModel = [RouterModel new];
    routerModel.className = @"SupplierListViewController";
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    routerModel.param = param.copy;
    cellModel.routerModel = routerModel;

    return section;
}

- (KKSectionModel*)goodsSectionModel
{
    KKSectionModel *section = [KKSectionModel new];
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellType = @"goods";
    cellModel.cellClass = NSClassFromString(@"ChooseTableViewCell");
    ChooseTableViewCellModel *data = [ChooseTableViewCellModel new];
    data.title = @"商品";
  
    if (self.goodsList.count>0) {
        
          data.desc = [CMLinkTextViewItem attributeStringWithText:@"添加" textFont:APPFONT(17) textColor:ColorWithHex(@"#F29700") textAlignment:NSTextAlignmentRight];
        data.attriStrcontent = nil;

    }else
    {
          data.desc = [CMLinkTextViewItem attributeStringWithText:@"请选择" textFont:APPFONT(17) textColor:ColorWithHex(@"#8F8E94") textAlignment:NSTextAlignmentRight];// selec #F29700 100%
        data.attriStrcontent = [CMLinkTextViewItem attributeStringWithText:@"必填" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999") textAlignment:NSTextAlignmentLeft];// selec #F29700 100%

    }
    data.contentKey = @"goods";
    cellModel.data = data;
    [section addCellModel:cellModel];
    
    //StockGoodsListViewController
    
    RouterModel *routerModel = [RouterModel new];
    routerModel.className = @"StockGoodsListViewController";
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:@1 forKey:@"present"];
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:self.goodsList forKey:@"goodsList"];
    [param setObject:@"AddStockViewController" forKey:@"backClassName"];
    routerModel.param = param.copy;
    cellModel.routerModel = routerModel;

    return section;
}

- (KKSectionModel*)goodsListSectionModel
{
    if (self.goodsList.count>0)
    {
        KKSectionModel *section = [KKSectionModel new];
        for (NSDictionary *goods in self.goodsList) {
            [section addCellModel:[self goodsCellModel:goods]];
        }
        return section;
    }
    
    return nil;
}

- (KKCellModel*)goodsCellModel:(NSDictionary*)goods
{
    KKCellModel *cell = [KKCellModel new];
    
    cell.cellClass = NSClassFromString(@"OrderDetailMerchandiseCell");
    OrderDetailMerchandiseCellModel *data = [OrderDetailMerchandiseCellModel new];
    data.name = goods[@"title"];
    data.brand = goods[@"content"];
    data.desc = goods[@"desc"];
    cell.height = [data.name calculateHeight:CGSizeMake(SCREEN_WIDTH-120, 200) font:APPFONT(17)]+55;
    
    
    NSString *amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(goods[@"purchasePrice"])];
    data.amount = amount;
    NSNumber *number = goods[@"purchaseNum"];
    data.count = STRING(@"x", number);
    cell.data = data;
    return cell;
}

- (KKSectionModel*)goodsCountSectionModel
{
    KKSectionModel *section = [KKSectionModel new];
    section.footerData.height = 10;
    [section addCellModel:self.goodsCountCellModel];
    [section addCellModel:self.totalAmountCellModel];
    [section addCellModel:self.creditAmountCellModel];
    [section addCellModel:self.prepaidAmountCellModel];
    return section;
}

- (KKCellModel*)goodsCountCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellType = @"goodsCount";
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    data.title = [NSString stringWithFormat:@"共%@件商品",@(self.goodsList.count)];
    NSString *total = STRING(@"合计:¥", [self totalAmount]);
    data.amount = [CMLinkTextViewItem attributeStringWithText:total textFont:APPFONT(17) textColor: ColorWithHex(@"#333333") textAlignment:NSTextAlignmentRight];
    cellModel.data = data;
    return cellModel;
}

- (KKCellModel*)totalAmountCellModel
{
    if (_totalAmountCellModel == nil)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 75;
        cellModel.cellType = @"totalAmount";
        cellModel.cellClass = NSClassFromString(@"SettlementAmountTableViewCell");
        cellModel.data = self.finalAmountData;
        _totalAmountCellModel = cellModel;
    }
    return _totalAmountCellModel;
}

- (KKCellModel*)creditAmountCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellType = @"creditAmount";
    cellModel.cellClass = NSClassFromString(@"SettlementAmountTableViewCell");
    cellModel.data = self.creditData;
    return cellModel;
}

- (KKCellModel*)prepaidAmountCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 50;
    cellModel.cellType = @"prepaidAmount";
    cellModel.cellClass = NSClassFromString(@"RemarkTableViewCell");
    cellModel.data = self.prepaidData;
    return cellModel;
}



- (KKSectionModel*)remarkSectionModel
{
    KKSectionModel *section = [KKSectionModel new];
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellType = @"remark";
    cellModel.cellClass = NSClassFromString(@"InputTableViewCell");
    if (_remarkData == nil) {
     
        InputTableViewCellModel *data = [InputTableViewCellModel new];
        data.title = @"备注";
        data.placeholder = @"最多50个字";
        _remarkData = data;
    }
    cellModel.data = _remarkData;
    [section addCellModel:cellModel];
    return section;
}

- (void)setSupplierName:(NSString *)supplierName
{
    _supplierName = supplierName;
    _applierData.content = supplierName;
    _applierData.desc = [CMLinkTextViewItem attributeStringWithText:@"修改" textFont:APPFONT(17) textColor:ColorWithHex(@"#F29700") textAlignment:NSTextAlignmentRight];// selec #F29700 100%

}

- (SettlementAmountTableViewCellModel *)creditData
{
    if (!_creditData) {
        SettlementAmountTableViewCellModel *data = [SettlementAmountTableViewCellModel new];
        data.title = @"赊欠金额";
        data.placeholder = @"¥0.00";
        data.keyBoardType = UIKeyboardTypeDecimalPad;
        _creditData = data;
    }
    return _creditData;
}

- (SettlementAmountTableViewCellModel *)finalAmountData
{
    if (!_finalAmountData) {
        
        SettlementAmountTableViewCellModel *data = [SettlementAmountTableViewCellModel new];
        data.title = @"结算金额";
        data.placeholder = @"¥0.00";
        data.keyBoardType = UIKeyboardTypeDecimalPad;
        _finalAmountData = data;
    }
    return _finalAmountData;
}

- (RemarkTableViewCellModel *)prepaidData
{
    if (!_prepaidData) {
        
        RemarkTableViewCellModel *data = [RemarkTableViewCellModel new];
        data.content = [CMLinkTextViewItem attributeStringWithText:@"已收金额：¥0.00" textFont:APPFONT(12) textColor:ColorWithHex(@"#262626") textAlignment:NSTextAlignmentRight];
        _prepaidData = data;
    }
    return _prepaidData;
}

- (NSString*)totalAmount
{
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (NSDictionary *goods in self.goodsList)
    {
        NSDecimalNumber *finalAmount = [NSDecimalNumber decimalNumberWithString:goods[@"finalAmount"]];
        NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                          decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                          scale:2
                                          raiseOnExactness:NO
                                          raiseOnOverflow:NO
                                          raiseOnUnderflow:NO
                                          raiseOnDivideByZero:YES];
        total = [total decimalNumberByAdding:finalAmount withBehavior:roundUp];
    }
    return AMOUNTSTRING(total.description);
}

- (NSArray*)purchaseDetail
{
    NSMutableArray *array = @[].mutableCopy;
    for (NSDictionary *param in self.goodsList)
    {
        NSMutableDictionary *md = param.mutableCopy;
        [md removeObjectForKey:@"content"];
        [md removeObjectForKey:@"title"];
        [array addObject:md.copy];
    }
    return array.copy;
}

- (NSMutableDictionary*)purchase
{
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:self.supplierId forKey:@"supplierId"];
    [md setObject:self.remarkData.content forKey:@"remark"];
    
    if (self.creditData.content && self.creditData.content.floatValue>0)
    {
        [md setObject:AMOUNTSTRING(self.creditData.content) forKey:@"creditAmount"];
        [md setObject:@1 forKey:@"isCredit"];
        [md setObject:@"赊账" forKey:@"method"];
        
    }else
    {
        [md setObject:@0 forKey:@"isCredit"];
        [md setObject:@"全款" forKey:@"method"];
    }
    [md setObject:@3 forKey:@"status"];
    [md setObject:AMOUNTSTRING(self.finalAmountData.content) forKey:@"finalAmount"];
    [md setObject:[self totalAmount] forKey:@"totalAmount"];

    return md;
}


-(void)dealloc
{
    
}

@end
