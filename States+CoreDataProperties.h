//
//  States+CoreDataProperties.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "States.h"

NS_ASSUME_NONNULL_BEGIN

@interface States (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *state_id;
@property (nullable, nonatomic, retain) NSString *state_slug;
@property (nullable, nonatomic, retain) NSString *state_name;

@end

NS_ASSUME_NONNULL_END
