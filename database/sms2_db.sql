-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 21, 2026 at 12:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sms2_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `sms2_activity_logs`
--

CREATE TABLE `sms2_activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `user_name` varchar(150) DEFAULT NULL,
  `role_key` varchar(40) DEFAULT NULL,
  `action` varchar(40) NOT NULL,
  `module_key` varchar(60) DEFAULT NULL,
  `detail` varchar(500) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_logs_user` (`user_id`),
  KEY `idx_logs_action` (`action`),
  KEY `idx_logs_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms2_admin_announcements`
--

CREATE TABLE `sms2_admin_announcements` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(180) NOT NULL,
  `body` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `status` enum('draft','published','unpublished','archived') NOT NULL DEFAULT 'draft',
  `audience` varchar(40) NOT NULL DEFAULT 'all',
  `category` varchar(40) NOT NULL DEFAULT 'General',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by_name` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `published_at` datetime DEFAULT NULL,
  `scheduled_for` date DEFAULT NULL,
  `expires_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms2_login_throttles`
--

CREATE TABLE `sms2_login_throttles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `throttle_key` char(64) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempts` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_login_throttle_key` (`throttle_key`),
  KEY `idx_login_throttle_ip` (`ip_address`),
  KEY `idx_login_throttle_locked` (`locked_until`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms2_password_resets`
--

CREATE TABLE `sms2_password_resets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_ip` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- --------------------------------------------------------

--
-- Table structure for table `sms2_password_reset_requests`
--

CREATE TABLE `sms2_password_reset_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `module_key` varchar(60) NOT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `requested_password_hash` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected','cancelled') NOT NULL DEFAULT 'pending',
  `admin_id` int(10) UNSIGNED DEFAULT NULL,
  `admin_note` varchar(500) DEFAULT NULL,
  `temp_password_set` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- --------------------------------------------------------

--
-- Table structure for table `sms2_roles`
--

CREATE TABLE `sms2_roles` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `role_key` varchar(40) NOT NULL,
  `label` varchar(80) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Built-in, non-personal defaults.
INSERT INTO `sms2_roles` (`id`, `role_key`, `label`, `description`, `is_system`, `created_at`) VALUES
(1, 'admin', 'Super Admin', 'Legacy super admin access', 1, '2026-07-22 22:24:44'),
(2, 'registrar', 'Registrar', 'Enrollment, records, scheduling', 1, '2026-07-22 22:24:44'),
(3, 'finance', 'Finance', 'Payments and receivables', 1, '2026-07-22 22:24:44'),
(4, 'hr', 'Dean', 'Dean and faculty processes', 1, '2026-07-22 22:24:44'),
(5, 'it_office', 'IT Office', 'LMS and IT modules', 1, '2026-07-22 22:24:44'),
(6, 'osa', 'OSA', 'Student affairs / co-curricular', 1, '2026-07-22 22:24:44'),
(7, 'qa', 'QA Office', 'Accreditation and quality', 1, '2026-07-22 22:24:44'),
(8, 'crad_officer', 'CRAD Officer', 'Research and development', 1, '2026-07-22 22:24:44'),
(9, 'student', 'Student', 'Student portal only', 1, '2026-07-22 22:24:44'),
(10, 'superadmin', 'Super Admin', 'Full system access', 1, '2026-08-08 17:25:19'),
(11, 'admission', 'Admission', 'Admission office access', 1, '2026-08-08 17:25:19'),
(56, 'research_coordinator', 'Research Coordinator', 'Research coordination access', 1, '2026-08-08 18:13:51'),
(102, 'adviser', 'Adviser', 'Research adviser faculty account', 1, '2026-08-08 21:35:14'),
(213, 'research_director', 'Research Director', 'Research defense scheduling director account', 1, '2026-08-09 19:31:14'),
(384, 'research_grant', 'CRAD Officer', 'Research grant management access', 1, '2026-08-10 20:01:49'),
(770, 'grammarian', 'Grammarian', 'Research grammar and manuscript evaluation account', 1, '2026-08-14 11:06:49'),
(788, 'panel', 'Panel Member', 'Research defense panel account', 1, '2026-08-15 17:07:16'),
(800, 'sms_admin', 'Admin', 'General administrator account', 1, '2026-08-18 00:38:50'),
(901, 'review_committee', 'Review Committee', 'Grant proposal review and rubric evaluation', 1, '2026-08-31 07:04:35'),
(1206, 'department_chair', 'Department Chair', 'Grant approval — department chair sign-off', 1, '2026-08-31 10:29:00'),
(1207, 'research_office', 'Research Office', 'Grant approval — research office sign-off', 1, '2026-08-31 10:29:00'),
(1208, 'vpaa', 'VPAA', 'Grant approval — VPAA sign-off', 1, '2026-08-31 10:29:00'),
(1686, 'department_head', 'Department Head', 'Adviser and panel assignment', 1, '2026-09-19 01:01:39');

--
--

-- --------------------------------------------------------

--
-- Table structure for table `sms2_role_permissions`
--

CREATE TABLE `sms2_role_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_key` varchar(40) NOT NULL,
  `module_key` varchar(60) NOT NULL,
  `granted` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Built-in, non-personal defaults.
INSERT INTO `sms2_role_permissions` (`id`, `role_key`, `module_key`, `granted`, `updated_at`) VALUES
(1156, 'superadmin', 'user-management', 1, '2026-08-31 10:29:00'),
(1157, 'admission', 'enrollment', 1, '2026-08-31 10:29:00'),
(1158, 'registrar', 'registrar', 1, '2026-08-31 10:29:00'),
(1159, 'registrar', 'curriculum', 1, '2026-08-31 10:29:00'),
(1160, 'registrar', 'scheduling', 1, '2026-08-31 10:29:00'),
(1161, 'crad_officer', 'crad', 1, '2026-08-31 10:29:00'),
(1162, 'research_coordinator', 'crad', 1, '2026-08-31 10:29:00'),
(1163, 'department_chair', 'crad', 1, '2026-08-31 10:29:00'),
(1164, 'research_office', 'crad', 1, '2026-08-31 10:29:00'),
(1165, 'research_director', 'faculty', 1, '2026-08-31 10:29:00'),
(1166, 'grammarian', 'faculty', 1, '2026-08-31 10:29:00'),
(1167, 'review_committee', 'crad_grant', 1, '2026-08-31 10:29:00'),
(1168, 'panel', 'faculty', 1, '2026-08-31 10:29:00'),
(1169, 'finance', 'payment', 1, '2026-08-31 10:29:00'),
(1170, 'osa', 'cocurricular', 1, '2026-08-31 10:29:00'),
(1171, 'it_office', 'lms', 1, '2026-08-31 10:29:00'),
(1172, 'qa', 'accreditation', 1, '2026-08-31 10:29:00'),
(1173, 'vpaa', 'accreditation', 1, '2026-08-31 10:29:00'),
(1174, 'hr', 'faculty', 1, '2026-08-31 10:29:00'),
(1175, 'student', 'student_portal', 1, '2026-08-31 10:29:00'),
(1179, 'sms_admin', 'enrollment', 1, '2026-09-18 22:08:12'),
(1180, 'sms_admin', 'registrar', 1, '2026-09-18 22:08:12'),
(1181, 'sms_admin', 'curriculum', 1, '2026-09-18 22:08:12'),
(1182, 'sms_admin', 'accreditation', 1, '2026-09-18 22:08:12'),
(1183, 'sms_admin', 'payment', 1, '2026-09-18 22:08:12'),
(1184, 'sms_admin', 'faculty', 1, '2026-09-18 22:08:12'),
(1185, 'sms_admin', 'scheduling', 1, '2026-09-18 22:08:12'),
(1186, 'sms_admin', 'cocurricular', 1, '2026-09-18 22:08:12'),
(1187, 'sms_admin', 'lms', 1, '2026-09-18 22:08:12'),
(1188, 'sms_admin', 'crad', 1, '2026-09-18 22:08:12'),
(1189, 'adviser', 'faculty', 1, '2026-08-31 10:29:24'),
(1193, 'research_grant', 'crad_grant', 1, '2026-08-31 10:29:24'),
(1945, 'department_head', 'crad', 1, '2026-09-19 01:01:39');

--
--

-- --------------------------------------------------------

--
-- Table structure for table `sms2_security_otps`
--

CREATE TABLE `sms2_security_otps` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `purpose` varchar(40) NOT NULL,
  `code_hash` char(64) NOT NULL,
  `module_key` varchar(60) DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_otp_user` (`user_id`),
  KEY `idx_otp_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- --------------------------------------------------------

--
-- Table structure for table `sms2_student_profiles`
--

CREATE TABLE `sms2_student_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `student_id` varchar(40) NOT NULL,
  `program` varchar(200) NOT NULL DEFAULT 'Bachelor of Science in Information Technology',
  `year_level` varchar(40) NOT NULL DEFAULT '4th Year',
  `section` varchar(40) NOT NULL DEFAULT 'BSIT 4A',
  `semester` varchar(40) NOT NULL DEFAULT '1st Semester',
  `school_year` varchar(20) NOT NULL DEFAULT '2026-2027',
  `enrollment_status` varchar(40) NOT NULL DEFAULT 'Enrolled',
  `standing` varchar(40) NOT NULL DEFAULT 'Good Standing',
  `mobile` varchar(40) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `guardian` varchar(150) DEFAULT NULL,
  `guardian_contact` varchar(40) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- --------------------------------------------------------

--
-- Table structure for table `sms2_system_settings`
--

CREATE TABLE `sms2_system_settings` (
  `setting_key` varchar(80) NOT NULL,
  `setting_value` text NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping non-sensitive defaults for table `sms2_system_settings`
INSERT INTO `sms2_system_settings` (`setting_key`, `setting_value`) VALUES
('session_timeout_minutes', '30'),
('max_failed_logins', '3'),
('lockout_value', '5'),
('lockout_unit', 'minutes'),
('lockout_seconds', '300'),
('lockout_minutes', '5'),
('min_password_length', '8'),
('password_expiry_days', '0'),
('require_password_change_first_login', '0'),
('csrf_enabled', '1'),
('crad_active_term', ''),
('smtp_port', '587'),
('smtp_encryption', 'tls'),
('mail_show_link_on_failure', '0');

-- --------------------------------------------------------

--
-- Table structure for table `sms2_users`
--

CREATE TABLE `sms2_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `role_key` varchar(40) NOT NULL,
  `student_id` varchar(40) DEFAULT NULL,
  `status` enum('active','inactive','locked','suspended') NOT NULL DEFAULT 'active',
  `must_change_password` tinyint(1) NOT NULL DEFAULT 0,
  `failed_login_attempts` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `password_changed_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(45) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- --------------------------------------------------------

--
-- Table structure for table `sms2_user_authenticators`
--

CREATE TABLE `sms2_user_authenticators` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `secret` varchar(512) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `pending_secret` varchar(512) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Built-in, non-personal defaults.
--

-- Built-in, non-personal defaults.
--

-- --------------------------------------------------------

--
-- Table structure for table `sms2_user_passkeys`
--

CREATE TABLE `sms2_user_passkeys` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `credential_id` varchar(1024) NOT NULL,
  `public_key` text NOT NULL,
  `sign_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `device_name` varchar(120) NOT NULL DEFAULT 'Passkey',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_used_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_passkey_cred` (`credential_id`(255)),
  KEY `idx_passkey_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--


--
-- Indexes for table `sms2_admin_announcements`
--
ALTER TABLE `sms2_admin_announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ann_status_published` (`status`,`published_at`),
  ADD KEY `idx_ann_audience` (`audience`);

--
-- Indexes for table `sms2_password_resets`
--
ALTER TABLE `sms2_password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reset_user` (`user_id`),
  ADD KEY `idx_reset_token` (`token_hash`),
  ADD KEY `idx_reset_expires` (`expires_at`);

--
-- Indexes for table `sms2_password_reset_requests`
--
ALTER TABLE `sms2_password_reset_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prr_user` (`user_id`),
  ADD KEY `idx_prr_status` (`status`),
  ADD KEY `idx_prr_module` (`module_key`),
  ADD KEY `fk_prr_admin` (`admin_id`);

--
-- Indexes for table `sms2_roles`
--
ALTER TABLE `sms2_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_key` (`role_key`);

--
-- Indexes for table `sms2_role_permissions`
--
ALTER TABLE `sms2_role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_role_module` (`role_key`,`module_key`),
  ADD KEY `idx_perm_module` (`module_key`);

--
-- Indexes for table `sms2_security_otps`
--
ALTER TABLE `sms2_security_otps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms2_student_profiles`
--
ALTER TABLE `sms2_student_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sp_user` (`user_id`),
  ADD UNIQUE KEY `uq_sp_student_id` (`student_id`);

--
-- Indexes for table `sms2_system_settings`
--
ALTER TABLE `sms2_system_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `sms2_users`
--
ALTER TABLE `sms2_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_username` (`username`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_role` (`role_key`),
  ADD KEY `idx_users_status` (`status`),
  ADD KEY `idx_users_student_id` (`student_id`),
  ADD KEY `idx_users_last_seen` (`last_seen_at`);

--
-- Indexes for table `sms2_user_authenticators`
--
ALTER TABLE `sms2_user_authenticators`
  ADD PRIMARY KEY (`user_id`);


--
-- AUTO_INCREMENT for dumped tables
--


--
-- AUTO_INCREMENT for table `sms2_admin_announcements`
--
ALTER TABLE `sms2_admin_announcements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms2_login_throttles`
--
ALTER TABLE `sms2_login_throttles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms2_password_resets`
--
ALTER TABLE `sms2_password_resets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `sms2_password_reset_requests`
--
ALTER TABLE `sms2_password_reset_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sms2_roles`
--
ALTER TABLE `sms2_roles`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2151;

--
-- AUTO_INCREMENT for table `sms2_role_permissions`
--
ALTER TABLE `sms2_role_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2593;

--
-- AUTO_INCREMENT for table `sms2_security_otps`
--
ALTER TABLE `sms2_security_otps`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `sms2_student_profiles`
--
ALTER TABLE `sms2_student_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sms2_users`
--
ALTER TABLE `sms2_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1703;

--
-- AUTO_INCREMENT for table `sms2_user_authenticators`
--
ALTER TABLE `sms2_user_authenticators`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1599;


--
-- Constraints for dumped tables
--

--
-- Constraints for table `sms2_activity_logs`
--
ALTER TABLE `sms2_activity_logs`
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `sms2_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sms2_password_resets`
--
ALTER TABLE `sms2_password_resets`
  ADD CONSTRAINT `fk_reset_user` FOREIGN KEY (`user_id`) REFERENCES `sms2_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sms2_password_reset_requests`
--
ALTER TABLE `sms2_password_reset_requests`
  ADD CONSTRAINT `fk_prr_admin` FOREIGN KEY (`admin_id`) REFERENCES `sms2_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_prr_user` FOREIGN KEY (`user_id`) REFERENCES `sms2_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sms2_role_permissions`
--
ALTER TABLE `sms2_role_permissions`
  ADD CONSTRAINT `fk_perm_role` FOREIGN KEY (`role_key`) REFERENCES `sms2_roles` (`role_key`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sms2_users`
--
ALTER TABLE `sms2_users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_key`) REFERENCES `sms2_roles` (`role_key`) ON UPDATE CASCADE;

--
-- Constraints for table `sms2_user_passkeys`
--
ALTER TABLE `sms2_user_passkeys`
  ADD CONSTRAINT `fk_passkey_user` FOREIGN KEY (`user_id`) REFERENCES `sms2_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- --------------------------------------------------------
-- CRAD Research Group early flow (also in modules/crad/database/crad_db.sql)
-- --------------------------------------------------------
-- HostForge-ready: Research Group early flow + dual-confirm cycle
-- Run in HostForge SQL editor on the app database (same DB as sms2 / crad tables).
-- Safe to re-run CREATE TABLE IF NOT EXISTS; ADD COLUMN statements may error if
-- the column already exists — ignore those errors or run only missing pieces.

CREATE TABLE IF NOT EXISTS `crad_research_group_members` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `research_group_id` INT UNSIGNED NOT NULL,
  `member_order` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `student_id` VARCHAR(40) NOT NULL DEFAULT '',
  `full_name` VARCHAR(160) NOT NULL DEFAULT '',
  `section` VARCHAR(80) NOT NULL DEFAULT '',
  `email` VARCHAR(190) NOT NULL DEFAULT '',
  `or_number` VARCHAR(80) NOT NULL DEFAULT '',
  `is_leader` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_rgm_group` (`research_group_id`),
  KEY `idx_rgm_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `crad_research_assignment_cycles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `research_group_id` INT UNSIGNED DEFAULT NULL,
  `group_number` VARCHAR(40) NOT NULL DEFAULT '',
  `student_id` VARCHAR(40) NOT NULL DEFAULT '',
  `coordinator_assignment_id` INT UNSIGNED DEFAULT NULL,
  `adviser_assignment_id` INT UNSIGNED DEFAULT NULL,
  `status` VARCHAR(40) NOT NULL DEFAULT 'pending_confirmation',
  `coordinator_confirmed_at` DATETIME DEFAULT NULL,
  `coordinator_confirmed_by` INT UNSIGNED DEFAULT NULL,
  `adviser_confirmed_at` DATETIME DEFAULT NULL,
  `adviser_confirmed_by` INT UNSIGNED DEFAULT NULL,
  `cancelled_at` DATETIME DEFAULT NULL,
  `cancelled_by` INT UNSIGNED DEFAULT NULL,
  `cancel_role` VARCHAR(40) NOT NULL DEFAULT '',
  `cancel_reason` TEXT DEFAULT NULL,
  `assigned_by` INT UNSIGNED DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_rac_group` (`research_group_id`),
  KEY `idx_rac_group_number` (`group_number`),
  KEY `idx_rac_student` (`student_id`),
  KEY `idx_rac_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Additive columns on crad_research_groups (ignore "Duplicate column" errors)
ALTER TABLE `crad_research_groups`
  ADD COLUMN `flow_status` VARCHAR(40) NOT NULL DEFAULT 'draft' AFTER `status`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `incomplete_reason` TEXT DEFAULT NULL AFTER `flow_status`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `is_complete` TINYINT(1) NOT NULL DEFAULT 0 AFTER `incomplete_reason`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `member_count` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `is_complete`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `min_members_required` INT UNSIGNED NOT NULL DEFAULT 3 AFTER `member_count`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `submitted_by_user_id` INT UNSIGNED DEFAULT NULL AFTER `min_members_required`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `submitted_at` DATETIME DEFAULT NULL AFTER `submitted_by_user_id`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `dh_decision` VARCHAR(20) NOT NULL DEFAULT '' AFTER `submitted_at`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `dh_decision_by` INT UNSIGNED DEFAULT NULL AFTER `dh_decision`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `dh_decision_at` DATETIME DEFAULT NULL AFTER `dh_decision_by`;
ALTER TABLE `crad_research_groups`
  ADD COLUMN `dh_remarks` TEXT DEFAULT NULL AFTER `dh_decision_at`;

ALTER TABLE `crad_research_adviser_assignments`
  ADD COLUMN `confirmation_status` VARCHAR(40) NOT NULL DEFAULT 'pending_confirmation' AFTER `assignment_status`;
ALTER TABLE `crad_research_adviser_assignments`
  ADD COLUMN `confirmed_at` DATETIME DEFAULT NULL AFTER `confirmation_status`;
ALTER TABLE `crad_research_adviser_assignments`
  ADD COLUMN `confirmed_by` INT UNSIGNED DEFAULT NULL AFTER `confirmed_at`;

ALTER TABLE `crad_research_coordinator_assignments`
  ADD COLUMN `confirmation_status` VARCHAR(40) NOT NULL DEFAULT 'pending_confirmation' AFTER `status`;
ALTER TABLE `crad_research_coordinator_assignments`
  ADD COLUMN `confirmed_at` DATETIME DEFAULT NULL AFTER `confirmation_status`;
ALTER TABLE `crad_research_coordinator_assignments`
  ADD COLUMN `confirmed_by` INT UNSIGNED DEFAULT NULL AFTER `confirmed_at`;

