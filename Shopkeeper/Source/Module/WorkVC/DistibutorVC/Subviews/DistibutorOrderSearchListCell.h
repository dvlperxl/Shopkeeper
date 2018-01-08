//
//  DistibutorOrderSearchListCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistibutorOrderSearchListCell : UITableViewCell

@end


@interface DistibutorOrderSearchListCellModel : BaseCellModel

@property(nonatomic,copy)NSAttributedString *title;
@property(nonatomic,copy)NSAttributedString *desc;
@property(nonatomic,copy)NSString *amount;

@end
