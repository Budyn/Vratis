//
//  MapView.h
//  Vratis
//
//  Created by Daniel Budynski on 22/11/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "MapViewDataSource.h"

@interface MapView : UIView
@property (strong, nonatomic) MapViewDataSource *mapSource;

@end
