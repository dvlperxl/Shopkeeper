//
//  MyTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTableViewCellModel;

@interface MyTableViewCell : UITableViewCell

- (void)reloadData:(MyTableViewCellModel*)model;

@end



@interface MyTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *iconImageName;
@property(nonatomic,copy)NSString *type;

@end
