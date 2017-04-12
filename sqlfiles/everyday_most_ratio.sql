select date(`datetime`) as postdate, number, text, ratio from posts, 
(select MAX(ratio) as maxratio
from posts
where ratio IS NOT NULL
group by date(`datetime`)) as hits
where ratio = hits.maxratio
order by postdate desc