//
//  UIView+Box2D.m
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/27/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import "UIView+Box2D.h"


static const CGFloat kPointsToMeterRatio = 32.0;


float32 PointsToMeters(CGFloat points)
{
    return points / kPointsToMeterRatio;
}

CGFloat MetersToPoints(float32 meters)
{
    return meters * kPointsToMeterRatio;
}

b2Vec2 CGPointTob2Vec2(CGPoint point)
{
    float32 x = PointsToMeters(point.x);
    float32 y = PointsToMeters(point.y);
    return b2Vec2(x, y);
}

CGPoint b2Vec2ToCGPoint(b2Vec2 vector)
{
    CGFloat x = MetersToPoints(vector.x);
    CGFloat y = MetersToPoints(vector.y);
    return CGPointMake(x, y);
}


@implementation UIView (Box2D)

@end
