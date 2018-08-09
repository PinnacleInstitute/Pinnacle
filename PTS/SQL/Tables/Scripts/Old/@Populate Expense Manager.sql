-- --------------------------------------- 
-- Create ExpenseType and TaxRate records
-- --------------------------------------- 
-- ExpType 1  = Standard Mileage
-- ExpType 11 = Actual Vehicle Cost (TaxType -1 = business use portion)
-- ExpType 2  = Meals
-- ExpType 3  = Travel
-- ExpType 4  = HomeOffice (TaxType -1 = business use portion)
-- ExpType 5  = Misc
-- --------------------------------------- 
-- TaxType 1 = Buiness Mileage
-- TaxType 2 = Charity Mileage
-- TaxType 3 = Medical/Moving Mileage
-- TaxType 4 = Business Meal 
-- TaxType 5 = 
-- TaxType 6 = 
-- TaxType 7 = 
-- TaxType 8 = 
-- TaxType 9 = 
-- TaxType 10 = 
-- --------------------------------------- 

INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 1, 1, 0, 'Business Mileage' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 2, 2, 0, 'Charity Mileage' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 3, 3, 0, 'Medical Mileage' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 4, 3, 0, 'Moving Mileage' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 5, 0, 0, 'Parking Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 6, 0, 0, 'Loan Interest' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 7, 0, 0, 'Toll Charge' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 8, 0, 0, 'Towing Charge' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1, 9, 0, 0, 'Vehicle Property Tax' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES ( 1,10, 0, 1, 'Other' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 1, 0, 0, 'Parking Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 2, -1, 0, 'Loan Interest' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 3, -1, 0, 'Vehicle Depreciation' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 4, 0, 0, 'Toll Charge' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 5, 0, 0, 'Towing Charge' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 6, -1, 0, 'Oil' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 7, -1, 0, 'Gas' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 8, -1, 0, 'Registration' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 9, -1, 0, 'Garage Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 10, -1, 0, 'Insurance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 11, -1, 0, 'License' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 12, -1, 0, 'Repairs' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 13, -1, 0, 'Maintenance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 14, -1, 0, 'Tires' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 15, -1, 0, 'Car Wash' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (11, 16, 0, 1, 'Other' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (2, 1, 4, 0, 'Business Meal' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (2, 2, 4, 0, 'Business Entertainment' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (2, 3, 0, 0, 'Food for Business Meeting' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (2, 4, 0, 1, 'Other' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 1, 0, 0, 'Air' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 2, 0, 0, 'Baggage & Shipping' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 3, 0, 0, 'Bus or Shuttle' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 4, 0, 0, 'Taxi' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 5, 0, 0, 'Limousine' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 6, 0, 0, 'Rental Car' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 7, 0, 0, 'Convention Cost' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 8, 0, 0, 'Hotel' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 9, 0, 0, 'Laundry Service' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 10, 0, 0, 'Meal' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 11, 0, 0, 'Telephone Call' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 12, 0, 0, 'Tip' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (3, 13, 0, 1, 'Other' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 1, -1, 0, 'Rent' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 2, -1, 0, 'Mortgage Interest' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 3, -1, 0, 'Depreciation' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 4, -1, 0, 'Real Estate Tax' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 5, -1, 0, 'Utilities' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 6, -1, 0, 'Insurance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 7, -1, 0, 'Communication' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 8, -1, 0, 'Security System' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 9, -1, 0, 'General Repair' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 10,-1, 0, 'General Maintenance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 11,-1, 0, 'General Improvement' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 20, 0, 0, 'Business Communication' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 21, 0, 0, 'Business Repair' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 22, 0, 0, 'Business Maintenance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 23, 0, 0, 'Business Improvement' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (4, 30, 0, 1, 'Other' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 1, 0, 0, 'Advertising/Marketing' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 2, 0, 0, 'Banking Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 3, 0, 0, 'Internet Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 4, 0, 0, 'Legal Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 5, 0, 0, 'Professional Service Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 6, 0, 0, 'Meeting/Seminar Fee' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 7, 0, 0, 'Office Expenses' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 8, 0, 0, 'Postage' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 9, 0, 0, 'Business Equipment - Rent/Lease' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 10, 0, 0, 'Business Equipment - Repair/Maintenance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 11, 0, 0, 'Supplies' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 12, 0, 0, 'Taxes' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 13, 0, 0, 'License' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 14, 0, 0, 'Medical Insurance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 15, 0, 0, 'Dental Insurance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 16, 0, 0, 'Long Term Care Insurance' )
INSERT INTO ExpenseType (ExpType, Seq, TaxType, IsRequired, ExpenseTypeName) VALUES (5, 17, 0, 1, 'Other' )

INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2009, 1, .55 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2009, 2, .14 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2009, 3, .24 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2009, 4, .50 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2010, 1, .55 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2010, 2, .14 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2010, 3, .24 )
INSERT INTO TaxRate (Year, TaxType, Rate ) VALUES ( 2010, 4, .50 )

