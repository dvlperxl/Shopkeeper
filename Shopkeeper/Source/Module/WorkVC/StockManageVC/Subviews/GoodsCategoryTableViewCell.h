//
//  GoodsCategoryTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCategoryTableViewCell : UITableViewCell

@end

@interface GoodsCategoryTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *imageBgColor;//16进制
@property(nonatomic,strong)NSNumber *gid;//
@property(nonatomic,assign)BOOL select;

@end
