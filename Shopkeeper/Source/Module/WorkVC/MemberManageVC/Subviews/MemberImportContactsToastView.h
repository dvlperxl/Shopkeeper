//
//  MemberImportContactsToastView.h
//  Dev
//
//  Created by xl on 2017/11/13.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MemberImportContactsToastView;

@protocol MemberImportContactsToastViewDelegate <NSObject>

- (void)toastViewTapCloseBtn:(MemberImportContactsToastView *)toastView;
@end

@interface MemberImportContactsToastView : UIView

@property (nonatomic,weak) id<MemberImportContactsToastViewDelegate> delegate;

@property(nonatomic,copy)NSString *tipsStr;

@end
