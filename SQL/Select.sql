-- Few of rare SQL queries


-- Using UNION ALL and getting limit 1 asc and desc
SELECT CITY, LEN FROM 
    ( SELECT * ,LENGTH(CITY) LEN FROM STATION ORDER BY LEN DESC LIMIT 1 ) LONGEST
UNION ALL 
SELECT CITY, LEN FROM 
    ( SELECT * ,LENGTH(CITY) LEN FROM STATION ORDER BY LEN,CITY ASC LIMIT 1 ) SHORTEST


-- Regex Usage
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP '^[aeiouAEIOU]' ORDER BY CITY;
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT REGEXP '^[aeiouAEIOU]' ORDER BY CITY;
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP '^[^AEIOU].*[^aeiou]$'; -- do not start and end with vowels.

-- RIGHT()
SELECT Name FROM STUDENTS WHERE Marks > 75 ORDER BY RIGHT(Name, 3), ID ASC; -- here names ending with Aina and Amina will have sorted Aina,Amina.

-- Using WITH var as () 
WITH OCC AS (
    SELECT
        CONCAT(Name, '(', LEFT(Occupation, 1), ')') AS DESCRIPTION
    FROM
        OCCUPATIONS
),
OCC_COUNT AS (
    SELECT
        CONCAT(
            'There are a total of ',
            COUNT(*),
            ' ',
            LCASE(Occupation),
            's.'
        ) AS DESCRIPTION
    FROM
        OCCUPATIONS
    GROUP BY
        Occupation
)
SELECT
    DESCRIPTION
FROM
    OCC
UNION
ALL
SELECT
    DESCRIPTION
FROM
    OCC_COUNT
ORDER BY
    DESCRIPTION;


-- PARTITION BY
SELECT
    MAX(
        CASE
            WHEN OCCUPATION = 'Doctor' THEN NAME
            ELSE NULL
        END
    ) AS DOCTOR,
    MAX(
        CASE
            WHEN OCCUPATION = 'Professor' THEN NAME
            ELSE NULL
        END
    ) AS PROFESSOR,
    MAX(
        CASE
            WHEN OCCUPATION = 'Singer' THEN NAME
            ELSE NULL
        END
    ) AS SINGER,
    MAX(
        CASE
            WHEN OCCUPATION = 'Actor' THEN NAME
            ELSE NULL
        END
    ) AS ACTOR
FROM
    (
        SELECT
            NAME,
            OCCUPATION,
            ROW_NUMBER() OVER (
                PARTITION BY OCCUPATION
                ORDER BY
                    NAME
            ) AS OCC
        FROM
            OCCUPATIONS
    ) AS TEMP
GROUP BY
    OCC;

