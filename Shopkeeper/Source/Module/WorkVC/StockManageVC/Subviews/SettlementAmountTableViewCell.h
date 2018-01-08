//
//  SettlementAmountTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementAmountTableViewCell : UITableViewCell


@end

@interface SettlementAmountTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,assign)UIKeyboardType keyBoardType;
@property(nonatomic,copy)NSString *totalAmount;
@property(nonatomic,copy)NSString *inputMaxAmount;

@end

