# AppSync Lambda

An example Backend architecture that uses AppSync for a fully
managed GraphQL API and Lambda for serverless functions.

## GraphQL Schema

```graphql
schema {
  query: Query
}

type Query {
  hello: String
}
```

## Hello Resolver

The `hello` field resolves by invoking a serverless function.

```golang
package main

import (
    "github.com/aws/aws-lambda-go/lambda"
)

func hello() (string, error) {
    return "Hello, world!", nil
}

func main() {
    lambda.Start(hello)
}
```

## License

This project is __FREE__ to use, reuse, remix, and resell.
This is made possible by the [MIT license](/LICENSE).
