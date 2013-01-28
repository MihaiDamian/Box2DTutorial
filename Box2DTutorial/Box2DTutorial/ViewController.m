//
//  ViewController.m
//  Box2DTutorial
//
//  Created by Mihai Damian on 1/26/13.
//  Copyright (c) 2013 Mihai Damian. All rights reserved.
//

#import "ViewController.h"
#import "World.h"

#import <QuartzCore/QuartzCore.h>


@interface ViewController ()
{
    World *_world;
}

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _world = [[World alloc] initWithView:self.view];
    
    [self generateCircles];
}

- (void)generateCircles
{
    CGSize viewSize = self.view.frame.size;
    CGFloat radius = 60;
    srand(time(NULL));
    for(int i = 0;i < 1;i++)
    {
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(rand() % (int)(viewSize.width - radius * 2) + radius,
                                                                      rand() % (int)(viewSize.height - radius * 2) + radius,
                                                                      radius, radius)];
        circleView.backgroundColor = [UIColor redColor];
        circleView.layer.cornerRadius = 30;
        [self.view addSubview:circleView];
        [_world addCircleWithView:circleView];
    }
}

@end
