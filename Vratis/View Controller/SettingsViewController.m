//
//  SettingsViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 29/10/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsView.h"
#import "SettingsTableDataSource.h"

typedef NS_ENUM(NSUInteger, CellType) {
    ProfileCell = 0,
    PlacesCell,
};

@interface SettingsViewController () <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet SettingsView *settingsView;
@property (strong, nonatomic) SettingsTableDataSource *settingsTableDataSource;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsTableDataSource = [[SettingsTableDataSource alloc] init];
    [self.settingsView setSettingsTableDataSource:self.settingsTableDataSource];
    [self.settingsView setSettingsTableDelegate:self];
    
    [self.settingsView reloadModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Setters & Getters
- (SettingsView *)settingsView {
    return (SettingsView *)self.view;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ProfileCell) {
        [self performSegueWithIdentifier:@"profileSegue" sender:nil];
    } else if (indexPath.row == PlacesCell) {
        [self performSegueWithIdentifier:@"placeSegue" sender:nil];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
