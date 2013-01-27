//
//  World.m
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/26/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import "World.h"

#import <box2d/Box2D.h>
#import <QuartzCore/QuartzCore.h>


@implementation World
{
    b2World *_world;
    b2Body *_screenBounds;
    b2Body *_ball;
}

- (id)init
{
    self = [super init];
    if(self != nil)
    {
        b2Vec2 gravity(0.0f, -10.0f);
        _world = new b2World(gravity);
        
        [self createScreenBounds];
        [self createBall];
        [self setupAniamtionLoop];
    }
    
    return self;
}

- (void)dealloc
{
    delete _world;
}

- (void)createScreenBounds
{
    b2BodyDef screenBoundsDef;
    screenBoundsDef.position.Set(0.0f, 0.0f);
    _screenBounds = _world->CreateBody(&screenBoundsDef);
    
    b2Vec2 worldEdges[5];
    worldEdges[0].Set(0.0f, 0.0f);
    worldEdges[1].Set(0.0f, 10.0f);
    worldEdges[2].Set(10.0f, 10.0f);
    worldEdges[3].Set(10.0f, 0.0f);
    worldEdges[4].Set(0.0f, 0.0f);
    
    b2ChainShape worldShape;
    worldShape.CreateChain(worldEdges, 5);
    _screenBounds->CreateFixture(&worldShape, 0.0f);
}

- (void)createBall
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(5.0f, 5.0f);
    _ball = _world->CreateBody(&bodyDef);
    
    b2CircleShape shape;
    shape.m_radius = 1;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.3f;
    
    _ball->CreateFixture(&fixtureDef);
}

- (void)setupAniamtionLoop
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
    
    b2Vec2 position = _ball->GetPosition();
    float32 angle = _ball->GetAngle();
    NSLog(@"%4.2f %4.2f %4.2f\n", position.x, position.y, angle);
}

@end
