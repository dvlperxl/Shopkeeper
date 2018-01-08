//
//  DistibutorOrderSearchViewModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistibutorOrderSearchViewModel : NSObject

- (KKTableViewModel*)tableModel:(NSArray*)orderList searchString:(NSString*)searchString;

@end
