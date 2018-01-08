//
//  SMSRechargeListCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSRechargeListCell : UITableViewCell

@end


@interface SMSRechargeListCellModel : BaseCellModel

@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *amout;
@property(nonatomic,strong)NSString *payType;

@end
