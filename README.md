# Restaurant Discovery API

### Table Of Contents

* [Create User](#create-user)


## Create User

### Request

```http
POST /api/v1/users/create
```

Creates the user and returns the Authentication token


| Parameter | Type | Description |
| :--- | :--- | :--- |
| `email` | `string` | **Required**. Unique email addresss are only valid |
| `password` | `string` | **Required** |

### Response

| Field | Type |
| :--- | :--- | 
| `email` | `string` | 
| `token` | `string` | 

#### Successful Response

##### Status code `200`

```
{ 
  "email": "drew@yahoo.com",
  "token": "abc.def.ghi"
}
```

### Error Response

##### Bad Request 
##### Status code `400`

```
{"error": "Error msg" }
```
