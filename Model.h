//
//  Model.h
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (assign,nonatomic) NSUInteger currentScore;
@property (assign,nonatomic) NSUInteger currentPointsTotal;
@property (strong,nonatomic) NSDictionary *weightTable;
@property (assign, nonatomic) NSUInteger diceValue;
-(void)addPoints:(NSInteger) points;
-(void)resetAll;
-(int)randomDice;
@end
