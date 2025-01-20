# Backend Training session

Pet Project: Blog App (https://employmenthero.atlassian.net/wiki/spaces/GT/pages/3369402701/Pet+Project+Blog+App+-+Detailed+Guide)

## Configuration
1. Clone this repo
2. Open the console and run the below command.
```
bundle install
```

## Database creation
Run command
```
bundle exec rake db:create:all
bundle exec rake db:migrate
```

## APIs:

**Sign Up**

- POST /api/users

- Request body:
```
{ 
  "user": { 
    "email": "user@example.com", 
    "password": "password",
    "password_confirmation": "password" 
  } 
}
```

https://github.com/user-attachments/assets/d21de155-e2c5-4e98-a6dd-7ecb0e3958e6


**Sign In**

- POST /api/users/sign_in

- Request body:
```
{ 
  "user": { 
    "email": "user@example.com", 
    "password": "password" 
  } 
}
```

https://github.com/user-attachments/assets/8622db80-ca7b-4e10-a95c-64d0475ced67

**Create a Blog (Authenticated)**

- POST /api/blogs

- Request body:
```
{
  "blog": {
    "title": "Blog Post Title",
    "content": "This is the content of the blog post."
  }
}
```


https://github.com/user-attachments/assets/d6885d56-841c-4ea1-89f8-659c819c1848

**Get All Blogs**

- GET /api/blogs

- Response:
```
{
  data: [
      {
        "id": 1,
        "title": "Blog Post Title",
        "content": "This is the content of the blog post.",
        "user_id": 1,
        "created_at": "2025-01-01T00:00:00Z",
        "updated_at": "2025-01-01T00:00:00Z"
      }
  ]
}
```

https://github.com/user-attachments/assets/e39deffc-7096-4774-8f98-f0d3c804216d


**Get a Specific Blog by ID**

- GET /api/blogs/:id

- Response:
```
{
  data: {
    "id": 1,
    "title": "Blog Post Title",
    "content": "This is the content of the blog post.",
    "user_id": 1,
    "created_at": "2025-01-01T00:00:00Z",
    "updated_at": "2025-01-01T00:00:00Z"
  }
}
```


https://github.com/user-attachments/assets/c2455db3-914c-4653-a6af-82842b542e99


**Update a Blog (Authenticated, own blog only)**

- PUT /api/blogs/:id

- Request body:
```
{
  "blog": {
    "title": "Updated Blog Post Title",
    "content": "This is the updated content of the blog post."
  }
}
```


https://github.com/user-attachments/assets/b0f4d721-5fc4-4984-bbcf-4103f400bc78


**Delete a Blog (Authenticated, own blog only)**

- DELETE /api/blogs/:id


https://github.com/user-attachments/assets/de90d927-b080-4d12-a46e-4ae1d1fb7fa8


**Create a Comment (Authenticated)**

- POST /api/blogs/:blog_id/comments

- Request body:
```
{
  "comment": {
    "content": "This is a comment on the blog post."
  }
}
```


https://github.com/user-attachments/assets/0bcc5f03-bb0f-4c8f-925b-d3c86fd618d7


**Get All Comments for a Blog**

- GET /api/blogs/:blog_id/comments

- Response:
```
{
  data: [
    {
      "id": 1,
      "content": "This is a comment on the blog post.",
      "user_id": 1,
      "blog_id": 1,
      "created_at": "2025-01-01T00:00:00Z",
      "updated_at": "2025-01-01T00:00:00Z"
    }
  ]
}
```

https://github.com/user-attachments/assets/8999d08c-f265-4a27-9a46-c62df2cb1edc

## How to run the test suite

```
bundle exec rspec
```
