//
//  DistibutorOrderSearchViewModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderSearchViewModel.h"
#import "DistibutorOrderSearchListCell.h"
#import "DistibutorManageModel.h"


@interface DistibutorOrderSearchViewModel()

@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)KKSectionModel *sectionModel;
@property(nonatomic,strong)NSString *searchString;

@end

@implementation DistibutorOrderSearchViewModel

- (KKTableViewModel*)tableModel:(NSArray*)orderList searchString:(NSString*)searchString;
{
    if (![orderList isKindOfClass:[NSArray class]])
    {
        return self.tableViewModel;
    }
    
    self.searchString = searchString;
    NSArray *orderInfoList = [DistibutorOrderListInfo modelObjectListWithArray:orderList];
    
    if (self.tableViewModel.sectionDataList.count == 0){
        
        [self.tableViewModel addSetionModel:self.sectionModel];
    }
    
    for (DistibutorOrderListInfo *orderInfo in orderInfoList) {
        
        [self.sectionModel addCellModel:[self cellModel:orderInfo]];
    }
    
    return self.tableViewModel;
}

- (KKCellModel *)cellModel:(DistibutorOrderListInfo*)orderInfo
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"DistibutorOrderSearchListCell");
    cellModel.height = 75;
    
    DistibutorOrderSearchListCellModel *data = [DistibutorOrderSearchListCellModel new];
    
    data.title = [self attributedString:orderInfo.wholesaleName
                           selectString:self.searchString
                            selectColor:ColorWithHex(@"#F49900")
                            normalColor:ColorWithHex(@"#333333")
                                   font:APPFONT(18)];
    
    NSString *orderNo = [NSString stringWithFormat:@"订单号%@",orderInfo.retailNo];
    data.desc = [self attributedString:orderNo
                          selectString:self.searchString
                           selectColor:ColorWithHex(@"#F49900")
                           normalColor:ColorWithHex(@"#999999")
                                  font:APPFONT(14)];
    data.amount = AMOUNTSTRING(orderInfo.finalAmount);
    
    cellModel.data = data;
    
    cellModel.routerModel.className = @"DistibutorOrderDetailViewController";
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:orderInfo.uid forKey:@"retailNo"];
    cellModel.routerModel.param = md.copy;
    
    return cellModel;
}

- (NSAttributedString *)attributedString:(NSString*)string
                            selectString:(NSString*)selectString
                             selectColor:(UIColor*)selectColor
                             normalColor:(UIColor*)normalColor
                                    font:(UIFont*)font
{
    NSMutableAttributedString *mAStr = [[NSMutableAttributedString alloc]init];
    
    NSRange range =  [string rangeOfString:selectString];
    if (range.length>0)
    {
        if (range.location>0)
        {
            NSAttributedString *aStr = [CMLinkTextViewItem attributeStringWithText:[string substringToIndex:range.location] textFont:font textColor:normalColor];
            [mAStr appendAttributedString:aStr];

        }
        
        NSAttributedString *aStr = [CMLinkTextViewItem attributeStringWithText:selectString textFont:font textColor:selectColor];
        [mAStr appendAttributedString:aStr];
        
        NSAttributedString *aStr1 = [CMLinkTextViewItem attributeStringWithText:[string substringFromIndex:range.location+range.length] textFont:font textColor:normalColor];
        [mAStr appendAttributedString:aStr1];
        
        
    }else
    {
      NSAttributedString *aStr = [CMLinkTextViewItem attributeStringWithText:string textFont:font textColor:normalColor];
        [mAStr appendAttributedString:aStr];
    }
    
    return mAStr.copy;
}

- (KKSectionModel*)sectionModel
{
    if (!_sectionModel) {
        
        _sectionModel = [KKSectionModel new];
    }
    return _sectionModel;
}

-(KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel = [KKTableViewModel new];
        _tableViewModel.noResultTitle = @"输入关键词立即搜索";
        _tableViewModel.noResultImageName = Default_noresult;
    }
    return _tableViewModel;
}

@end
