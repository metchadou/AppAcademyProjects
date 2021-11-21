PRAGMA foreign_keys = ON;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  subject_question_id INTEGER NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Seeding database

INSERT INTO
  users(fname, lname)
VALUES
  ('Franklin', 'Adou'),
  ('Eliakym', 'Adou');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Franklin''s question title', 'Franklin''s question body', (SELECT id FROM users WHERE fname = 'Franklin')),
  ('Eliakym''s question title', 'Eliakym''s question body', (SELECT id FROM users WHERE fname = 'Eliakym'));

INSERT INTO
  question_follows(follower_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Franklin'), (SELECT id FROM questions WHERE title = 'Eliakym''s question title')),
  ((SELECT id FROM users WHERE fname = 'Eliakym'), (SELECT id FROM questions WHERE title = 'Franklin''s question title'));

INSERT INTO
  replies(body, author_id, subject_question_id)
VALUES
  ('Franklin replies to Eliakym''s question', (SELECT id FROM users WHERE fname = 'Franklin'), (SELECT id FROM questions WHERE title = 'Eliakym''s question title')),
  ('Eliakym replies to Franklin''s question', (SELECT id FROM users WHERE fname = 'Eliakym'), (SELECT id FROM questions WHERE title = 'Franklin''s question title'));

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Franklin'), (SELECT id FROM questions WHERE title = 'Eliakym''s question title')),
  ((SELECT id FROM users WHERE fname = 'Eliakym'), (SELECT id FROM questions WHERE title = 'Franklin''s question title'));