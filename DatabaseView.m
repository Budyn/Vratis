//
//  DatabaseView.m
//  Vratis
//
//  Created by Daniel Budynski on 30/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "DatabaseView.h"

@interface DatabaseView()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *databaseTableView;


@end

@implementation DatabaseView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backButton.clipsToBounds = YES;
    self.backButton.layer.cornerRadius = 10;
}

- (void)setDataSourceForDatabaseTable:(id<UITableViewDataSource>)dataSource {
    self.databaseTableView.dataSource = dataSource;
}

- (void)setDelegateForDatabaseTable:(id<UITableViewDelegate>)delegate {
    self.databaseTableView.delegate = delegate;
}

- (void)reloadDatabaseTable {
    [self.databaseTableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
