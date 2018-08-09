--SET IDENTITY_INSERT to ON.
SET	IDENTITY_INSERT Business ON

--Add the default sysadmin record
INSERT INTO	Business
 				(
	    BusinessID ,
            BusinessName ,
            SystemEmail ,
            CustomerEmail ,
            Street ,
            Unit ,
            City ,
            State ,
            Zip ,
            Country ,
            Phone ,
            Fax ,
            WebSite ,
            TaxRate 
 				)
VALUES
 				(
				1 ,
            'Pinnacle Institute' ,
            'bob@pinnaclep.com' ,
            'bob@pinnaclep.com' ,
            '' ,
            '' ,
            '' ,
            '' ,
            '' ,
            '' ,
            '' ,
            '' ,
            '' ,
            0 
 				)

SET IDENTITY_INSERT Business OFF
GO