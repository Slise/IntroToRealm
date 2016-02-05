//
//  Room.h
//  IntroToRealm2
//
//  Created by Benson Huynh on 2016-02-05.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Realm/Realm.h>
#import "Furniture.h"

@interface Room : RLMObject

@property NSString *name;
@property RLMArray<Furniture *><Furniture> *furniture;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Room>
RLM_ARRAY_TYPE(Room)
