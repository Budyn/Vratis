//
//  DatabaseView.h
//  Vratis
//
//  Created by Daniel Budynski on 30/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatabaseView : UIView
- (void)setDelegateForDatabaseTable:(id<UITableViewDelegate>)delegate;
- (void)setDataSourceForDatabaseTable:(id<UITableViewDataSource>)dataSource;

@end
