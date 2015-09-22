//
//  Address+CoreDataProperties.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 22/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *addressType;
@property (nullable, nonatomic, retain) NSNumber *cityId;
@property (nullable, nonatomic, retain) NSString *cityName;
@property (nullable, nonatomic, retain) NSNumber *countryId;
@property (nullable, nonatomic, retain) NSString *countryName;
@property (nullable, nonatomic, retain) NSString *houesNo;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSNumber *stateId;
@property (nullable, nonatomic, retain) NSString *stateName;

@end

NS_ASSUME_NONNULL_END
