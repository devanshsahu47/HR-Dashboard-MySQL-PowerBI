SELECT * FROM projects.hr;

select gender,count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by gender;

select race,count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by race
order by count(*) desc;

select
	min(age) as youngest,
    max(age) as oldest
from hr
where age >= 18 and termdate = 0000-00-00;
select
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '45-54'
        when age >= 55 and age <= 64 then '55-64'
        else'65+'
	end as age_group,
    count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by age_group
order by age_group;

select
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '45-54'
        when age >= 55 and age <= 64 then '55-64'
        else'65+'
	end as age_group,gender,
    count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by age_group, gender
order by age_group, gender;

select location, count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by location;

select
	round(avg(datediff(termdate,hire_date))/365) as avg_length_employment
from hr
where termdate <= curdate() and termdate <> 0000-00-00 and age>= 18;

select department,gender,count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by department, gender
order by department;

select jobtitle, count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by jobtitle
order by jobtitle desc;

select department,
	total_count,
    terminated_count,
    terminated_count/total_count as termination_rate
from (
	select department,
    count(*) as total_count,
    sum(case when termdate <> 0000-00-00 and termdate <= curdate() then 1 else 0 end) as terminated_count
    from hr
    where age >= 18
    group by department
    ) as subquery
order by termination_rate desc;

select location_state, count(*) as count
from hr
where age >= 18 and termdate = 0000-00-00
group by location_state
order by count desc;

select
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires*100,2) as net_change_percent
from (
	select
		year(hire_date) as year,
        count(*) as hires,
        sum(case when termdate <> 0000-00-00 and termdate <= curdate() then 1 else 0 end) as terminations
        from hr
        where age >= 18
        group by year(hire_date)
        ) as subquery
order by year asc;

select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate <= curdate() and termdate <> 0000-00-00 and age >= 18
group by department;