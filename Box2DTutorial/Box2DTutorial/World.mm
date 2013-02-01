//
//  World.m
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/26/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import "World.h"
#import "UIView+Box2D.h"

#import <box2d/Box2D.h>
#import <QuartzCore/QuartzCore.h>


@implementation World
{
    b2World *_world;
    NSMutableArray *_circles;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self != nil)
    {
        b2Vec2 gravity(0.0f, 10.0f);
        _world = new b2World(gravity);
        _circles = [NSMutableArray array];
        
        [self createScreenBoundsForFrame:frame];
        [self setupAnimationLoop];
    }
    
    return self;
}

- (void)dealloc
{
    delete _world;
}

- (void)createScreenBoundsForFrame:(CGRect)frame
{
    b2BodyDef screenBoundsDef;
    screenBoundsDef.position.Set(0.0f, 0.0f);
    b2Body *screenBounds = _world->CreateBody(&screenBoundsDef);
    
    b2Vec2 worldEdges[5];
    
    worldEdges[0] = b2Vec2(CGPointTob2Vec2(frame.origin));
    worldEdges[1] = b2Vec2(CGPointTob2Vec2(CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame))));
    worldEdges[2] = b2Vec2(CGPointTob2Vec2(CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame))));
    worldEdges[3] = b2Vec2(CGPointTob2Vec2(CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame))));
    worldEdges[4] = b2Vec2(CGPointTob2Vec2(frame.origin));
    
    b2ChainShape worldShape;
    worldShape.CreateChain(worldEdges, 5);
    screenBounds->CreateFixture(&worldShape, 0.0f);
}

- (void)setupAnimationLoop
{
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationLoop:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)animationLoop:(CADisplayLink*)sender
{
    CFTimeInterval timeDelta = sender.duration * sender.frameInterval;
    
    int32 velocityIterations = 6;
    int32 positionIterations = 2;
    
    _world->Step(timeDelta, velocityIterations, positionIterations);
    
    // Adjust position for all views associated with circle bodies
    for(NSValue *circleWrapper in _circles)
    {
        b2Body *circle = (b2Body*)[circleWrapper pointerValue];
        UIView *view = (__bridge UIView*)circle->GetUserData();
        CGPoint center = b2Vec2ToCGPoint(circle->GetPosition());
        view.center = center;
    }
}

- (void)addCircleWithView:(UIView*)view
{
    NSAssert(view.superview != nil, @"The view parameter is not part of a view hierarchy");
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = CGPointTob2Vec2(view.center);
    b2Body *circle = _world->CreateBody(&bodyDef);

    b2CircleShape shape;
    shape.m_radius = PointsToMeters(view.frame.size.width / 2);

    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.3f;
    fixtureDef.restitution = 0.8f;

    circle->CreateFixture(&fixtureDef);
    // Associate the body with the passed in view
    circle->SetUserData((__bridge void*)view);
    
    [_circles addObject:[NSValue valueWithPointer:circle]];
}

@end
