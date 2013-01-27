//
//  ViewController.m
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/26/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import "ViewController.h"
#import "World.h"


@interface ViewController ()
{
    World *_world;
}

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _world = [World new];
}

@end
