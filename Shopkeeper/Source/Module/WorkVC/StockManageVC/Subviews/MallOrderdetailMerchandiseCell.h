//
//  MallOrderdetailMerchandiseCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallOrderdetailMerchandiseCell : UITableViewCell

@end

@interface MallOrderdetailMerchandiseCellModel : BaseCellModel

@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *spec;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSAttributedString *total;

@end
