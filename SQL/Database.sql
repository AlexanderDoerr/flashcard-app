CREATE DATABASE Flashcards;
\c Flashcards;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE Categories (
    id uuid primary key default uuid_generate_v4(),
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Users (
    id uuid primary key default uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Flashcards (
    id uuid primary key default uuid_generate_v4(),
    question VARCHAR(255) NOT NULL,
    answer VARCHAR(255) NOT NULL,
    category_id uuid references Categories(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Flashcard_Association (
    id uuid primary key default uuid_generate_v4(),
    flashcard_id uuid references Flashcards(id),
    user_id uuid references Users(id)
);

INSERT INTO Categories (name) 
VALUES 
    ('OOP'),
    ('C#'), 
    ('SQL'),
    ('React');

INSERT INTO Users (name, email) VALUES ('Admin', 'admin@gmail.com');

INSERT INTO Flashcards (question, answer, category_id)
VALUES 
    ('What is polymorphism?', 'Polymorphism is the ability of an object to take on many forms.', (SELECT id FROM Categories WHERE name = 'OOP')),
    ('What is inheritance?', 'Inheritance is a mechanism where a new class inherits properties and behavior from an existing class.', (SELECT id FROM Categories WHERE name = 'OOP')),
    ('What is encapsulation?', 'Encapsulation is the concept of wrapping data and methods that operate on the data within a single unit or class.', (SELECT id FROM Categories WHERE name = 'OOP'));

INSERT INTO Flashcards (question, answer, category_id)
VALUES 
    ('What is a delegate in C#?', 'A delegate is a type that represents references to methods with a particular parameter list and return type.', (SELECT id FROM Categories WHERE name = 'C#')),
    ('What is LINQ?', 'LINQ (Language Integrated Query) is a Microsoft .NET Framework component that adds native data querying capabilities to .NET languages.', (SELECT id FROM Categories WHERE name = 'C#')),
    ('What is the difference between an abstract class and an interface?', 'An abstract class can have implementations for some of its members, but an interface cannot have any implementation.', (SELECT id FROM Categories WHERE name = 'C#'));

INSERT INTO Flashcards (question, answer, category_id)
VALUES 
    ('What is a primary key?', 'A primary key is a field in a table which uniquely identifies each row/record in that table.', (SELECT id FROM Categories WHERE name = 'SQL')),
    ('What is a foreign key?', 'A foreign key is a field (or collection of fields) in one table that uniquely identifies a row of another table.', (SELECT id FROM Categories WHERE name = 'SQL')),
    ('What is a JOIN?', 'A JOIN clause is used to combine rows from two or more tables, based on a related column between them.', (SELECT id FROM Categories WHERE name = 'SQL'));

INSERT INTO Flashcards (question, answer, category_id)
VALUES 
    ('What is JSX?', 'JSX is a syntax extension for JavaScript that looks similar to XML or HTML and is used with React to describe what the UI should look like.', (SELECT id FROM Categories WHERE name = 'React')),
    ('What are hooks in React?', 'Hooks are functions that let you use state and other React features without writing a class.', (SELECT id FROM Categories WHERE name = 'React')),
    ('What is the virtual DOM?', 'The virtual DOM is a programming concept where a virtual representation of the UI is kept in memory and synced with the real DOM by a library such as React.', (SELECT id FROM Categories WHERE name = 'React'));

INSERT INTO Flashcard_Association (flashcard_id, user_id)
SELECT f.id, u.id
FROM Flashcards f, Users u
WHERE u.name = 'Admin' AND f.question IN (
    'What is polymorphism?',
    'What is inheritance?',
    'What is encapsulation?',
    'What is a delegate in C#?',
    'What is LINQ?',
    'What is the difference between an abstract class and an interface?',
    'What is a primary key?',
    'What is a foreign key?',
    'What is a JOIN?',
    'What is JSX?',
    'What are hooks in React?',
    'What is the virtual DOM?'
);


/* SELECT specifies the columns you want to return */
/* FROM specifies the primary table, in this case Flashcards, because that is where most of the data is coming from */
/* First INNER JOIN joins Flashcards with Flashcard_Association on the flashcard_id, ensuring only matching rows are returned */
/* Second INNER JOIN joins Users with Flashcard_Association on the user_id, ensuring only matching rows are returned */
/* This will allow the query to return relevant rows and only the specified columns from each table */
SELECT f.question, f.answer, u.name
FROM Flashcards f
INNER JOIN Flashcard_Association fa ON f.id = fa.flashcard_id
INNER JOIN Users u ON u.id = fa.user_id;