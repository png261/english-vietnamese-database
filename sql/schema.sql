DROP TABLE IF EXISTS words;
DROP TABLE IF EXISTS explains;
DROP TABLE IF EXISTS examples;
DROP TABLE IF EXISTS wordsExplains;
DROP TABLE IF EXISTS explainsExamples;

CREATE TABLE words (
    word_id INTEGER NOT NULL PRIMARY KEY,
    word VARCHAR(255) NOT NULL,
    pronounce VARCHAR(255)
);

CREATE TABLE explains (
    explain_id INTEGER NOT NULL PRIMARY KEY,
    type VARCHAR(255),
    meaning VARCHAR(255)
);

CREATE TABLE examples (
    example_id INTEGER NOT NULL PRIMARY KEY,
    example VARCHAR(255),
    translate VARCHAR(255)
);

CREATE TABLE words_explains (
    words_explains_id INTEGER NOT NULL PRIMARY KEY,
    word_id INTEGER NOT NULL,
    explain_id INTEGER NOT NULL,
    FOREIGN KEY (word_id) REFERENCES words(word_id),
    FOREIGN KEY (explain_id) REFERENCES explains(explain_id)
);

CREATE TABLE explains_examples (
    explains_examples_id INTEGER NOT NULL PRIMARY KEY,
    explain_id INTEGER NOT NULL,
    example_id INTEGER NOT NULL,
    FOREIGN KEY (explain_id) REFERENCES explains(explain_id),
    FOREIGN KEY (example_id) REFERENCES examples(example_id)
);
