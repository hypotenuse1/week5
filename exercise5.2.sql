#1
select *
from users inner join tickets on tickets.user = users.id
where train=11
order by seat_number;

#2
select users.id, name, count(*) as trains_count, sum(distance)/10 as total_distance
from users 
	inner join tickets on tickets.user= users.id 
	inner join trains on trains.id = tickets.train
group by users.id
order by total_distance desc
limit 6;

#3
select trains.id, types.name, s.name as src_stn, d.name as dst_stn, timediff(arrival,departure) as travel_time
from trains
	inner join types on trains.type = types.id
    inner join stations as s on trains.source = s.id 
	inner join stations as d on trains.destination = d.id
order by travel_time desc
limit 6;

#4
select types.name, s.name as src_stn, d.name as dst_stn, departure, arrival, 
	round(fare_rate*distance/100, -2) as fare
from trains
	inner join types on trains.type = types.id
    inner join stations as s on trains.source = s.id 
	inner join stations as d on trains.destination = d.id
order by departure;

#5
select types.name, s.name as src_stn, d.name as dst_stn, 
	   count(*) as occupied, max_seats as maximum
from trains
	inner join types on trains.type = types.id
    inner join stations as s on trains.source = s.id 
	inner join stations as d on trains.destination = d.id
    inner join tickets on trains.id = tickets.train
group by tickets.train
order by trains.id;