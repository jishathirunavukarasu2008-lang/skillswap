# SkillSwap Database Design

## 1. Database Overview

SkillSwap uses MySQL as its relational database.

Database name:

`skillswap`

The database stores users, skills, skill exchanges, learning sessions, rescue requests, learning circles, and circle membership information.

## 2. Database Tables

The project contains the following main tables:

- users
- skills
- user_skills
- exchanges
- exchange_sessions
- rescue_requests
- circles
- circle_members

## 3. Users Table

The `users` table stores student account information.

| Column | Description |
|---|---|
| user_id | Unique user ID |
| full_name | Student's full name |
| username | Unique username |
| email | Unique email address |
| password_hash | User password |
| bio | Student profile description |
| created_at | Account creation time |

## 4. Skills Table

The `skills` table stores available skills.

| Column | Description |
|---|---|
| skill_id | Unique skill ID |
| skill_name | Name of the skill |
| description | Skill description |

Examples:

- Java
- Python
- Web Development
- UI Design
- Machine Learning

## 5. User Skills Table

The `user_skills` table connects users with their skills.

A skill can be classified as:

- `OFFER` — skill the student can teach
- `WANT` — skill the student wants to learn

| Column | Description |
|---|---|
| user_skill_id | Unique record ID |
| user_id | References users |
| skill_id | References skills |
| skill_type | OFFER or WANT |

This table creates a relationship between users and skills.

## 6. Exchanges Table

The `exchanges` table stores skill exchange requests.

| Column | Description |
|---|---|
| exchange_id | Unique exchange ID |
| requester_id | Student sending request |
| receiver_id | Student receiving request |
| offered_skill_id | Skill being offered |
| wanted_skill_id | Skill being requested |
| status | PENDING, ACCEPTED or REJECTED |
| created_at | Request creation time |

## 7. Exchange Sessions Table

The `exchange_sessions` table stores scheduled learning sessions.

| Column | Description |
|---|---|
| session_id | Unique session ID |
| exchange_id | Related exchange |
| scheduled_date | Session date |
| scheduled_time | Session time |
| topic | Learning topic |
| duration_minutes | Session duration |
| status | Session status |
| created_at | Creation time |

A session belongs to an exchange.

## 8. Rescue Requests Table

The `rescue_requests` table supports SkillSwap Rescue.

It stores requests created when an exchange is disrupted.

| Column | Description |
|---|---|
| rescue_id | Unique rescue ID |
| exchange_id | Related exchange |
| requester_id | Student requesting rescue |
| reason | Reason for rescue |
| status | Rescue request status |
| replacement_user_id | Optional replacement student |
| created_at | Request creation time |

## 9. Circles Table

The `circles` table stores collaborative learning groups.

| Column | Description |
|---|---|
| circle_id | Unique circle ID |
| circle_name | Name of the learning circle |
| description | Circle description |
| created_by | Student who created the circle |
| created_at | Circle creation time |

## 10. Circle Members Table

The `circle_members` table stores students who join learning circles.

| Column | Description |
|---|---|
| circle_member_id | Unique membership ID |
| circle_id | Related circle |
| user_id | Related student |
| joined_at | Joining time |

A unique constraint prevents the same student from joining the same circle multiple times.

## 11. Database Relationships

```text
users
  |
  +------ user_skills ------ skills
  |
  +------ exchanges
              |
              +------ exchange_sessions
              |
              +------ rescue_requests

users
  |
  +------ circle_members ------ circles