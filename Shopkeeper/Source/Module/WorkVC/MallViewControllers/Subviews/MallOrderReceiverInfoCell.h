//
//  MallOrderReceiverInfoCell.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallOrderReceiverInfoCell : UITableViewCell

@end


@interface MallOrderReceiverInfoCellModel : NSObject

@property (nonatomic,copy) NSString *receiverName;
@property (nonatomic,copy) NSString *receiverMobile;
@property (nonatomic,copy) NSString *receiverFullAddress;
@end
