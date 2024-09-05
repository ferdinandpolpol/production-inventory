# WIP
I'm currently working on this to work on my JS skills with NextJS because why not? 
This was previously using django templates with JQuery and that worked fine but it might be 
nicer to have this in a more modern front-end framework. + It MIGHT look good in my portfolio

## About The Project
The project was created to automate processes for the Family Business. I'm also treating this as a pet project where I practice various JS Frameworks (NextJS) and other things that might interest me (DevOps stuff with Terraform, K8s in the future, etc)

### Built With

* Django
* JQuery - Used because it's just a simple app

# Local Setup
```
cp dc.local.yml docker-compose.override.yml
docker-compose build
docker-compose up

# might need to run migrations
docker-compose exec backend python manage.py migrate
```

You should now be able to access
- Frontend `http://localhost:3000`
- Backend API `http://localhost:8000/api`
- Django Admin `http://localhost:8000/admin`



# Infrastructure Details

## IaC
I have implemented IaC on this project using terraform. 
There is one `main.tf` file that consists of all the existing data and resources that will be created. 

I know `data` resources would be better in different files but since I think the infrastructure of this project
is pretty simple, having one file to store all infrastructure code seems to be more efficient. I might move all 
to their own separate files when the infrastructure gets bigger but I doubt it.

The other reason I added terraform for this project is because this project was previously deployed on AWS Lightsail.
Lightsail was pretty simple AWS service to implement this project with separate instance and separate database, but 
the main reason I'm moving away from that service is the cost. It was costing me 35$ a month, which IS PRETTY LOW, but 
this project will only be used by at most 1-2 people AND mostly on weekends or by the end of the month, so I thought 
that it could be significantly lower by ALSO moving the database and web app from separate lightsail products to one instance. (Goal is around <20$) Further cost optimization would probably be using a reserved/spot instance that only runs on the weekend. 

## Current AWS Services
### EC2 
Used to run the Web Application with Django and Database used with Elastic IP.
- ASG is not necessary since scaling is not needed for <1000 users
- ELB is not used to further reduce costing

### Route 53
There is one Public Hosted Zone `amorens.ph` and 2 DNS records for `sys.amorens.ph` and `www.sys.amorens.ph`

### S3
Store backups for DB


## Docker Containers
### Web
Django + Django Templates
### Nginx + Certbot
HTTPS - https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
### DB
Previously run in a Lightsail DB, but now running as a container in the same EC2 instance.
( Yeah I know this could potentially be an issue if the instance goes down then everything is down. )


### Dev Notes
This is mostly basic CRUD app which involves mostly data-entry

The only real unique thing here is how the production works. For a product there is always a main ingredient,
and based off that main ingredient is how the quantity of other ingredients will be used and will automatically be calculated.

This data is stored in the database where the recipe and ingredients of products are constant.


<!-- ROADMAP -->
## Roadmap

- [ ] Sales Reporting, REVENUE ETC
- [ ] User Authentication
- [ ] User Modification Logging
- [ ] Supply Prices
- [ ] Costs Reports
- [ ] Payroll


<p align="right">(<a href="#readme-top">back to top</a>)</p>



