//
//  SettingsView.h
//  Vratis
//
//  Created by Daniel Budynski on 02/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIView
- (void)setSettingsTableDataSource:(id<UITableViewDataSource>)settingsTableDataSource;
- (void)setSettingsTableDelegate:(id<UITableViewDelegate>)settingsTableDelegate;
- (void)reloadModel;

@end
