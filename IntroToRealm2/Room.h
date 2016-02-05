//
//  Room.h
//  IntroToRealm2
//
//  Created by Benson Huynh on 2016-02-05.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Realm/Realm.h>

@interface Room : RLMObject
<# Add properties here to define the model #>
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Room>
RLM_ARRAY_TYPE(Room)
