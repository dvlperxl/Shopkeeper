//
//  CMLinkTextView.m
//  CMLinkTextView
//
//  Created by caiming on 16/9/12.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "CMLinkTextView.h"
#import <CoreText/CoreText.h>


@interface CMLinkTextView()

@property(nonatomic, strong)CMLinkTextViewItem *selectItem;
@property(nonatomic, strong)NSArray *linkTextViewItems;
@property(nonatomic, strong)NSArray *URLS;

@end

@implementation CMLinkTextView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.scrollEnabled = NO;
    self.allowsEditingTextAttributes = NO;
    self.selectable = NO;
    self.editable = NO;
//    self.dataDetectorTypes = UIDataDetectorTypeAll;
//    self.contentInset = UIEdgeInsetsMake(-6, 30, -6, 0);
    return self;
}


- (CGFloat)reloadData:(NSArray *)linkTextViewItems
{
    
    _linkTextViewItems = linkTextViewItems;
    self.attributedText = [AttributedString attributeWithLinkTextViewItems:linkTextViewItems];
//    [self sizeToFit];
    
    return self.frame.size.height;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _selectItem = [self getItemByTouchSet:touches fromLinks:_linkTextViewItems];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CMLinkTextViewItem* currentItem = [self getItemByTouchSet:touches fromLinks:_linkTextViewItems];
    _selectItem = currentItem;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _selectItem = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_selectItem)
    {
        if ([_cmDelegate respondsToSelector:@selector(linkTextView:selectIndex:)])
        {
            if ([_linkTextViewItems indexOfObject:_selectItem] != NSNotFound) {
                [_cmDelegate linkTextView:self selectIndex:[_linkTextViewItems indexOfObject:_selectItem]];
            }
        }
 
    }
 
}

-(CMLinkTextViewItem*)getItemByTouchSet:(NSSet*)touches fromLinks:(NSArray*)links
{
    CGPoint location = [touches.allObjects.lastObject locationInView:self];
    location.x -= self.textContainerInset.left;
    location.y -= self.textContainerInset.top;
    NSUInteger characterIndex;
    characterIndex = [self.layoutManager
                      characterIndexForPoint:location
                      inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
    
    for (CMLinkTextViewItem* item in links)
    {
        NSUInteger max = item.textRange.location + item.textRange.length;
        
        if (characterIndex >= item.textRange.location && characterIndex < max)
            return item;
    }
    return nil;
}



@end





