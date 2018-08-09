--select * from course where courseid=72
--select * from lesson where lessonid=157

declare @ID int, @LID int
DECLARE @Now datetime
SET     @Now = GETDATE()

--   CourseID, CourseCategoryID, TrainerID, CourseName, Status, CourseType, CourseLevel,
--   @Description,
--   @Language,CourseLength,CourseDate,IsPaid,Price,PassingGrade,Rating,Video,Audio,Quiz,UserID

-- LessonID,CourseID,LessonName,Description,Status,LessonLength,Seq
-- MediaURL,MediaType,MediaLength,MediaWidth,MediaHeight,Content,HasQuiz,QuizLength,PassingGrade,QuizWeight,UserID

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Teamwork', 3, 3, 3, 
   'Mark V Hansen - Chicken Soup Co Founder –Fortune Trainers advanced TEAM WORK LESSON – ideal for public schools and corporate projectors',
   'English', 96, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 96, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1001hi.rm', 1, 99, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'IBI Niche Marketing', 3, 3, 3, 
   'Charles Whitlock - Leading Fortune Trainer – TV STAR – and Author – lesson – ideal class room board room content',
   'English', 89, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 89, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1002hi.rm', 1, 89, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Self Esteem', 3, 3, 3, 
   'Jack Canfield  - Board Room – class room – master lesson on Self Esteem',
   'English', 102, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 102, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1003hi.rm', 1, 102, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Accountability', 3, 3, 3, 
   'Larry Ransom - Micro Soft – Hallmark Card – plus many more – on topic of management accountability – a big screen projector lesson plan for the class room',
   'English', 83, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 83, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1004hi.rm', 1, 83, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Promotion/Motion of Success', 3, 3, 3, 
   'Tom Justin - Larry King TV’s friend and Fortune Trainer on PROMOTION to build product success in the market -',
   'English', 114, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 114, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1005hi.rm', 1, 114, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Creativity Unlimited', 3, 3, 3, 
   'Marilyn Schoeman Dow - Uncorked creativity for corporate training and class room viewing – great for individual thinking',
   'English', 86, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 86, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1006hi.rm', 1, 86, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Super Teaching', 3, 3, 3, 
   'William Skilling - Short on Super Teaching Theory for public schools – technology that elevates test scores and comprehension – see.www.superteaching.org.',
   'English', 8, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 8, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1007hi.rm', 1, 8, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'IBI Marketing', 3, 3, 3, 
   'Joan Gustafson - Retired 3M Marketing Executive – author A WOMAN CAN DO THAT and SOME WOMAN ARE BORN LEADERS – master lesson on marketing – ideal for class room and corporate training projectors',
   'English', 89, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 89, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1008hi.rm', 1, 89, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Advertise', 3, 3, 3, 
   'Mark V Hansen - Chicken Soup Co Founders advanced lesson on Advertising and marketing – ideal for public schools and corporate big screens',
   'English', 73, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 73, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1009hi.rm', 1, 73, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Team Steam', 3, 3, 3, 
   'David Stanley - Elvis’s Step Brother – Fortune Training on Motivation as a Mind Set',
   'English', 81, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 81, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1010hi.rm', 1, 81, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Teamwork II', 3, 3, 3, 
   'Mark V Hansen - Advanced Team Building lesson plan – for public schools and corporate projectors by Fortune Trainer – Chicken Soup Co Founder',
   'English', 96, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 96, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1011hi.rm', 1, 96, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Shareholder Value', 3, 3, 3, 
   'Kevin Dewitt - Principles of converting ideas into shareholder value propositions',
   'English', 99999, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 112, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1013hi.rm', 1, 112, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Manufacturing Process', 3, 3, 3, 
   'Ralph Thompson - Process Manufacturer on the options and thinking for manufacturing – ideal public school lesson plan ideal – for corp training',
   'English', 87, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 87, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1014hi.rm', 1, 87, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'IBI Cooperation is a Language', 3, 3, 3, 
   'John Gray - Men are From Mars – Women Are From Venus – Fortune Trainer – ideal class room and board room lesson plan',
   'English', 109, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 109, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1015hi.rm', 1, 109, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Wealth Esteem', 3, 3, 3, 
   'Lisa Nichols - Chicken Soup for the African American Soul ( Fall 2004 ) planners – Mind Set lesson for success',
   'English', 110, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 110, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1016hi.rm', 1, 110, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Super Achiever Mindset', 3, 3, 3, 
   'Lee Pulos - Professor Emeritus University of British Columbia – best selling author – Fortune & Celebrity Athlete Performance Trainer  - secret knowledge lesson plan for pubic schools and corporate training',
   'English', 73, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 73, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1017hi.rm', 1, 73, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Process Technology', 3, 3, 3, 
   'Kim Auten - Celebrity Trainer – coach – on setting up core process to track and develop any idea into a COMPLETION',
   'English', 103, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 103, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1018hi.rm', 1, 103, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Team is from Venus, You are from Mars', 3, 3, 3, 
   'John Gray - Ideal Board room and Class room lesson plan for team communication dynamics – buy Men are From Mars Woman are From Venus In the Work Place – by John Gray',
   'English', 106, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 106, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1019hi.rm', 1, 106, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Capital- Theory & Practice', 3, 3, 3, 
   'Tony Dohrmann - Capital tips on raising capital ( void where prohibited by law ) – attorney advice required',
   'English', 89, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 89, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1020hi.rm', 1, 89, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Boffo your Creativity', 3, 3, 3, 
   'Marilyn Schoeman Dow - SUPER CREATIVITY thinking from Fortune Trainer and expert creativity trainer',
   'English', 85, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 85, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1021hi.rm', 1, 85, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Transformations', 3, 3, 3, 
   'Barry Spilchuk - Personal Growth Class – best taken in small groups – huge inside class on dealing with self issues – big screen weekend game for couples to play together -',
   'English', 107, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 107, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1022hi.rm', 1, 107, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Let Go of Success Blocks in Any Form', 3, 3, 3, 
   'Jim Britt - Author Rings of Truth – Fortune Trainer – release blocks – master adult lesson plan',
   'English', 82, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 82, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1023hi.rm', 1, 82, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Net worth - The Vision of Self Esteem', 3, 3, 3, 
   'Jack Canfield  - Exercises to raise your or your teams self esteem in business',
   'English', 84, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 84, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1024hi.rm', 1, 84, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Imaging Success', 3, 3, 3, 
   'Susie Fields - First impressions matter – and more – super entertaining lesson plan',
   'English', 120, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 120, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1025hi.rm', 1, 120, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Legal Compliance & Capital', 3, 3, 3, 
   'Jim Burk - Capital Compliance lesson ( void where prohibited by law )attorney advice required',
   'English', 85, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 85, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1026hi.rm', 1, 85, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Switched on Teams', 3, 3, 3, 
   'Jerry Teplitz - Advanced team development lessons – Muscle Testing – ideal with two or more viewing',
   'English', 83, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 83, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1027hi.rm', 1, 83, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Teamwork, Sequence & Delegation', 3, 3, 3, 
   'Gary Gilbertson - Merger and Acquisition specialist – discusses core skills in sequence and delegation',
   'English', 85, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 85, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1028hi.rm', 1, 85, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Capital Theories', 3, 3, 3, 
   'Mellow Honek - Power Lesson on Capital Formation – by corporate trainer – ideal for public schools – ( void where prohibited by law) attorney advice required',
   'English', 88, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 88, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1029hi.rm', 1, 88, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Marketing Fast track', 3, 3, 3, 
   'Fred Gleeck - Fortune Trainer on Marketing Mind Sets – Best selling author',
   'English', 70, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 70, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1030hi.rm', 1, 70, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Strategy & Business Numbers', 3, 3, 3, 
   'Bob Mangum - Class room and board room lesson on biz planning and sequence',
   'English', 70, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 70, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1031hi.rm', 1, 70, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Success Teams: Accelerated Performance', 3, 3, 3, 
   'Kent Maerki - Entertaining hard content lesson from Fortune consultant – and Corporate trainer',
   'English', 68, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 68, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1032hi.rm', 1, 68, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Creating the Right Team', 3, 3, 3, 
   'BJ Dohrmann - Three to five of the right team members – and success always follows – applies to all agenda topics',
   'English', 105, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 105, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1033hi.rm', 1, 105, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Branding Strategies', 3, 3, 3, 
   'Howard Lim - Leading branding contractor for Disney – HP – and more – teaches branding as a way of thinking – ideal for the class room',
   'English', 75, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 75, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1034hi.rm', 1, 75, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Building success Relationships', 3, 3, 3, 
   'Maria Simone - Co Founder CITY SCARVES – on building success relationships',
   'English', 94, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 94, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1035hi.rm', 1, 94, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Your Money Relationships', 3, 3, 3, 
   'Lisa Nichols - Align your belief’s with your Money Reality – Lisa Nichols founder Motivating the Teen Spirit –Best Selling Author Chicken Soup for the African American Soul ( Fall 2004 )',
   'English', 53, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 53, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1036hi.rm', 1, 53, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Mutliple Income THINKING', 3, 3, 3, 
   'Mark V Hansen - Mutliple Income THINKING lesson plan – written by IBI for Chicken Soup CO Founder – important even vital pubic school lesson plan – anyone seeking the secret knoweledge',
   'English', 117, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 117, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1037hi.rm', 1, 117, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Capital & Dream Making', 3, 3, 3, 
   'Linda Chandler - Fortune Trainer on Capital Planners in today’s market',
   'English', 74, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 74, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1038hi.rm', 1, 74, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Now & Forever', 3, 3, 3, 
   'David Rose - Keeping IBI SUCCESS CHANNEL thinking in your life – forever -',
   'English', 70, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 70, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1039hi.rm', 1, 70, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Stimulating the Success', 3, 3, 3, 
   'Tom Justin - Fortune Trainer and best selling author on stimulating the success',
   'English', 83, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 83, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1041hi.rm', 1, 83, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Speed Wealth', 3, 3, 3, 
   'T. Harv Eker - EXCLUSIVE – best selling author seminar producer – class room and board room lesson plan on SPEED WEALTH – you’ll never change the channel on this one',
   'English', 92, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 92, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1042hi.rm', 1, 92, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Systems, Systems, Systems', 3, 3, 3, 
   'Susie Fields - Master Adult Skill lesson on systems – ideal for every corporate big screen -',
   'English', 97, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 97, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1043hi.rm', 1, 97, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Liberating your Magnificence', 3, 3, 3, 
   'Scott & Shannon Peck - A leading self esteem training for class room or board room – amazing lesson plan',
   'English', 80, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 80, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1044hi.rm', 1, 80, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'IBI Communication', 3, 3, 3, 
   'Wally Minto - EXCLUSIVE – big screen this lesson for public schools and corporate training – change your entire frame work for relationship communication – success follows immediately',
   'English', 79, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 79, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1045hi.rm', 1, 79, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Let Go and Succeed', 3, 3, 3, 
   'Jim Britt - Advanced lesson on releasing blocks – stop other work and turn down the lights and light a candle or two',
   'English', 107, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 107, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1046hi.rm', 1, 107, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'One Page Deal Making/Business Planning 1, 2, 3', 3, 3, 3, 
   'Barry Spilchuk/Mitch Santell - If agreements are NOT in writing there is no agreement at all',
   'English', 98, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 98, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1048hi.rm', 1, 98, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Fear Lesson', 3, 3, 3, 
   'BJ Dohrmann - Fear – stops success – learn how to manage fear vs. be managed BY fear –',
   'English', 92, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 92, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1049hi.rm', 1, 92, 0, 0, 0, 0, 0, 70, 0, 1

EXEC pts_Course_Add @ID OUTPUT, 0, 120, 'Cooperation / WOW Planning 1,2,3', 3, 3, 3, 
   'Tom Justin/Barry Spilchuk - TWO FORTUNE TRAINERS in the same lesson – converting raw ideas into actual results',
   'English', 115, @Now, 1, 0, 70, 6, 1, 0, 0, 1 
EXEC pts_Lesson_Add @LID OUTPUT, @ID, 'Video Presentation', '', 2, 115, 1, 
	'rtsp://www.ibiglobal.com/RTSP/pti/1050hi.rm', 1, 115, 0, 0, 0, 0, 0, 70, 0, 1


