//
//  StockGoodsListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockGoodsListModel.h"
#import "GoodsCategoryTableViewCell.h"
#import "StockGoodsListTableViewCell.h"

@implementation StockGoodsListModel

+ (KKTableViewModel*)categoryTableViewModel:(NSArray*)goodsCategoryList
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"pid > 0"];
    goodsCategoryList = [goodsCategoryList filteredArrayUsingPredicate:pred];
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    for (NSDictionary *goodsCategory in goodsCategoryList)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.cellClass = NSClassFromString(@"GoodsCategoryTableViewCell");
        cellModel.height = 75;
        GoodsCategoryTableViewCellModel *data = [GoodsCategoryTableViewCellModel new];
        cellModel.data = data;
        data.title = goodsCategory[@"name"];
        data.gid = goodsCategory[@"id"];
        data.imageBgColor = [self bgColorWithCategory:goodsCategory[@"pid"]];
        [sectionModel addCellModel:cellModel];
    }
    return tableViewModel;
}

+ (void)categoryTableViewSetSelectIndexPath:(NSIndexPath*)indexPath
                             tableViewModel:(KKTableViewModel*)tableViewModel
{
    
}

+ (KKTableViewModel*)goodsListTableViewModel:(NSArray*)goodsList selectGoodsList:(NSArray*)selectGoodsList type:(StockGoodsListViewControllerType)vcType
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    for (NSDictionary *goods in goodsList)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.cellClass = NSClassFromString(@"StockGoodsListTableViewCell");
        cellModel.height = 115;
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"goodsId ==%@",goods[@"id"]];
        NSArray *result = [selectGoodsList filteredArrayUsingPredicate:pred];
        StockGoodsListTableViewCellModel *data;
        if (result.count==1)
        {
            data = result.firstObject;
            [self handleModelAmountPropertyWithModel:data vcType:vcType];
        }else
        {
            data = [StockGoodsListTableViewCellModel new];
            data.goodsId = goods[@"goodsId"];
            data.content = goods[@"goodsBrand"];
            data.desc = goods[@"goodsSpec"];
            data.outputSale = goods[@"goodsOutputSale"];
            data.inputSale = STRINGWITHOBJECT( goods[@"goodsInputSale"]);
            NSString *name = goods[@"goodsName"];
            NSNumber *content = goods[@"content"];
            NSString *contentUnit = goods[@"contentUnit"];
            NSNumber *nitrogen = goods[@"nitrogen"];
            NSNumber *phosphorus = goods[@"phosphorus"];
            NSNumber *potassium = goods[@"potassium"];
            if ([content integerValue]!=0 && contentUnit.length > 0) {
                name = [NSString stringWithFormat:@"%@ %@%@",name,content,contentUnit];
            } else if ([nitrogen integerValue]!=0 || [phosphorus integerValue]!=0 || [potassium integerValue]!=0) {
                name = [NSString stringWithFormat:@"%@ %@-%@-%@",name,nitrogen,phosphorus,potassium];
            }
            data.title = name;
            [self handleModelAmountPropertyWithModel:data vcType:vcType];
        }
        cellModel.data = data;
        [sectionModel addCellModel:cellModel];
    }
    
    return tableViewModel;

}
+ (void)handleModelAmountPropertyWithModel:(StockGoodsListTableViewCellModel *)model vcType:(StockGoodsListViewControllerType)vcType {
    if (model) {
        NSString *price = model.inputSale;
        NSString *placeholder = @"暂无进货价";
        if (vcType == StockGoodsListViewControllerTypeReicpePackageAddPres) {   // 处方套餐新增商品
            price = [model.outputSale isKindOfClass:[NSNumber class]] ? [model.outputSale stringValue] : (NSString *)model.outputSale;
            placeholder = @"暂无售价";
        }
        model.amount = [self amountWithPrice:price placeholder:placeholder];
    }
}
+ (NSAttributedString *)amountWithPrice:(NSString *)price placeholder:(NSString *)placeholder {
    if (price != nil|| [price floatValue]>0)
    {
        NSString *input_sale_str = AMOUNTSTRING(price);
        CMLinkTextViewItem *item = [CMLinkTextViewItem new];
        item.textFont = APPFONT(15);
        item.textColor = ColorWithHex(@"f29700");
        item.textContent = @"¥";
        CMLinkTextViewItem *item1 = [CMLinkTextViewItem new];
        item1.textFont = APPFONT(22);
        item1.textColor = ColorWithHex(@"f29700");
        item1.textContent = input_sale_str;
        return [AttributedString attributeWithLinkTextViewItems:@[item,item1]];
    }else
    {
        return [CMLinkTextViewItem attributeStringWithText:placeholder textFont:APPFONT(22) textColor:ColorWithHex(@"#f29700")];
    }
}
+(NSString*)bgColorWithCategory:(NSString*)color
{
    color = STRINGWITHOBJECT(color);
    NSDictionary *colors = @{@"1":@"#F7F5FA",
                             @"2":@"#FAF8F2",
                             @"3":@"#F5FCF6",
                             @"4":@"#F5F9FC",
                             @"5":@"#FAF2F2",
                             @"6":@"#FAF6F2"
                             };
    
    return colors[color];
}


@end
