//
//  AddReceivePeopleModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddReceivePeopleModel.h"
#import "AddStoreTableViewCell.h"
#import "InputTableViewCell.h"
#import "ChooseTableViewCell.h"
#import "NSMutableArray+safe.h"

@implementation AddReceivePeopleModel

+ (KKTableViewModel*)tableViewModelWithAddressDetail:(NSDictionary*)addressDetail
{
    KKTableViewModel *tableViewmodel = [[KKTableViewModel alloc]init];
    
    KKSectionModel *section = [KKSectionModel new];
    section.footerData.height = 10;
    [tableViewmodel addSetionModel:section];
    
    NSMutableArray *contents = @[].mutableCopy;

    if (addressDetail) {
        
        NSString *obj = addressDetail[@"receivePerson"];
        
        [contents addStringNilToSpace:obj];
        
        obj = addressDetail[@"receivePhone"];
        [contents addStringNilToSpace:obj];
        
        obj = addressDetail[@"area"];
        [contents addStringNilToSpace:obj];

        obj = addressDetail[@"village"];
        [contents addStringNilToSpace:obj];
        
        obj = addressDetail[@"addressDetail"];
        [contents addStringNilToSpace:obj];
        
    }
    
    NSArray *titles = @[@"姓名",@"手机号码",@"所在地区",@"街道/村",@"详细地址"];
    NSArray *placeholders = @[@"请输入姓名",@"请输入手机号码",@"",@"",@"请输入详细地址"];
    NSArray *contentKeys = @[@"receivePerson",@"receivePhone",@"areaId",@"village",@"address"];
    
    NSArray *edits = @[@1,@1,@0,@0,@1];
    
    for (NSInteger i = 0; i<titles.count; i++)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 75;
        cellModel.cellType = contentKeys[i];
        BOOL edit = [edits[i] boolValue];
        if (edit)
        {
            cellModel.cellClass = NSClassFromString(@"InputTableViewCell");
            InputTableViewCellModel *data = [InputTableViewCellModel new];
            data.title = titles[i];
            data.placeholder = placeholders[i];
            data.contentKey = contentKeys[i];
            cellModel.data = data;
            data.content = [contents objectAtIndex:i];

            if ([data.contentKey isEqualToString:@"receivePhone"]) {
                
                data.keyBoardType = UIKeyboardTypeNumberPad;
                data.maxLength = 11;
            }
        }
        else
        {
            cellModel.cellClass = NSClassFromString(@"ChooseTableViewCell");
            ChooseTableViewCellModel *data = [ChooseTableViewCellModel new];
            data.title = titles[i];
            data.contentKey = contentKeys[i];
            cellModel.data = data;
            data.desc = [CMLinkTextViewItem attributeStringWithText:@"请选择" textFont:APPFONT(17) textColor:ColorWithHex(@"#8F8E94") textAlignment:NSTextAlignmentRight];// selec #F29700 100%
            
            data.content = [contents objectAtIndex:i];
            
            if (data.content.length>0)
            {
                data.desc = nil;
            }
            
        }
        [section addCellModel:cellModel];
    }
    
    return tableViewmodel;
}


+ (NSDictionary*)getAddReceivePeopleParam:(KKTableViewModel*)tableView
{
    NSMutableDictionary *param = @{}.mutableCopy;
    
    for (KKSectionModel *section in tableView.sectionDataList) {
        
        for (KKCellModel *cellModel in section.cellDataList)
        {
            AddStoreTableViewCellModel *dataModel = (AddStoreTableViewCellModel*)cellModel.data;
            [param setObject:dataModel.content forKey:dataModel.contentKey];
        }
    }
    
    return param;
}

+ (void)ma:(NSMutableArray*)ma addObject:(NSString*)obj
{
    if (obj== nil) {
        obj = @"";
    }
    [ma addObject:obj];
}



@end
