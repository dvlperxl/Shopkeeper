//
//  MallOrderInvoiceCell.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallOrderInvoiceCell;

@protocol MallOrderInvoiceCellDelegate <NSObject>

- (void)invoiceCell:(MallOrderInvoiceCell *)cell didEndEditingText:(NSString *)text;
@end

@interface MallOrderInvoiceCell : UITableViewCell

@property (nonatomic,weak) id<MallOrderInvoiceCellDelegate> delegate;
@end


@interface MallOrderInvoiceCellModel : NSObject

@property (nonatomic,copy) NSString *leftTitle;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) UIKeyboardType keyboardType;
@end
