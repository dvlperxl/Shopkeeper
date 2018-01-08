//
//  ChooseMemberTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseMemberTableViewCell : UITableViewCell

@end

@interface ChooseMemberTableViewCellModel : NSObject

@property(nonatomic,assign)BOOL select;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *amountDesc;
@property(nonatomic,copy)NSString *uid;

@end



