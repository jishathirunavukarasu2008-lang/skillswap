CREATE DATABASE IF NOT EXISTS skillswap;
USE skillswap;

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    bio VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS user_skills (
    user_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    skill_id INT NOT NULL,
    skill_type ENUM('OFFER', 'WANT') NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (skill_id)
        REFERENCES skills(skill_id)
        ON DELETE CASCADE,
    UNIQUE (user_id, skill_id, skill_type)
);

CREATE TABLE IF NOT EXISTS exchanges (
    exchange_id INT AUTO_INCREMENT PRIMARY KEY,
    requester_id INT NOT NULL,
    receiver_id INT NOT NULL,
    offered_skill_id INT NOT NULL,
    wanted_skill_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (requester_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (receiver_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (offered_skill_id)
        REFERENCES skills(skill_id)
        ON DELETE CASCADE,
    FOREIGN KEY (wanted_skill_id)
        REFERENCES skills(skill_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exchange_sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    exchange_id INT NOT NULL,
    scheduled_date DATE NOT NULL,
    scheduled_time TIME NOT NULL,
    topic VARCHAR(255) NOT NULL,
    duration_minutes INT DEFAULT 60,
    status VARCHAR(20) DEFAULT 'SCHEDULED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (exchange_id)
        REFERENCES exchanges(exchange_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rescue_requests (
    rescue_id INT AUTO_INCREMENT PRIMARY KEY,
    exchange_id INT NOT NULL,
    requester_id INT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN',
    replacement_user_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (exchange_id)
        REFERENCES exchanges(exchange_id)
        ON DELETE CASCADE,
    FOREIGN KEY (requester_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (replacement_user_id)
        REFERENCES users(user_id)
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS circles (
    circle_id INT AUTO_INCREMENT PRIMARY KEY,
    circle_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS circle_members (
    circle_member_id INT AUTO_INCREMENT PRIMARY KEY,
    circle_id INT NOT NULL,
    user_id INT NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (circle_id)
        REFERENCES circles(circle_id)
        ON DELETE CASCADE,
    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,
    UNIQUE (circle_id, user_id)
);
