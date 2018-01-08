//
//  MemberImportContactsBottomBar.h
//  Dev
//
//  Created by xl on 2017/11/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemberImportContactsBottomBar;

@protocol MemberImportContactsBottomBarDelegate <NSObject>

- (void)bottomBar:(MemberImportContactsBottomBar *)bar tapSelectedAllStatus:(BOOL)status;
- (void)bottomBarTapSureBtn:(MemberImportContactsBottomBar *)bar;
@end

@interface MemberImportContactsBottomBar : UIView

@property (nonatomic,weak) id<MemberImportContactsBottomBarDelegate> delegate;

- (void)setAllSelectedTotalStatus:(BOOL)status;
- (void)allSelectedTotal:(NSInteger)total;
- (void)selectedCount:(NSInteger)count;
@end

