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

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet SettingsView *settingsView;
@property (strong, nonatomic) SettingsTableDataSource *settingsTableDataSource;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsTableDataSource = [[SettingsTableDataSource alloc] init];
    [self.settingsView setSettingsTableDataSource:self.settingsTableDataSource];
    [self.settingsView reloadModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setters & Getters
- (SettingsView *)settingsView {
    return (SettingsView *)self.view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
