//
//  GameLayer.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "GameLayer.h"
#import "Fish.h"

@interface GameLayer()
@property (nonatomic, retain) NSMutableArray *fishes;

@end

CGFloat WIDTH, HEIGHT;

@implementation GameLayer

+ (CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
    self = [super init];
	if (self)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        WIDTH = winSize.width;
        HEIGHT = winSize.height;
        
        [self schedule:@selector(update:)];
        
        CCLayerColor *layerColour = [CCLayerColor layerWithColor:ccc4(0, 96, 128, 255)];
        [self addChild:layerColour];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Evolution" fontName:@"Helvetica" fontSize:17];
		title.position = ccp(winSize.width /2 , winSize.height - 70.0);
        title.color = (ccColor3B){255, 255, 255};
		[self addChild: title];
        
        
        self.fishes = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i < 10; ++i)
        {
            [self makeAFish];
        }
        
    }
    return self;
}

- (void) update:(ccTime) deltaTime
{
    for (Fish *f in self.fishes)
    {
        CGFloat addTo = deltaTime * f.speed;
        if (f.position.x + addTo >= WIDTH + f.textureRect.size.width)
        {
            [f setPosition:ccp(- f.textureRect.size.width + addTo, f.position.y)];
        }
        else
        {
            [f setPosition:ccp(f.position.x + addTo, f.position.y)];
        }
    }
}

- (void) makeAFish
{
    Fish *f = [Fish spriteWithFile:@"fish.png"];

    [f setPosition:ccp((arc4random()%(int)WIDTH) - WIDTH
                          , arc4random()%((int)HEIGHT / 2))];
    f.speed = 100 + ((float)(arc4random()%100));
    [self addChild:f];
    
    [self.fishes addObject:f];
}

- (void) dealloc
{
    [_fishes release];
    [super dealloc];
}

@end
