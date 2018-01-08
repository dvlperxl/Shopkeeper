//
//  ReicpePackageFooterReusableView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReicpePackageFooterReusableViewDelegate<NSObject>

- (void)reicpePackageFooterReusableViewDidSelectAddButton;

@end

@interface ReicpePackageFooterReusableView : UICollectionReusableView

@property(nonatomic,weak)id<ReicpePackageFooterReusableViewDelegate> delegate;
@property(nonatomic,strong)UILabel *descLab;

@end
