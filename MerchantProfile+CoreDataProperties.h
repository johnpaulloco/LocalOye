//
//  MerchantProfile+CoreDataProperties.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MerchantProfile.h"

NS_ASSUME_NONNULL_BEGIN

@interface MerchantProfile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *banner;
@property (nullable, nonatomic, retain) NSString *certifications;
@property (nullable, nonatomic, retain) NSString *descriptionStr;
@property (nullable, nonatomic, retain) NSString *merchant_name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *profile_pic;
@property (nullable, nonatomic, retain) NSString *quote_text;
@property (nullable, nonatomic, retain) NSString *rating;
@property (nullable, nonatomic, retain) NSString *downLoadLink;

@end

NS_ASSUME_NONNULL_END
