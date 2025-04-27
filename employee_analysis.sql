delimiter //
create procedure Get_report()
begin 
SELECT  Department, avg(salary) as avg_salary, count(distinct ï»¿EmployeeID) as total_emp, avg(age) as avg_age,   avg(YearsAtCompany) as years_at_company
FROM pop.employee
group by department;

end //

call get_report();

with cte as(
select gender, count(gender) as total_c
from pop.employee
group by gender), ratio_company as(
select *, sum(total_c) over() as total_count 
from cte)
select *, total_c *100/ total_count as ratio
from ratio_company;

with cte as(
select state, count(gender) as total_c
from pop.employee
group by state), ratio_company as(
select *, sum(total_c) over() as total_count 
from cte)
select *, total_c *100/ total_count as ratio
from ratio_company;

with high_emp_state as(
select *, dense_rank() over(partition by State order by Salary desc) as rnk
from pop.employee)
select *
from high_emp
where rnk <= 5;

select educationfield,count(educationfield) as total_count
from pop.employee
group by educationfield;