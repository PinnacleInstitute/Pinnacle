INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 99, 1, 7 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 1, 2, 1 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 1, 3, 2 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 1, 4, 3 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 1, 5, 4 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 1, 6, 5 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 3, 7, 7 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 3, 8, 8 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 5, 9, 7 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 9, 10, 1 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 9, 11, 2 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 9, 12, 3 )
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 0, 12, 13, 1 )

DECLARE @Result int 
EXEC pts_Downline_Build 1, 99, 1, @Result 
EXEC pts_Downline_Build 1, 1, 2, @Result 
EXEC pts_Downline_Build 1, 1, 3, @Result 
EXEC pts_Downline_Build 1, 1, 4, @Result 
EXEC pts_Downline_Build 1, 1, 5, @Result 
EXEC pts_Downline_Build 1, 1, 6, @Result 
EXEC pts_Downline_Build 1, 3, 7, @Result 
EXEC pts_Downline_Build 1, 3, 8, @Result 
EXEC pts_Downline_Build 1, 5, 9, @Result 
EXEC pts_Downline_Build 1, 9, 10, @Result 
EXEC pts_Downline_Build 1, 9, 11, @Result 
EXEC pts_Downline_Build 1, 9, 12, @Result 
EXEC pts_Downline_Build 1, 12, 13, @Result 


EXEC pts_Downline_Build_1_3 1, 99, 1, 2
EXEC pts_Downline_Build_1_3 1, 1, 2, 2
EXEC pts_Downline_Build_1_3 1, 1, 3, 2
EXEC pts_Downline_Build_1_3 1, 1, 4, 2
EXEC pts_Downline_Build_1_3 1, 1, 5, 2
EXEC pts_Downline_Build_1_3 1, 1, 6, 2
EXEC pts_Downline_Build_1_3 1, 3, 7, 2
EXEC pts_Downline_Build_1_3 1, 3, 8, 2
EXEC pts_Downline_Build_1_3 1, 5, 9, 2
EXEC pts_Downline_Build_1_3 1, 9, 10, 2
EXEC pts_Downline_Build_1_3 1, 9, 11, 2
EXEC pts_Downline_Build_1_3 1, 9, 12, 2
EXEC pts_Downline_Build_1_3 1, 12, 13, 2

--delete downline where downlineid >= 73
select * from downline where line in (3)















