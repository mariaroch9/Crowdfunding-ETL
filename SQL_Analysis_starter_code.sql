

CREATE TABLE "campaign" (
	"campaign_index" int NOT NULL, 
    "cf_id" int   NOT NULL,
    "contact_id" int   NOT NULL,
    "company_name" varchar(100)   NOT NULL,
    "description" text   NOT NULL,
    "goal" numeric(10,2)   NOT NULL,
    "pledged" numeric(10,2)   NOT NULL,
    "outcome" varchar(50)   NOT NULL,
    "backers_count" int   NOT NULL,
    "country" varchar(10)   NOT NULL,
    "currency" varchar(10)   NOT NULL,
    "launched_date" date   NOT NULL,
    "end_date" date   NOT NULL,
    "category_id" varchar(10)   NOT NULL,
    "subcategory_id" varchar(10)   NOT NULL,
    CONSTRAINT "pk_campaign" PRIMARY KEY (
        "cf_id"
     )
);

CREATE TABLE "contacts" (
	"index" int NOT NULL,
    "contact_id" int   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
);

CREATE TABLE "category" (
	"category_index" int NOT NULL,
    "category_id" varchar(10) NOT NULL,
    "category_name" varchar(50)   NOT NULL,
	CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
		)
);

CREATE TABLE "subcategory" (
	"subcategory_index" int NOT NULL,
    "subcategory_id" varchar(10)   NOT NULL,
    "subcategory_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_subcategory" PRIMARY KEY (
        "subcategory_id"
     )
);

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_contact_id" FOREIGN KEY("contact_id")
REFERENCES "contacts" ("contact_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");


SELECT * FROM contacts;

CREATE TABLE "backers" (
	"backer_index" int NOT NULL,
    "backer_id" varchar(10) NOT NULL,
	"cf_id" int NOT NULL,
    "first_name" varchar(50) NOT NULL,
    "last_name" varchar(50) NOT NULL,
    "email" varchar(100) NOT NULL,
	CONSTRAINT "pk_backers" PRIMARY KEY (
        "backer_id"
		)
);
ALTER TABLE "backers" ADD CONSTRAINT "fk_campaign_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

SELECT * FROM backers;

SELECT * FROM campaign;

SELECT backers_count, cf_id, outcome
FROM campaign
WHERE outcome =('live')
ORDER BY backers_count DESC;

SELECT COUNT (b.backer_id), 
	b.cf_id
From backers as b
GROUP BY b.cf_id
ORDER BY b.count DESC;

SELECT 
co.first_name,
co.last_name,
co.email,
c.goal- c.pledged AS remaining_goal
FROM campaign as c
INNER JOIN contacts as co
ON c.contact_id = co.contact_id
WHERE c.outcome=('live')
c.outcomeOrder by remaining_goal DESC;

SELECT b.email,
b.first_name,
b.last_name, 
b.cf_id,
c.company_name, 
c.description, 
c.end_date,
c.goal- c.pledged AS left_goal
FROM backers as b
INNER JOIN campaign as c
ON c.cf_id= b.cf_id
Order by last_name, email;

