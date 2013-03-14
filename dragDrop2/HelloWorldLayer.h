//
//  HelloWorldLayer.h
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "AppleSprite.h"
#import "Model.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite * background;
    AppleSprite * selSprite;
    NSMutableArray * movableSprites;
    CCSprite *basket;
    CCSprite *diceSprite;
    NSMutableArray *diceImages;
    CCLabelBMFont *scoreLabel;
    CCSprite *finishSign;
}

@property (strong, nonatomic) Model *model;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
