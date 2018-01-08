//
//  HNSearchController.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HNSearchController.h"

@interface HNSearchController ()<UISearchBarDelegate>

@end

@implementation HNSearchController

#pragma mark - 初始化
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self hn_setupSearchBar];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self hn_setupSearchBar];
    }
    return self;
}
- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController {
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        
    }
    return self;
}

- (void)hn_setupSearchBar {
    HNSearchBar *hn_searchBar = [[HNSearchBar alloc]init];
    hn_searchBar.delegate = self;
    _hn_searchBar = hn_searchBar;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.hn_active = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    self.hn_active = YES;
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (self.hn_searchDelegate && [self.hn_searchDelegate respondsToSelector:@selector(hn_updateSearchResultsForSearchController:searchText:)]) {
        [self.hn_searchDelegate hn_updateSearchResultsForSearchController:self searchText:searchBar.text];
    }
}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//    return YES;
//}
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//
//}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.hn_searchDelegate && [self.hn_searchDelegate respondsToSelector:@selector(hn_updateSearchResultsForSearchController:searchText:)]) {
        [self.hn_searchDelegate hn_updateSearchResultsForSearchController:self searchText:searchText];
    }
}
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    return YES;
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //让键盘下去
    [searchBar resignFirstResponder];
    if (self.hn_searchDelegate && [self.hn_searchDelegate respondsToSelector:@selector(hn_SearchControllerSearchButtonClick:)]) {
        [self.hn_searchDelegate hn_SearchControllerSearchButtonClick:self];
    }
}
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
//
//}
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//
//}
//- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
//
//}

//- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
//
//}


@end
