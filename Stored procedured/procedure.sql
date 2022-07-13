DROP PROCEDURE IF EXISTS getPostsByCategory;
 
DELIMITER $$
 
CREATE PROCEDURE getPostsByCategory(
   )
BEGIN
   
	select  * from film;
END $$
DELIMITER ;

CALL getPostsByCategory
 