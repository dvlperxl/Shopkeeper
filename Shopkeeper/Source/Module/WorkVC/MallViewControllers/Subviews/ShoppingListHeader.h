//
//  ShoppingListHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListHeader : UITableViewHeaderFooterView

@end

@interface ShoppingListHeaderModel : NSObject

@property(nonatomic,copy)NSString *wholesaleName;
@property(nonatomic,copy)NSString *wholesaleId;

@end
