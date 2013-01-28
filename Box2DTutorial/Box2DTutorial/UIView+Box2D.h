//
//  UIView+Box2D.h
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/27/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <box2d/Box2D.h>


// All conversions take into account screen scale

float32 PointsToMeters(CGFloat points);
CGFloat MetersToPoints(float32 meters);

b2Vec2 CGPointTob2Vec2(CGPoint point);
CGPoint b2Vec2ToCGPoint(b2Vec2 vector);


@interface UIView (Box2D)

@end
