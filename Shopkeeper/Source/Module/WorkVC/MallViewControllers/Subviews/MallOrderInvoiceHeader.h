//
//  MallOrderInvoiceHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallOrderInvoiceHeader;

@protocol MallOrderInvoiceHeaderDelegate <NSObject>

- (void)invoiceHeader:(MallOrderInvoiceHeader *)header switchOn:(BOOL)on;
@end

@interface MallOrderInvoiceHeader : UITableViewHeaderFooterView

@property (nonatomic,weak) id<MallOrderInvoiceHeaderDelegate> delegate;
@end
