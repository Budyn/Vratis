//
//  AvatarCollectionDataSource.m
//  Vratis
//
//  Created by Daniel Budynski on 28/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "AvatarCollectionDataSource.h"
#import "AvatarCollectionViewCell.h"

@interface AvatarCollectionDataSource()

@end

@implementation AvatarCollectionDataSource
- (instancetype)init {
    self = [super init];
    if (self) {
        _avatarName = @[@"avatar1", @"avatar2"];
    }
    return self;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.avatarName.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AvatarCollectionViewCell *cell = (AvatarCollectionViewCell* )[collectionView dequeueReusableCellWithReuseIdentifier:@"avatarC" forIndexPath:indexPath];
    cell.avatarImageView.image = [UIImage imageNamed:[self.avatarName objectAtIndex:indexPath.row]];
    return cell;
}


@end
