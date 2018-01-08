//
//  MallOrderTabFooter.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallOrderTabFooter;

@protocol MallOrderTabFooterDelegate <NSObject>

- (void)tabFooterDidTapSubmitBtn:(MallOrderTabFooter *)footer;
@end

@interface MallOrderTabFooter : UIView<HNReactView>

@property (nonatomic,weak) id<MallOrderTabFooterDelegate> delegate;
@end
