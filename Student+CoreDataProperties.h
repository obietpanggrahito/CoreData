//
//  Student+CoreDataProperties.h
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 29/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

NS_ASSUME_NONNULL_END
