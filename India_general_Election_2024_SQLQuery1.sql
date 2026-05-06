use india_election_result;
SELECT * FROM dbo.states;
select * FROM dbo.constituencywise_details;
select * FROM dbo.statewise_results;
select * FROM dbo.constituencywise_results;
select * FROM dbo.partywise_results;

-- ============================================
-- INDIA GENERAL ELECTION RESULT ANALYSIS 2024
-- ============================================



-- 1. TOTAL NUMBER OF SEATS

SELECT 
    COUNT(DISTINCT Parliament_Constituency) AS Total_Seats
FROM constituencywise_results;




-- 2. TOTAL SEATS AVAILABLE IN EACH STATE


SELECT
    s.State AS State_Name,
    COUNT(cr.Constituency_ID) AS Total_Seats_Available
FROM constituencywise_results cr
JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s
    ON sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY s.State;



-- ============================================
-- 3. TOTAL SEATS WON BY NDA ALLIANCE
-- ============================================

SELECT
    SUM(
        CASE
            WHEN party IN (
                'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM'
            )
            THEN Won
            ELSE 0
        END
    ) AS NDA_Total_Seats_Won
FROM partywise_results;




-- 4. NDA PARTY WISE SEATS


SELECT
    Party AS Party_Name,
    Won AS Seats_Won
FROM partywise_results
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
)
ORDER BY Seats_Won DESC;



-- ============================================
-- 5. TOTAL SEATS WON BY I.N.D.I.A ALLIANCE
-- ============================================

SELECT
    SUM(
        CASE
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            )
            THEN Won
            ELSE 0
        END
    ) AS INDIA_Total_Seats_Won
FROM partywise_results;



-- ============================================
-- 6. INDIA ALLIANCE PARTY WISE SEATS
-- ============================================

SELECT
    Party AS Party_Name,
    Won AS Seats_Won
FROM partywise_results
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
)
ORDER BY Seats_Won DESC;



-- ============================================
-- 7. ADD PARTY ALLIANCE COLUMN
-- ============================================

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);



-- ============================================
-- 8. UPDATE INDIA ALLIANCE
-- ============================================

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);



-- ============================================
-- 9. UPDATE NDA ALLIANCE
-- ============================================

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);



-- ============================================
-- 10. UPDATE OTHER ALLIANCE
-- ============================================

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;



-- ============================================
-- 11. WHICH ALLIANCE WON MOST SEATS
-- ============================================

SELECT
    p.party_alliance,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results p
    ON cr.Party_ID = p.Party_ID
GROUP BY p.party_alliance
ORDER BY Seats_Won DESC;



-- ============================================
-- 12. WINNING CANDIDATE DETAILS
-- ============================================

SELECT
    cr.Winning_Candidate,
    p.Party,
    p.party_alliance,
    cr.Total_Votes,
    cr.Margin,
    cr.Constituency_Name,
    s.State
FROM constituencywise_results cr
JOIN partywise_results p
    ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s
    ON sr.State_ID = s.State_ID
WHERE s.State = 'Uttar Pradesh'
AND cr.Constituency_Name = 'AMETHI';



-- ============================================
-- 13. EVM VS POSTAL VOTES
-- ============================================

SELECT
    cd.Candidate,
    cd.Party,
    cd.EVM_Votes,
    cd.Postal_Votes,
    cd.Total_Votes,
    cr.Constituency_Name
FROM constituencywise_details cd
JOIN constituencywise_results cr
    ON cd.Constituency_ID = cr.Constituency_ID
WHERE cr.Constituency_Name = 'MATHURA'
ORDER BY cd.Total_Votes DESC;



-- ============================================
-- 14. PARTY WISE SEATS IN A STATE
-- ============================================

SELECT
    p.Party,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results p
    ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s
    ON sr.State_ID = s.State_ID
WHERE s.State = 'Bihar'
GROUP BY p.Party
ORDER BY Seats_Won DESC;



-- ============================================
-- 15. ALLIANCE WISE SEATS IN EACH STATE
-- ============================================

SELECT
    s.State AS State_Name,

    SUM(
        CASE
            WHEN p.party_alliance = 'NDA'
            THEN 1
            ELSE 0
        END
    ) AS NDA_Seats_Won,

    SUM(
        CASE
            WHEN p.party_alliance = 'I.N.D.I.A'
            THEN 1
            ELSE 0
        END
    ) AS INDIA_Seats_Won,

    SUM(
        CASE
            WHEN p.party_alliance = 'OTHER'
            THEN 1
            ELSE 0
        END
    ) AS OTHER_Seats_Won

FROM constituencywise_results cr

JOIN partywise_results p
    ON cr.Party_ID = p.Party_ID

JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency

JOIN states s
    ON sr.State_ID = s.State_ID

GROUP BY s.State
ORDER BY s.State;



-- ============================================
-- 16. TOP 10 HIGHEST EVM VOTES
-- ============================================

SELECT TOP 10
    cr.Constituency_Name,
    cd.Candidate,
    cd.EVM_Votes
FROM constituencywise_details cd
JOIN constituencywise_results cr
    ON cd.Constituency_ID = cr.Constituency_ID
ORDER BY cd.EVM_Votes DESC;



-- ============================================
-- 17. WINNER & RUNNER-UP OF EACH CONSTITUENCY
-- ============================================

WITH RankedCandidates AS
(
    SELECT
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,

        (cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,

        ROW_NUMBER() OVER
        (
            PARTITION BY cd.Constituency_ID
            ORDER BY (cd.EVM_Votes + cd.Postal_Votes) DESC
        ) AS VoteRank

    FROM constituencywise_details cd

    JOIN constituencywise_results cr
        ON cd.Constituency_ID = cr.Constituency_ID

    JOIN statewise_results sr
        ON cr.Parliament_Constituency = sr.Parliament_Constituency

    JOIN states s
        ON sr.State_ID = s.State_ID

    WHERE s.State = 'Maharashtra'
)

SELECT
    cr.Constituency_Name,

    MAX(
        CASE
            WHEN rc.VoteRank = 1
            THEN rc.Candidate
        END
    ) AS Winning_Candidate,

    MAX(
        CASE
            WHEN rc.VoteRank = 2
            THEN rc.Candidate
        END
    ) AS Runner_Up_Candidate

FROM RankedCandidates rc

JOIN constituencywise_results cr
    ON rc.Constituency_ID = cr.Constituency_ID

GROUP BY cr.Constituency_Name
ORDER BY cr.Constituency_Name;



-- ============================================
-- 18. MAHARASHTRA ELECTION SUMMARY
-- ============================================

SELECT
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,

    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,

    COUNT(DISTINCT p.Party) AS Total_Parties,

    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,

    SUM(cd.EVM_Votes) AS Total_EVM_Votes,

    SUM(cd.Postal_Votes) AS Total_Postal_Votes

FROM constituencywise_results cr

JOIN constituencywise_details cd
    ON cr.Constituency_ID = cd.Constituency_ID

JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency

JOIN states s
    ON sr.State_ID = s.State_ID

JOIN partywise_results p
    ON cr.Party_ID = p.Party_ID

WHERE s.State = 'Maharashtra';



-- ============================================
-- 19. TOP 5 HIGHEST WINNING MARGIN
-- ============================================

SELECT TOP 5
    Winning_Candidate,
    Constituency_Name,
    Margin,
    Total_Votes
FROM constituencywise_results
ORDER BY Margin DESC;



-- ============================================
-- 20. TOP 10 CLOSEST ELECTIONS
-- ============================================

SELECT TOP 10
    Winning_Candidate,
    Constituency_Name,
    Margin
FROM constituencywise_results
ORDER BY Margin ASC;



-- ============================================
-- 21. STATE WITH HIGHEST TOTAL VOTES
-- ============================================

SELECT TOP 1
    s.State,
    SUM(cd.Total_Votes) AS Total_Votes
FROM constituencywise_details cd

JOIN constituencywise_results cr
    ON cd.Constituency_ID = cr.Constituency_ID

JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency

JOIN states s
    ON sr.State_ID = s.State_ID

GROUP BY s.State
ORDER BY Total_Votes DESC;



-- ============================================
-- 22. BJP PERFORMANCE STATE WISE
-- ============================================

SELECT
    s.State,
    COUNT(*) AS Seats_Won
FROM constituencywise_results cr

JOIN partywise_results p
    ON cr.Party_ID = p.Party_ID

JOIN statewise_results sr
    ON cr.Parliament_Constituency = sr.Parliament_Constituency

JOIN states s
    ON sr.State_ID = s.State_ID

WHERE p.Party = 'Bharatiya Janata Party - BJP'

GROUP BY s.State
ORDER BY Seats_Won DESC;