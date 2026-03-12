CREATE TABLE `companies` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `address1` VARCHAR(255),
  `address2` VARCHAR(255),
  `address3` VARCHAR(255),
  `country` VARCHAR(255),
  `city` VARCHAR(100),
  `state` VARCHAR(50),
  `pin` VARCHAR(20),
  `route` VARCHAR(50),
  `zone` VARCHAR(50),
  `area` VARCHAR(50),
  `cluster` VARCHAR(50),
  `gstin` VARCHAR(50),
  `security` VARCHAR(255),
  `weekly_off_start` VARCHAR(20),
  `weekly_off_end` VARCHAR(20),
  `working_hrs_start` TIME,
  `working_hrs_end` TIME
);

CREATE TABLE `machines` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `mc_no` VARCHAR(50) NOT NULL,
  `model` VARCHAR(100),
  `status` VARCHAR(50),
  `start_dt` DATE,
  `end_dt` DATE,
  `inv_no` VARCHAR(40),
  `inv_dt` DATE,
  `inv_value` VARCHAR(20)
);

CREATE TABLE `contacts` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `machine_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(50),
  `email` VARCHAR(255),
  `designation` VARCHAR(100)
);

CREATE TABLE `tickets` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `machine_id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  `ticket_no` INT,
  `status` ENUM ('open', 'closed') DEFAULT 'open'
);

CREATE TABLE `ticket_issues` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `ticket_id` INT NOT NULL,
  `date` DATE,
  `start_time` VARCHAR(20),
  `end_time` VARCHAR(20),
  `log_by` VARCHAR(50),
  `customer_name` VARCHAR(255),
  `fault` VARCHAR(255),
  `priority` VARCHAR(20),
  `status` ENUM ('open', 'WF', 'close') DEFAULT 'open'
);

CREATE TABLE `work_front` (
  `issue_id` INT NOT NULL,
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `cluster_id` INT NOT NULL,
  `short_form_id` INT NOT NULL,
  `status` ENUM ('open', 'done') DEFAULT 'open'
);

CREATE TABLE `short_form` (
  `s` INT,
  `a` INT,
  `i` INT,
  `d` INT,
  `e` INT,
  `f` INT,
  `p` INT,
  `prior` INT,
  `purpose` VARCHAR(100),
  `priority` VARCHAR(100),
  `id` INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE `cluster` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `z` INT,
  `a` INT,
  `r` INT,
  `c` INT,
  `cluster` VARCHAR(30),
  `rg` VARCHAR(50),
  `zarc` INT
);

CREATE TABLE `work_done` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `work_front_id` INT NOT NULL,
  `done_date` date,
  `done_by` VARCHAR(20),
  `status` ENUM ('open', 'closed') DEFAULT 'open'
);

CREATE TABLE `spare_option` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `spare_name` VARCHAR(255) NOT NULL
);

CREATE TABLE `spare_used` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `spare_option_id` INT NOT NULL,
  `work_done_id` INT NOT NULL
);

ALTER TABLE `machines` ADD FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

ALTER TABLE `contacts` ADD FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

ALTER TABLE `contacts` ADD FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`);

ALTER TABLE `tickets` ADD FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

ALTER TABLE `tickets` ADD FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`);

ALTER TABLE `tickets` ADD FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`);

ALTER TABLE `ticket_issues` ADD FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`);

ALTER TABLE `work_front` ADD FOREIGN KEY (`issue_id`) REFERENCES `ticket_issues` (`id`) ON DELETE CASCADE;

ALTER TABLE `work_front` ADD FOREIGN KEY (`short_form_id`) REFERENCES `short_form` (`id`) ON DELETE CASCADE;

ALTER TABLE `work_front` ADD FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE CASCADE;

ALTER TABLE `work_done` ADD FOREIGN KEY (`work_front_id`) REFERENCES `work_front` (`id`) ON DELETE CASCADE;

ALTER TABLE `spare_used` ADD FOREIGN KEY (`work_done_id`) REFERENCES `work_done` (`id`);

ALTER TABLE `spare_used` ADD FOREIGN KEY (`spare_option_id`) REFERENCES `spare_option` (`id`);
