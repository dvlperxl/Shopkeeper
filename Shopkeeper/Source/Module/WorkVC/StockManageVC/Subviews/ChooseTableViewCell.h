//
//  ChooseTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTableViewCell : UITableViewCell


@end

@interface ChooseTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSAttributedString *attriStrcontent;
@property(nonatomic,copy)NSAttributedString *desc;
@property(nonatomic,copy)NSString *contentKey;

@end
