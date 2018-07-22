CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name, b.size FROM dogs AS a, sizes AS b
         WHERE a.height > b.min and a.height <= b.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT a.child FROM parents AS a, dogs AS b
         WHERE a.parent = b.name ORDER BY -b.height;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.parent AS parent, a.child AS child, size AS child_size
         FROM parents AS a
         INNER JOIN size_of_dogs as b ON a.child = b.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT a.child || ' and ' || b.child || ' are ' || a.child_size || ' siblings'
         FROM siblings AS a, siblings AS b
         WHERE a.parent = b.parent AND a.child < b.child AND a.child_size = b.child_size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper(dogs, stack_height, last_height) 
            SELECT name, height, height FROM dogs
            ORDER BY height;
INSERT INTO stacks_helper(dogs, stack_height, last_height) 
            SELECT a.dogs || ', ' || b.dogs, a.last_height + b.last_height, b.last_height FROM stacks_helper AS a, stacks_helper AS b
            WHERE a.dogs <> b.dogs AND a.last_height < b.last_height
            ORDER BY a.last_height + b.last_height;
INSERT INTO stacks_helper(dogs, stack_height, last_height)
            SELECT a.dogs || ', ' || b.dogs, a.stack_height + b.last_height, b.last_height FROM stacks_helper AS a, stacks_helper AS b
            WHERE a.dogs <> b.dogs AND a.last_height < b.last_height AND b.last_height = b.stack_height AND a.stack_height <> a.last_height
            ORDER BY a.stack_height + b.last_height;
INSERT INTO stacks_helper(dogs, stack_height, last_height)
            SELECT a.dogs || ', ' || b.dogs, a.stack_height + b.last_height, b.last_height FROM stacks_helper AS a, stacks_helper AS b
            WHERE a.dogs <> b.dogs AND a.last_height < b.last_height AND b.last_height = b.stack_height AND a.stack_height <> a.last_height
                  AND a.stack_height > 99
            ORDER BY a.stack_height + b.last_height;

CREATE TABLE stacks AS
  SELECT dogs, stack_height FROM stacks_helper
  WHERE stack_height > 170;
