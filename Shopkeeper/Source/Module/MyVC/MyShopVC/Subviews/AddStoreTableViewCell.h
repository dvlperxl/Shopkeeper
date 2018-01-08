//
//  AddStoreTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddStoreTableViewCellModel;

@interface AddStoreTableViewCell : UITableViewCell

- (void)reloadData:(AddStoreTableViewCellModel*)model;

@end

@interface AddStoreTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)NSInteger maxlength;
@property(nonatomic,assign)BOOL edit;
@property(nonatomic,assign)BOOL choose;
@property(nonatomic,copy)NSString *contentKey;
@property(nonatomic,copy)NSString *placeholder;


@end
