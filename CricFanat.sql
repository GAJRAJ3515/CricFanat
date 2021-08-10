Use cricfanat;
select venue,team1,team2,player_of_match, winner,result_margin
from Stats
where team1 = 'Royal Challengers Bangalore' and team2 = 'Kolkata Knight Riders';
-- Most Number of victories 
select winner,count(winner)
from Stats
group by winner
order by 2 Desc;
-- Most number of victories at each venue
Select Venue, winner,count(winner)
from Stats
group by winner,venue
order by 3 Desc,1;

-- Playe of the Match by each venue
select player_of_match,venue, count(player_of_match) as max
from Stats
group by player_of_match,venue
order by max desc;
-- When a toss winner was not a match winner
select toss_winner,count(toss_winner) AS match_looser
from Stats
where toss_winner <> winner
group by toss_winner
order by 2 desc;
-- Decision After Winning the toss
Select toss_winner, toss_decision,count(toss_decision),count(toss_winner) 
from Stats
group by toss_winner,toss_decision
order by 1;
-- Decision after winning the toss at each venue
select venue,toss_decision,count(toss_decision) as Toss_decision
from stats
group by venue,toss_decision
order by 1;
-- Runs Scored by a batsman against every oppositon bowler
create view runs_against_bowler as
select batsman,bowler,sum(batsman_runs) 
from fanalysis
group by batsman,bowler
order by 3 Desc ,1,2;
-- Strike rate of a batsman against each bowler
Create view SR_against_bowlers as
select batsman,bowler,sum(batsman_runs) as runs_scored , count(ball) as bowls_bowled, (sum(batsman_runs)/count(ball)*100) as SR
from fanalysis
group by batsman,bowler
order by 3 Desc ,1,2;
select *
from SR_against_bowlers
where batsman like '%tanvir%';
create view Dismissed as
select batsman,bowler,sum(dis)
from dis
group by batsman,bowler
order by 3 DESC;
select * from Dismissed;
create view Fan_analysis as
select s.batsman, s.bowler,s.runs_scored,s.bowls_bowled, s.SR, d.dis
from SR_against_bowlers s
join Dismissed d
on (s.batsman = d.batsman and s.bowler= d.bowler);
select * 
from Fan_analysis
where batsman = 'V Kohli'
order by SR Desc;
Create view batsman_vs_bowler as
select batsman,bowler,sum(batsman_runs) as runs_scored , count(ball) as bowls_bowled, (sum(batsman_runs)/count(ball)*100) as SR, sum(is_wicket) as Dismissed
from fanalysis
where dismissal_kind not in ('NA ','run out')
group by batsman,bowler
order by 3 Desc ,1,2;
select * from batsman_vs_bowler;
select batsman,bowler,count(batsman_runs)
from fanalysis
where batsman like '%pant%' and batsman_runs = 6
group by batsman,bowler
order by 3 Desc;
-- Runs Scored by a batsman against every oppositon bowler and bowling_team
select batsman,bowler,bowling_team,sum(batsman_runs)
from fanalysis
group by batsman,bowler,bowling_team
order by 4 Desc ,1,2;
select count(*)
from fanalysis;
-- Most Runs Scored by a batsman for every team
select batsman,batting_team,sum(batsman_runs)
from fanalysis
group by batsman, batting_team
order by 3 Desc, 1,2;
-- How a batsman is dismissed by a bowler and how many times
create view dis as
select batsman,bowler,dismissal_kind,count(dismissal_kind) as dis
from fanalysis
where dismissal_kind not in ('NA','run out')
group by  batsman,bowler,dismissal_kind
order by 3 desc, 1,2;
select * from dis;
-- Most times a batsman is dismissed by a bowler
create view Dismissed as
select batsman,bowler,sum(dis)
from dis
group by batsman,bowler
order by 3 DESC;
select * from dismissed
where batsman like '%kohli%';
-- Most Runs Scored against each opposition
create view Runs as
select batsman ,bowling_team, sum(batsman_runs) as Total_runs 
from fanalysis
group by batsman , bowling_team
order by 3 Desc,1;
select batsman, bowling_team , Total_runs
from Runs
where batsman = 'KL Rahul' and bowling_team = 'Mumbai Indians';
-- Most wickets taken against each oppositon
select bowler, batting_team, sum(is_wicket) as Total_wickets
from fanalysis
group by bowler, batting_team
order by 3 Desc,1;
-- Run out counts
select batsman,non_striker,dismissal_kind,player_dismissed,fielder
from fanalysis
where dismissal_kind = 'run out';
select player_dismissed, count(player_dismissed)
from fanalysis
where dismissal_kind = 'run out'
group by player_dismissed
order by 2 desc;
-- Most number of wide balls bowled
select bowler,count(extras_type)
from fanalysis
where extras_type = 'wides'
group by bowler
order by 2 desc;
-- Most number of no balls bowled
select bowler,count(extras_type)
from fanalysis
where extras_type ='noballs'
group by bowler
order by 2 desc;

-- Most runs while batting first
select batsman, sum(batsman_runs)
from fanalysis
where inning = 1
group by batsman
order by 2 desc;
-- Most runs while chasing
select batsman, sum(batsman_runs)
from fanalysis
where inning = 2
group by batsman
order by 2 desc;
-- Congrats tp become a Fanalyst
