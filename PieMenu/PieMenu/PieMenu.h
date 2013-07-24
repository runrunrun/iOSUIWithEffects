//
//  PieMenu.h
//  PieMenu
//
//  Created by Hari Kunwar on 7/20/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieMenu;
@class MenuItem;

@protocol PieMenuDelegate

- (void)pieMenu:(PieMenu *)menu didTouchMenuItem:(MenuItem *)menuItem;

@end

@interface PieMenu : UIView

@property (nonatomic, strong) NSMutableArray *menuItems;
@property (nonatomic, strong) id<PieMenuDelegate> delegate;

@end
