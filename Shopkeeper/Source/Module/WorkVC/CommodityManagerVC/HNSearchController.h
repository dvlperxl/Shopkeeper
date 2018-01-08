//
//  HNSearchController.h
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNSearchBar.h"
@class HNSearchController;

@protocol HNSearchControllerDelegate <NSObject>

- (void)hn_updateSearchResultsForSearchController:(HNSearchController *)searchController searchText:(NSString *)searchText;
- (void)hn_SearchControllerSearchButtonClick:(HNSearchController *)searchController;
@end

@interface HNSearchController : UISearchController

@property(nonatomic,weak) id<HNSearchControllerDelegate> hn_searchDelegate;
@property(nonatomic,strong,readonly) HNSearchBar *hn_searchBar;
@property(nonatomic,assign) BOOL hn_active;
@end
