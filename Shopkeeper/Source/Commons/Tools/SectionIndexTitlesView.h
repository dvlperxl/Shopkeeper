//
//  SectionIndexTitlesView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionIndexTitlesViewDelegate <NSObject>

-(void)sectionIndexTitlesViewDidSelectTitle:(NSString*)title withIndex:(NSInteger)index;

@end

@interface SectionIndexTitlesView : UIView

@property(nonatomic,weak)id<SectionIndexTitlesViewDelegate> delegate;

- (void)reloadData:(NSArray *)list;


@end
