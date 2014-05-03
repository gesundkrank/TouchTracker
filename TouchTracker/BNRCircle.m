//
//  BNRCircle.m
//  TouchTracker
//
//  Created by Jan Graßegger on 02.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import "BNRCircle.h"

@implementation BNRCircle

- (instancetype)initWithPoints:(NSArray *)points
{
    self = [super init];
    if (self) {
        _points = points;
    }
    
    return self;
}

@end
