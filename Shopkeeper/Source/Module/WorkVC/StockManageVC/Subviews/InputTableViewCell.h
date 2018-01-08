//
//  InputTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTableViewCell : UITableViewCell

@end

@interface InputTableViewCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,copy)NSString *contentKey;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,assign)NSInteger maxLength;
@property(nonatomic,assign)UIKeyboardType keyBoardType;

@end
