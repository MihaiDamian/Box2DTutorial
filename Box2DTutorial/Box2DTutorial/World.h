//
//  World.h
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/26/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface World : NSObject

- (id)initWithFrame:(CGRect)frame;

// Assumes view is already part of a view controller's view hierarchy
- (void)addCircleWithView:(UIView*)view;

@end
