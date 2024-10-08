sudo -u postgres psql
CREATE DATABASE ozon;

CREATE USER user_db WITH PASSWORD '1234';
ALTER DATABASE ozon OWNER TO user_db;
GRANT ALL PRIVILEGES ON DATABASE ozon TO user_db;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO user_db;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO user_db;

\q
psql -h localhost -U user_db -d ozon
1234
CREATE TABLE users (
    id VARCHAR(36) PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);


CREATE TABLE posts (
    id VARCHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    allow_comments BOOLEAN NOT NULL DEFAULT TRUE, 
    user_id VARCHAR(36) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE comments (
    id VARCHAR(36) PRIMARY KEY,
    text VARCHAR(2000) NOT NULL,                  
    post_id VARCHAR(36) REFERENCES posts(id) ON DELETE CASCADE,
    parent_id VARCHAR(36) REFERENCES comments(id) ON DELETE CASCADE DEFAULT NULL,
    user_id VARCHAR(36) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (id, username, password) VALUES
('123e4567-e89b-12d3-a456-426614174000', 'user1', 'password1'),
('123e4567-e89b-12d3-a456-426614174001', 'user2', 'password2'),
('123e4567-e89b-12d3-a456-426614174002', 'user3', 'password3'),
ON CONFLICT (id) DO NOTHING;



INSERT INTO posts (id, title, content, allow_comments, user_id) VALUES
('123e4567-e89b-12d3-a456-426614174100', 'Post 1', 'Content of post 1', TRUE, '123e4567-e89b-12d3-a456-426614174000'),
('123e4567-e89b-12d3-a456-426614174101', 'Post 2', 'Content of post 2', FALSE, '123e4567-e89b-12d3-a456-426614174001'),
('123e4567-e89b-12d3-a456-426614174102', 'Post 3', 'Content of post 3', TRUE, '123e4567-e89b-12d3-a456-426614174002'),
ON CONFLICT (id) DO NOTHING;


INSERT INTO comments (id, text, post_id, parent_id, user_id) VALUES
('123e4567-e89b-12d3-a456-426614174200', 'Comment 1 on post 1', '123e4567-e89b-12d3-a456-426614174100', NULL, '123e4567-e89b-12d3-a456-426614174001'),
('123e4567-e89b-12d3-a456-426614174201', 'Reply to Comment 1', '123e4567-e89b-12d3-a456-426614174100', '123e4567-e89b-12d3-a456-426614174200', '123e4567-e89b-12d3-a456-426614174002'),
('123e4567-e89b-12d3-a456-426614174202', 'Comment 1 on post 3', '123e4567-e89b-12d3-a456-426614174102', NULL, '123e4567-e89b-12d3-a456-426614174000'),
ON CONFLICT (id) DO NOTHING;

