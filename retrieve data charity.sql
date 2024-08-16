-- Retrieve all donors:
SELECT * FROM donor_manage.donors;

--Retrieve all donations made by a specific donor(donor_id = 1):
SELECT * FROM donor_manage.donations
WHERE donor_id = 1;

-- Retrieve all beneficiaries who received a specific type of assistance ("Medical"):
SELECT * FROM benefici_manage.beneficiaries
WHERE benef_id IN (
    SELECT benefi_id FROM benefici_manage.aidprovided
    WHERE assistance_type = 'Medical'
);

-- Retrieve all projects and their budgets:
SELECT project_name, budget FROM projects_manage.projects;

--Retrieve funding details for a specific project(project_id = 1):
SELECT * FROM projects_manage.project_funding
WHERE project_id = 1;

-- Retrieve all volunteers participating in a specific project (project_id = 1):
SELECT v.fullname, v.email, p.participation_date
FROM projects_manage.volunteers v
JOIN projects_manage.volunteer_participation p
ON v.volunteer_id = p.volunteer_id
WHERE p.project_id = 1;

-- Retrieve total amount of assistance provided for each type of assistance:
SELECT assistance_type, SUM(amount) AS total_amount
FROM benefici_manage.aidprovided
GROUP BY assistance_type;

-- Retrieve all donations that occurred within a specific date range (from 2024-01-01 to 2024-02-01):
SELECT * FROM donor_manage.donations
WHERE donation_date BETWEEN '2024-01-01' AND '2024-02-01';


-- Retrieve the number of volunteers for each project:*
SELECT p.project_name, COUNT(vp.volunteer_id) AS volunteer_count
FROM projects_manage.projects p
LEFT JOIN projects_manage.volunteer_participation vp
ON p.project_id = vp.project_id
GROUP BY p.project_name;


-- Retrieve all donations greater than a specific amount(5000.00):
SELECT * FROM donor_manage.donations
WHERE amount > 5000.00;

-- Retrieve the latest donation for each donor:
SELECT donor_id, amount, donation_date
FROM donor_manage.donations
WHERE donation_date = (
    SELECT MAX(donation_date)
    FROM donor_manage.donations d
    WHERE d.donor_id = donor_manage.donations.donor_id
);

-- Retrieve beneficiaries who have received assistance of more than a specific amount (2000.00):
SELECT b.fullname, b.address, a.amount
FROM benefici_manage.beneficiaries b
JOIN benefici_manage.aidprovided a
ON b.benef_id = a.benefi_id
WHERE a.amount > 2000.00;

-- Retrieve projects that have not been fully funded (assuming budget is the total funding required):
SELECT p.project_name, p.budget, COALESCE(SUM(f.amount), 0) AS total_funding
FROM projects_manage.projects p
LEFT JOIN projects_manage.project_funding f
ON p.project_id = f.project_id
GROUP BY p.project_name, p.budget
HAVING p.budget > COALESCE(SUM(f.amount), 0);

-- Retrieve the number of donations made by each donor:
SELECT d.fullname, COUNT(dn.donation_id) AS donation_count
FROM donor_manage.donors d
LEFT JOIN donor_manage.donations dn
ON d.donor_id = dn.donor_id
GROUP BY d.fullname;


-- Retrieve volunteers who have participated in more than one project:
SELECT v.fullname, COUNT(vp.project_id) AS project_count
FROM projects_manage.volunteers v
JOIN projects_manage.volunteer_participation vp
ON v.volunteer_id = vp.volunteer_id
GROUP BY v.fullname
HAVING COUNT(vp.project_id) > 1;

-- Retrieve the project with the highest budget:
SELECT TOP 1 * FROM projects_manage.projects
ORDER BY budget DESC;

-- Retrieve all beneficiaries who have not received any assistance:*
SELECT * FROM benefici_manage.beneficiaries
WHERE benef_id NOT IN (
    SELECT benefi_id FROM benefici_manage.aidprovided
);

-- Retrieve volunteers and their participation dates for a specific project (project_id = 1):
SELECT v.fullname, p.participation_date
FROM projects_manage.volunteers v
JOIN projects_manage.volunteer_participation p
ON v.volunteer_id = p.volunteer_id
WHERE p.project_id = 1;

--Retrieve donors who have made donations of a specific type ("Financial"):
SELECT DISTINCT d.fullname, d.email
FROM donor_manage.donors d
JOIN donor_manage.donations dn
ON d.donor_id = dn.donor_id
WHERE dn.donation_type = 'Financial';

-- Retrieve total amount of donations received per month for the current year:
SELECT MONTH(donation_date) AS month, SUM(amount) AS total_donations
FROM donor_manage.donations
WHERE YEAR(donation_date) = YEAR(GETDATE())
GROUP BY MONTH(donation_date)
ORDER BY month;


