//
//  Model.m
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//
//

#import "Model.h"

@implementation Model
@synthesize currentPointsTotal = _currentPointsTotal;
@synthesize currentScore = _currentScore;


-(void)addPoints:(NSInteger)points
{
    self.currentPointsTotal+=points;
}

-(void)resetAll
{
    self.currentPointsTotal = 0;
    self.currentScore = 0;
}

-(int)randomDice
{
    int index = (arc4random() % 6);
    return index;
}

@end
