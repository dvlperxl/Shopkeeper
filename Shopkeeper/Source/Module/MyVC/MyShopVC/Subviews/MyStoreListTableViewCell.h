//
//  MyStoreListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStoreListTableViewCellModel;

@interface MyStoreListTableViewCell : UITableViewCell

- (void)reloadData:(MyStoreListTableViewCellModel*)model;

@end

@interface MyStoreListTableViewCellModel : NSObject

@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,assign)NSInteger index;

@end
