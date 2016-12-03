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
    
    [self.databaseView setDelegateForDatabaseTable:self];
    
    self.databaseTableDataSource = [[DatabaseTableDataSource alloc] init];
    [self.databaseTableDataSource performFetch:^(NSError *error){
        if (!error) {
            [self.databaseView setDataSourceForDatabaseTable:self.databaseTableDataSource];
        } else {
            NSLog(@"Fetch failed with error:");
            [error fullDescription];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.databaseView reloadDatabaseTable];
        });
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
