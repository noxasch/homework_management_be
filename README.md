# README


## Prerequisites
- Ruby 3+
- Postgresql 15+

## Development Setup in local

1. `git clone` this repo
2. Make sure postgres is running

```sh
# setup project
bin/setup

# prepare database
# bundle exec rails db:create db:migrate db:seeds 
bundle exec rails db:prepare

# run dev server
bundle exec rails server

# run test
bundle exec rspec
```

## Development Setup with docker

```sh
docker-compose up

# running rails console for debugging
docker exec -it homework-be_dev bash
```


## Deployment (docker)


## ERD

![https://www.plantuml.com/plantuml/uml/SyfFKj2rKt3CoKnELR1Io4ZDoSa70000](https://www.plantuml.com/plantuml/svg/VL51JiGm3Bpd5JaZvG_B1N57Uwv2RRQ69AvY1uIw_9rcjm5M4Jrvh1dFECv1r6SjCHXCIlffZuBPBiRUMG9ZdNCLPWvOAqPFeOBPYtnmXW7eXABcoxJvf_ByYgDs5ib7h7NamFcF_f4ZhavltO2Y7oVC0q7jv6gxTL1my5gHabvNooXSyeZ32mMiij-8Un4w9OH_ewQDQ5bQ05FBelHEYh3bYNejicqKIIlJ9nxdm1uG7bQcIvkzJglsW0dgtStbucTsZfUVQvW6BiJIFU5cg2FR7-oQylbcJTDSzaJV)

<details>
<summary>PUML</summary>

```plantuml
@startuml
entity User {
 * id
 ---
 * role
 * email
 * password_digest
}

entity Subject {
 * id
 ---
 * name
 * color
}

entity Homework {
 * id
 ---
 * teacher_id
 * subject_id
 * due_at
 * title
 * resource_file_id
}

entity AssignedHomework {
 * id
 ---
 * homework_id
 * student_id
 * invited_at
 * status
 * submitted_file_id
}

entity UploadedFile {
 * id
 ---
 * path
}
@enduml

User |o--o{ Homework
Homework |o--{ AssignedHomework
User |o--o{ AssignedHomework
Subject |o--o{ Homework
Homework |o--o| UploadedFile
AssignedHomework |o--o| UploadedFile
```

</details>


## API docs

```sh
# get oauth token
POST /oauth/token

```

```js
{
  'email':'email@example.com',
  'password':'PASSWORD',
  'grant_type': 'password'
}
```

#### homeworks

```
GET /api/v1/teachers/homeworks
```

```json
body: {
  "homeworks": [
    {
      "title":"Calculus",
      "subject":"Mathematics",
      "due_date":"25-10-2024",
      "submitted": 3,
      "total": 20
    }
  ],
  "meta": {
    "current_page": 1,
    "next_page": 1,
    "prev_page": null,
    "total_pages": 1,
    "total_count": 6
  }
}
```

<!-- This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->
