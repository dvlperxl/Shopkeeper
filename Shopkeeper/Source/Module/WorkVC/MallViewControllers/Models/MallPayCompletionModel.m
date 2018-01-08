//
//  MallPayCompletionModel.m
//  Shopkeeper
//
//  Created by xl on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallPayCompletionModel.h"

@interface MallPayCompletionModel ()

@property (nonatomic,strong) UIImage *payStatusBg;
@property (nonatomic,strong) UIImage *payStatusIcon;
@property (nonatomic,copy) NSString *payStatus;
@property (nonatomic,copy) NSAttributedString *payToast;
@property (nonatomic,copy) NSString *payContentTitle;
@property (nonatomic,copy) NSString *payContentInfo;
@property (nonatomic,copy) NSString *payTypeTitle;
@property (nonatomic,copy) NSString *payTypeInfo;
@property (nonatomic,copy) NSString *leftBtnTitle;
@property (nonatomic,copy) NSString *rightBtnTitle;
@end

@implementation MallPayCompletionModel

- (void)setPayCompletionType:(MallPayCompletionVCType)payCompletionType {
    _payCompletionType = payCompletionType;
    switch (payCompletionType) {
        case MallPayCompletionVCTypeSuccess:
            {
                self.payStatusBg = [UIImage imageNamed:@"pay_sucess_bk"];
                self.payStatusIcon = [UIImage imageNamed:@"pay_sucess"];
                self.payStatus = @"支付成功";
                self.payToast = nil;
                self.payContentTitle = @"支付内容：";
                self.payContentInfo = @"采购农资";
                self.payTypeTitle = @"支付方式：";
                self.payTypeInfo = @"支付宝";
                self.leftBtnTitle = @"继续开单" ;
                self.rightBtnTitle = @"查看订单";
            }
            break;
        case MallPayCompletionVCTypeFailure:
        {
            self.payStatusBg = [UIImage imageNamed:@"pay_failed_bk"];
            self.payStatusIcon = [UIImage imageNamed:@"pay_failed"];
            self.payStatus = @"支付失败";
            self.payContentTitle = @"支付内容：";
            self.payContentInfo = @"采购农资";
            self.payTypeTitle = @"支付方式：";
            self.payTypeInfo = @"支付宝";
            self.leftBtnTitle = @"暂不支付" ;
            self.rightBtnTitle = @"重新支付";
            NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
            paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paraStyle.alignment = NSTextAlignmentLeft;
            paraStyle.lineSpacing = 6;
            paraStyle.hyphenationFactor = 1.0;
            paraStyle.firstLineHeadIndent = 0.0;
            paraStyle.paragraphSpacingBefore = 0.0;
            paraStyle.headIndent = 0;
            paraStyle.tailIndent = 0;
            NSDictionary *attributes = @{NSFontAttributeName:APPFONT(13), NSParagraphStyleAttributeName:paraStyle};
            NSAttributedString *toast = [[NSAttributedString alloc] initWithString:@"支付遇到问题？\n请拨打热线400-9009078获取帮助" attributes:attributes];
            self.payToast = toast;
        }
            break;
        default:
            break;
    }
}
@end
