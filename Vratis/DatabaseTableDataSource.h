//
//  DatabaseTableDataSource.h
//  Vratis
//
//  Created by Daniel Budynski on 30/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface DatabaseTableDataSource : NSObject <UITableViewDataSource>
- (void)performFetch: (void (^)(NSError* error))completion;

@end
