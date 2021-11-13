/*	-----------------------------------------------------------
	-----------------------------------------------------------
      BreezeCo Query Script
      Author: Tom Frisenda
      Created: 06/12/2019
	-----------------------------------------------------------
*/	-----------------------------------------------------------
PROMPT  Welcome
PROMPT  Query script is starting...

        SET WRAP ON
        
PROMPT  Starting 1.3.1 QUERY...
REM     1.3.1:
REM     Display the username, LastName, JoinDate and country Name for
REM     all users who joined after 13th january 2017. Order the output
REM     in ascending order of joinDate.

    SELECT "Username", "LastName", "JoinDate", "CountryName"
    FROM "BR_USER"
    LEFT JOIN "BR_COUNTRY"
    ON "BR_USER"."CountryId"="BR_COUNTRY"."CountryId"
    WHERE "JoinDate" >= '13-JAN-17'
    ORDER BY "JoinDate";

PROMPT  Finished 1.3.1 QUERY.
PROMPT  Starting 1.3.2 QUERY...

REM     1.3.2:
REM     Display the number of App Users for each App, by App name and App
REM     Category Name. Order by the total number of users in descending order
REM     (most popular at the top).

        SELECT  "AppName", "CategoryName", COUNT("BR_APPUSER"."AppUserId") AS "Downloads"
        FROM "BR_APP"
        LEFT JOIN "BR_APPCATEGORY"
        ON "BR_APP"."AppCategoryId"="BR_APPCATEGORY"."AppCategoryId"
        INNER JOIN "BR_APPUSER"
        ON "BR_APP"."AppId"="BR_APPUSER"."AppId" 
        GROUP BY "AppName", "CategoryName"
        ORDER BY "Downloads" DESC;
      

PROMPT  Finished 1.3.2 QUERY.
PROMPT  Starting 1.3.3 QUERY...

REM     1.3.3:
REM     Display all the Apps that are approved for release and the number of days
REM     since their last update (round down to one decimal place).

        SELECT "AppName", (ROUND(SYSDATE - "LastUpdated",1)) AS "DaySinceUpdate"
        FROM "BR_APP"
        WHERE "ApprovedForRelease" = 'Y';
        
PROMPT  Finished 1.3.3 QUERY.
PROMPT  Starting 1.3.4 QUERY...

REM     1.3.4:
REM     Display the Users who are above the age of 13 and have downloaded an
REM     app in the Category of “Social”. Order by date of birth in ascending order

        SELECT "Username", "DateOfBirth", "AppCategoryId"
        FROM "BR_USER"
        INNER JOIN "BR_APPUSER"
        ON "BR_USER"."UserId"="BR_APPUSER"."UserId"
        LEFT JOIN "BR_APP"
        ON "BR_APPUSER"."AppId"="BR_APP"."AppId"
        WHERE (months_between(sysdate,"DateOfBirth")/12) > 13
        AND "AppCategoryId" = '40'
        ORDER BY "DateOfBirth";
        
PROMPT  Finished 1.3.4 QUERY

PROMPT  Query script finished.
PROMPT  Have a great day!