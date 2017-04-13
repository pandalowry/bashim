SELECT ps1.datetime, ps1.number, ps1.text, ps1.ratio
FROM posts ps1 JOIN posts ps2
	ON ps1.ratio <= ps2.ratio AND date(ps1.datetime) = date(ps2.datetime)
GROUP BY ps1.ratio, date(ps1.datetime)
HAVING count(*) <= 5
ORDER BY date(ps1.datetime), ps1.ratio DESC