//
//  Country+CoreDataProperties.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Country.h"

NS_ASSUME_NONNULL_BEGIN

@interface Country (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *country_id;
@property (nullable, nonatomic, retain) NSString *country_slug;
@property (nullable, nonatomic, retain) NSString *country_name;

@end

NS_ASSUME_NONNULL_END
