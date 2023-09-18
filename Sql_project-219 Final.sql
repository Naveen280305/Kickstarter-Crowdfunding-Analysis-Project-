use crowdfunding_project;
-- ---------------------------------------------------------------------------------------------------------
# Conversion Of epoch Time to Human Readable
# This query converts the 'created_at' column timestamp from epoch time to a human-readable format.
select from_unixtime(created_at) as formatted_date from projects;
-- ---------------------------------------------------------------------------------------------------------
# Calender Table using View function
# This query retrieves data from a calendar table created as a view.
Select * from Calender_table;

-- ----------------------------------------------------------------- 
# Calender Table using Store Procedures function
# This query executes a stored procedure to access calendar data
call calender_table2;

-- ---------------------------------------------------------------------------------------------------------

# #  Projects Overview KPI :
select count(ProjectID) as Total_of_projects from projects;
-- ---------------------------------------------------------------------------------------------------------
select count(case when state="successful" then 1 end) as Total_no_of_successful_projects from projects;
-- ---------------------------------------------------------------------------------------------------------
select count(id) as Total_no_of_location from location;
------------------------------------------------------------------------------------------------------------
select count(id) as Total_no_of_category from category;
-- ---------------------------------------------------------------------------------------------------------
select count(backers_count) as Total_no_of_Backers from projects;
-- ---------------------------------------------------------------------------------------------------------
select state,count(state) as Total_no_Outcomes from Projects group by state order by Total_no_Outcomes;
-- ---------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------

# Total 10  Projects By Category
# This query calculates the total number of projects by Category.

select (category.name) as Category_Name,
Count(pro.ProjectID) as Total_no_of_projects
from category 
left join projects pro on pro.category_id=category.id group by Category_Name order by Total_no_of_projects desc limit 10 ;

-- -----------------------------------------------------------------------------------------------------------
# Top 5 Category By location 
# These queries count the number of locations .

select country,count(id) as Total_No 
from location
group by country
order by Total_NO desc limit 5;


-- -----------------------------------------------------------------------------------------------------------
# Top successfull Projects by Backers count 
# This query identifies the top 10 successful projects based on their backers count.

select category.name As Category_Name, count(projects.backers_count )as total
from category inner join projects
on projects.category_id=category.id 
where (case when projects.state="successful" then 1 else 0 end)
group by category.name
order by total Desc limit 10;

-- ----------------------------------------------------------------------------------------------------------
#  Top-10 successful projects by Amount Raised
# This query identifies the top 10 successful projects based on the total amount raised.

select category.name, round(sum(projects.goal)/1000000,2) as Total_Amount_Raised_in_Millions
from category inner join projects
on projects.category_id=category.id
where (case when projects.state="successful" then 1 else 0 end)
group by category.name 
order by  Total_Amount_Raised_in_Millions desc limit 10;

-- ----------------------------------------------------------------------------------------------------------
# Percentage of successful projects by category
# This query calculates the percentage of successful projects in each category.

select category.name, Round((sum(case when projects.state="successful" then 1 else 0 end)/count(projects.projectid))*100,2) as Percentage_of_Successful_Projects_by_Category
from category 
inner join projects 
on projects.category_id=category.id
group by category.name 
order by Percentage_of_Successful_Projects_by_Category  desc limit 10;

-- -----------------------------------------------------------------------------------------------------------
# Percentage of Successful Projects overall
select  
round((sum(case when state="successful" then 1 else 0 end)/count(projectid))*100,2) as Percentage_of_Successful_Projects_overall
from projects;




