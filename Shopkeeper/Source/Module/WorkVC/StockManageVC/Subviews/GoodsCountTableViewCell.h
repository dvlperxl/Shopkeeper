//
//  GoodsCountTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCountTableViewCell : UITableViewCell

@end

@interface GoodsCountTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSAttributedString *amount;

@end
