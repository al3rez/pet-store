# Pet Store API

This is a simple pet store REST API that simplifies interaction between pet owners and customers.

## Sign up
Register as a new user

`POST` http://localhost:3000/sign_up?as=:role

#### Path Parameters
| Parameter | Type    | Description    |
| ---- | ------- | -------------- |
| role | String | User role. `pet_owner`, `manager`, `customer`   |

#### Result Format - Sign up
```
{
	"email": "test+customer@gmail.com",
	"role": "customer",
	"created_at": "2018-06-20T20:30:15.425Z",
	"updated_at": "2018-06-20T20:30:15.425Z"
}
```
