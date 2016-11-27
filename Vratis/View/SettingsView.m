//
//  SettingsView.m
//  Vratis
//
//  Created by Daniel Budynski on 02/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <assert.h>
#import "SettingsView.h"

@interface SettingsView()
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end

@implementation SettingsView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)reloadModel {
    [self.settingsTableView reloadData];
}

#pragma mark Setters & Getters
- (void)setSettingsTableDataSource:(id<UITableViewDataSource>)settingsTableDataSource {
    if (settingsTableDataSource) {
        self.settingsTableView.dataSource = settingsTableDataSource;
        return;
    }
    NSAssert(settingsTableDataSource, @"Settings table data source is nil");
}

@end
