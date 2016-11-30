//
//  DatabaseTableDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 30/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "DatabaseTableDataSource.h"
#import "DatabaseTableCell.h"

@implementation DatabaseTableDataSource

#pragma mark UITableDataViewSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DatabaseTableCell *cell = (DatabaseTableCell *)[tableView dequeueReusableCellWithIdentifier:@"databaseTC"];
    return cell;
}

@end
