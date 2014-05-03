//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Jan Graßegger on 01.05.14.
//  Copyright (c) 2014 Jan Graßegger. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "BNRPoint.h"
#import "BNRCircle.h"

@interface BNRDrawView ()

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedCircles;
@property (nonatomic, strong) NSMutableDictionary *circlePointsInProgress;

@end

@implementation BNRDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.circlePointsInProgress = [[NSMutableDictionary alloc] init];
        self.finishedCircles = [[NSMutableArray alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)strokeCircle:(BNRCircle *)circle
{
    NSLog(@"Stroking circle");
    [self strokeCircleWithPoints:circle.points];
}

- (void)strokeCircleWithPoints:(NSArray *)points
{
    BNRPoint *point0 = points[0];
    BNRPoint *point1 = points[1];
    CGRect rect = CGRectMake(point0.x, point0.y, point1.x - point0.x, point1.y - point0.y);
    UIBezierPath *bp = [UIBezierPath bezierPathWithOvalInRect:rect];
    bp.lineWidth = 10;
    
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    //Draw finished lines in black
    for (BNRLine *line in self.finishedLines) {
        [[[UIColor alloc] initWithHue:line.angle saturation:1 brightness:1 alpha:1] set];
        [self strokeLine:line];
    }
    
    [[UIColor greenColor] set];
    for (BNRCircle *circle in self.finishedCircles) {
        [self strokeCircle:circle];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    [[UIColor yellowColor] set];
    NSArray *points = [self.circlePointsInProgress allValues];
    if (points.count == 2) {
        NSLog(@"Drawing cirlce");
        [self strokeCircleWithPoints:points];
    }
 }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if (touches.count == 2) {
        NSLog(@"Circle starts");
        for (UITouch *t in touches) {
            BNRPoint *point = [[BNRPoint alloc] initWithPoint:[t locationInView:self]];
            
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            self.circlePointsInProgress[key] = point;
        }
    } else {
        for (UITouch *t in touches) {
            CGPoint location = [t locationInView:self];
        
            BNRLine *line = [[BNRLine alloc] init];
            line.begin = location;
            line.end = location;
        
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            self.linesInProgress[key] = line;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        if ([self.linesInProgress objectForKey:key]) {
            BNRLine *line = self.linesInProgress[key];
            
            line.end = [t locationInView:self];
        } else {
            self.circlePointsInProgress[key] = [[BNRPoint alloc] initWithPoint:[t locationInView:self]];
        }
             
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        if ([self.linesInProgress objectForKey:key]) {
            BNRLine *line = self.linesInProgress[key];
        
            [self.finishedLines addObject:line];
            [self.linesInProgress removeObjectForKey:key];
        } else {
            if (self.circlePointsInProgress.count == 2) {
                BNRCircle *circle = [[BNRCircle alloc] initWithPoints:self.circlePointsInProgress.allValues];
                [self.finishedCircles addObject:circle];
            }
            [self.circlePointsInProgress removeObjectForKey:key];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        if ([self.linesInProgress objectForKey:key]) {
            [self.linesInProgress removeObjectForKey:key];
        } else {
            [self.circlePointsInProgress removeObjectForKey:key];
        }
    }
    
    [self setNeedsDisplay];
}


@end
