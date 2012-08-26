//
//  Water.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "Water.h"
#import "GameConfig.h"

@implementation Water

- (id) init
{
    self = [super init];
    if (self)
    {
        const CGFloat x = WIDTH / 2;
        const CGFloat y = 15;
        const CGFloat moveAmountX = 15.0;
        const CGFloat moveAmountY = 2;
        
        CCSprite *water = [CCSprite spriteWithFile:@"water.png"];
        water.position = ccp(x, y);
        
        [self addChild:water];
        CCAction *move = [CCRepeatForever actionWithAction:[CCSequence
                                                            actionOne:[CCMoveTo actionWithDuration:3.0 position:ccp(x + moveAmountX, y + moveAmountY)]
                                                            two:[CCMoveTo actionWithDuration:3.0 position:ccp(x - moveAmountX, y - moveAmountY)]]];
        [water runAction:move];
        
    }
    return self;
}
@end
