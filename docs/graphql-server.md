## GraphQL Server Notes

### Questions

what does 
```ruby
has_secure_password
```
in the user model do and where does it come from?

----

```ruby
result = SpotmeSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
```
What is this doing? is this meta-progamming? can i find a way to get keys expressed in camelCase and not snake_case?

----

What is the best whay to implement dateTime with graphql server?

----

is there not a better way to input type arguments?  currently you need to write them in three different places.

---
### Bugs

Do not forget to set the context of the gql server in the graphql controller.

----

using an update mutation: args is a weird object
[source code](https://github.com/rmosolgo/graphql-ruby/blob/master/lib/graphql/query/arguments.rb)
____ 

NoMethodError (undefined method `id' for true:TrueClass):

app/controllers/graphql_controller.rb:10:in `execute'

---