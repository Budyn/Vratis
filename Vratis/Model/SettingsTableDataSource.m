//
//  SettingsTableDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 07/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "SettingsTableDataSource.h"
#import "SettingsTableViewCell.h"

@interface SettingsTableDataSource()
@property (strong, nonatomic) NSArray *settingsTitle;
@property (strong, nonatomic) NSArray *settingsSubtitle;
@property (strong, nonatomic) NSArray *settingsIcon;

@end

@implementation SettingsTableDataSource
- (instancetype)init {
    self = [super init];
    if (self) {
        _settingsTitle = @[@"Profile",
                           @"Recently visited",
                           @"Your places"];
        _settingsSubtitle = @[@"Your personal information",
                           @"Recently visited places",
                           @"Places that you love"];
        _settingsIcon = @[@"settings-profile",
                          @"settings-place",
                          @"settings-like"];
        
    }
    return self;
}
#pragma mark Setters & Getters


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsTitle.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SettingsC" forIndexPath:indexPath];
    if (!cell) {
        cell = [[SettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsC"];
    }
    
    [cell setTitle:[self.settingsTitle objectAtIndex:indexPath.row]];
    [cell setSubtitle:[self.settingsSubtitle objectAtIndex:indexPath.row]];
    [cell setIcon:[self.settingsIcon objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
