CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(31) NOT NULL,
  lname VARCHAR(31) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(127) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Peter', 'Poole'),
  ('Michael', 'Doliner'),
  ('Mark', 'Schildkret');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Foo0', 'Foo text 0?', (SELECT id FROM users WHERE fname = 'Peter')),
  ('Foo1', 'Foo text 1?', (SELECT id FROM users WHERE fname = 'Peter')),
  ('Foo2', 'Foo text 2?', (SELECT id FROM users WHERE fname = 'Michael')),
  ('Foo3', 'Foo text 3?', (SELECT id FROM users WHERE fname = 'Mark')),
  ('Foo4', 'Foo text 4?', (SELECT id FROM users WHERE fname = 'Michael'));

INSERT INTO
  question_followers (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Peter'), (SELECT id FROM questions WHERE title = 'Foo0')),
  ((SELECT id FROM users WHERE fname = 'Peter'), (SELECT id FROM questions WHERE title = 'Foo3')),
  ((SELECT id FROM users WHERE fname = 'Michael'), (SELECT id FROM questions WHERE title = 'Foo1')),
  ((SELECT id FROM users WHERE fname = 'Michael'), (SELECT id FROM questions WHERE title = 'Foo2')),
  ((SELECT id FROM users WHERE fname = 'Michael'), (SELECT id FROM questions WHERE title = 'Foo4')),
  ((SELECT id FROM users WHERE fname = 'Mark'), (SELECT id FROM questions WHERE title = 'Foo0')),
  ((SELECT id FROM users WHERE fname = 'Mark'), (SELECT id FROM questions WHERE title = 'Foo4')),
  ((SELECT id FROM users WHERE fname = 'Mark'), (SELECT id FROM questions WHERE title = 'Foo3'));

INSERT INTO
  replies (body, user_id, question_id, parent_reply_id)
VALUES
  ('Body 01', (SELECT id FROM users WHERE fname = 'Peter'), (SELECT id FROM questions WHERE title = 'Foo0'), NULL);

INSERT INTO
  replies (body, user_id, question_id, parent_reply_id)
VALUES
  ('Body 02', (SELECT id FROM users WHERE fname = 'Mark'), (SELECT id FROM questions WHERE title = 'Foo0'), (SELECT id FROM replies WHERE body = 'Body 01')),
  ('Body 03', (SELECT id FROM users WHERE fname = 'Michael'), (SELECT id FROM questions WHERE title = 'Foo0'), (SELECT id FROM replies WHERE body = 'Body 01'));

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Peter'), (SELECT id FROM questions WHERE title = 'Foo0')),
  ((SELECT id FROM users WHERE fname = 'Peter'), (SELECT id FROM questions WHERE title = 'Foo1'));
