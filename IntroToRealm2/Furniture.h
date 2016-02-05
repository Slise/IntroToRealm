//
//  Furniture.h
//  IntroToRealm2
//
//  Created by Benson Huynh on 2016-02-05.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Realm/Realm.h>
@class Room;

@interface Furniture : RLMObject

@property NSString* name;
@property Room *room;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Furniture>
RLM_ARRAY_TYPE(Furniture)
