# SkillSwap Architecture

## 1. Overview

SkillSwap is a Java-based peer-to-peer skill exchange platform for students.

Students can offer skills they know, find students with matching skills, send exchange requests, schedule learning sessions, join learning circles, and track their learning progress.

## 2. Architecture

SkillSwap follows an MVC-style architecture.

```text
User
  |
  v
JSP / HTML / CSS
  |
  v
Jakarta Servlets
  |
  v
DAO Layer
  |
  v
JDBC
  |
  v
MySQL Database