//
//  DatabaseViewController.m
//  Vratis
//
//  Created by Daniel Budynski on 30/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "DatabaseViewController.h"
#import "DatabaseView.h"
#import "DatabaseTableDataSource.h"

#import "NSError+Description.h"

@interface DatabaseViewController () <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet DatabaseView *databaseView;

@property (strong, nonatomic) DatabaseTableDataSource *databaseTableDataSource;
@end

@implementation DatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Delegate
    [self.databaseView setDelegateForDatabaseTable:self];
    
    // Data Source
    self.databaseTableDataSource = [[DatabaseTableDataSource alloc] init];
    // TODO: Change this fucking callback's rollercoster
    [self.databaseTableDataSource fetch:^(NSError *error){
        if (!error) {
            [self.databaseView setDataSourceForDatabaseTable:self.databaseTableDataSource];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.databaseView reloadDatabaseTable];
            });
        } else {
            [error fullDescription];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark Getters & Setters
- (DatabaseView *)databaseView {
    return (DatabaseView *)self.view;
}

#pragma mark IBActions
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
