-- joining tables

select * from hr1 join hr2
on hr1.EmployeeNumber = hr2.Employee_id;

-- Total employees

select count(*) as Total_Employees from hr1;

-- count of female

select count(*) as Female_count from hr1
where Gender = "Female" and Attrition ="Yes";

-- count of male

select count(*) as male_count from hr1
where Gender = "Male";

-- attrition count

select count(*) as Attrition_count from hr1
where Attrition = "Yes";

-- active employees

select count(*) as Active_Employees from hr1
where Attrition ="No";

-- average age

select round(avg(Age),0) as Average_Age from hr1
group by EmployeeCount;

-- avegare jobsatisfactin rate

select round(avg(JobSatisfaction),1) as Average_Jobsatisfaction_Rate from hr1
group by EmployeeCount;

-- average salary

select round(avg(MonthlyIncome),0) as Average_Salary from hr2
group by Over18;

-- avg attrition rate for all departments

select a.Department,concat(round(avg(a.atrition)*100,2),'%') as Attrition_Rate from
(select Department,Attrition ,
case 
when Attrition = "Yes" then 1
else 0 
end as atrition from hr1 )as a
group by a.Department;

-- avg working years for each departments

select hr1.Department,round(avg(hr2.TotalWorkingyears),2) 
as avg_workingyears 
from hr1 inner join hr2
on hr1.EmployeeNumber = hr2.Employee_id
group by hr1.Department;

-- avg hourly rate of male research scientist

select JobRole,Gender, concat(round(avg(HourlyRate),2),'%') as avg_hourlyrate from hr1
where JobRole= "Research Scientist" and Gender = "Male"
group by Gender;

-- jobrole vs worklifebalance

select distinct(hr1.Department),(case
when hr2.WorkLifeBalance = 1 then "1.Poor" 
when hr2.WorkLifeBalance = 2 then "2.Average" 
when hr2.WorkLifeBalance = 3 then "3.Good" 
else "4.excellent"end) 
as worklifebal_status,
count(hr2.WorkLifeBalance) 
as count_worklifebalance from hr1 inner join hr2
on hr1.EmployeeNumber = hr2.Employee_id
group by 1 ,2
order by worklifebal_status asc,count_worklifebalance desc;

-- attrition rate vs yearssincelastpromotion

select hr1.Department,concat(round(sum(case when Attrition = "Yes" 
then 1 else 0 end)/count(EmployeeCount)*100,2),'%') as Atr_Rate,
round(avg(hr2.YearsSinceLastPromotion),2) as avg_yslp
from hr1 inner join hr2 
on hr1.EmployeeNumber = hr2.Employee_id
group by 1;

-- attrition rate vsmonthlyincomestats 

select hr1.Department,concat(round(sum(case when Attrition = "Yes" 
then 1 else 0 end)/count(EmployeeCount)*100,2),'%') as Atr_Rate,
round(avg(hr2.MonthlyIncome),0) as avg_MonthlyIncome
from hr1 inner join hr2 
on hr1.EmployeeNumber = hr2.Employee_id
group by 1;



-- gender,marital status wise attrition count

select Gender,MaritalStatus,sum(case when Attrition = "Yes" then 1 else 0 end) as atrition from hr1
group by 1,2;

-- gender , marital status ,education field wise attrition count

select Gender,MaritalStatus,EducationField,sum(case when Attrition = "Yes" then 1 else 0 end) as atrition from hr1
group by 1,2,EducationField;

-- business travel wise employee count

select BusinessTravel,sum(EmployeeCount) from hr1
group by BusinessTravel;

-- department wise avg performance rating and  avg percent salaryhike

select hr1.Department,concat(round(avg(hr2.PerformanceRating),2),'%') as avg_performancerating,
concat(round(avg(PercentSalaryHike),2),'%')as avg_percentsaleryhike from hr1 inner join hr2
on hr1.EmployeeNumber = hr2.Employee_id
group by hr1.Department;

-- employees by age group

select sum(EmployeeCount) as EmployeeCount,case when Age between 18 and 20 then "18-20" 
when Age between 21 and 25 then "21-25" when Age between 26 and 30 then "26-30" 
when Age between 31 and 35 then "31-35" when Age between 36 and 40 then "36-40" 
when Age between 41 and 45 then "41-45" when Age between 46 and 50 then "46-50" 
when Age between 51 and 55 then "51-55" else "55-60"
end as Age_Group from hr1
group by Age_Group order by Age_Group asc;

-- jobinvolvement by gender

select Gender,concat(round(avg(JobInvolvement),2),'%') as Job_Involvement from hr1
group by Gender;

-- job role wise attrition of active employees

select hr1.JobRole,sum(case when Attrition = "No" then 1 else 0 end) as atrition  from hr1 inner join hr2 
on hr1.EmployeeNumber = hr2.Employee_id
group by 1;
