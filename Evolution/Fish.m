//
//  Fish.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "Fish.h"
#import "GameConfig.h"

@implementation Fish

- (void) setUp
{
    [self setPosition:ccp((arc4random()%(int)WIDTH) - WIDTH
                       , arc4random()%(int)(HEIGHT * 0.35))];
    self.speed = 100 + ((float)(arc4random()%100));
    self.fresh = YES;
}



- (void) fireFish:(float) power
{
    self.fresh = NO;
    
    float animationTime = 1.0;
    
    float amount = power * 300;
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(self.position.x, self.position.y + amount);
    bezier.controlPoint_2 = ccp(self.position.x + animationTime * self.speed, self.position.y + amount);
    bezier.endPosition = ccp(self.position.x + animationTime * self.speed, self.position.y + amount - 50);
    CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:animationTime bezier:bezier];
    
    CCCallFunc *landFunct = [CCCallFunc actionWithTarget:self selector:@selector(land)];
    
    [self runAction:[CCSequence actionOne:bezierAction
                                      two:landFunct]];
}

- (void) land
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fishDidLand:)])
    {
        [self.delegate fishDidLand:self];
    }
    else
    {
        [self setUp];
    }
}
@end
