# Backend Training session

Pet Project: Blog App (https://employmenthero.atlassian.net/wiki/spaces/GT/pages/3369402701/Pet+Project+Blog+App+-+Detailed+Guide)

## Configuration
1. Clone this repo
2. Open the console and type.
```
bundle install
```

## Database creation
Run command
```
bundle exec rake db:create:all
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

**Delete a Blog (Authenticated, own blog only)**

- DELETE /api/blogs/:id

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

## How to run the test suite
