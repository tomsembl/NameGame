INSERT INTO public.mp3_order(
	number_stops, current_stop, number_starts, current_start)
	VALUES (13, 0, 18, 0);
	
	select * from mp3_order
	
	select * from answers
	
--get team totals
	select t.team_name, count(*) from answers a
	join teams t on a.team_id = t.team_id
	where success = 1
	and round = 1 --by round
	and a.game_id = 25
	group by t.team_name
	order by count(*) desc
-- get player totals
	select u.username, count(*) from answers a
	join user_instance u on a.user_inst_id = u.user_inst_id
	where success = 1
	and round = 1 --by round
	and a.game_id = 25
	group by u.username
	order by count(*) desc

	select user_inst_id, count(*) from answers
	where success = 1
	and round = 1 --by round
	group by user_inst_id
--get hardest names
	select name, count(*) from answers
	where success = 0
	group by name
	order by count(*) desc
	
	select count(*) from names where game_id = 30
	
