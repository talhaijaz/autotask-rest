# AutotaskApi
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'autotask_api'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install autotask_api
```

## Query

See the "Query XML elements and attributes" section of the [Autotask API Users Guide](https://ww4.autotask.net/help/Content/LinkedDOCUMENTS/WSAPI/T_WebServicesAPIv1_5.pdf) for more information.

### Simple field test

SQL:
```sql
firstname = 'Joe'
```

Objects:
```ruby
e1 = AutotaskApi::Expression.new('firstname', 'equals', 'Joe')
c = AutotaskApi::Condition.new(e1)

AutotaskApi::Contact.where(c)
```

Hash:
```ruby
AutotaskApi::Condition.from_hash(
    expressions: [
        { field: 'firstname', operator: 'equals', value: 'Joe' }
    ]
)
```

### Multiple Field Test

SQL:
```sql
firstname = ‘Joe’ AND lastname = ‘Smith’
```

Objects:
```ruby
e1 = AutotaskApi::Expression.new('firstname', 'equals', 'Joe')
e2 = AutotaskApi::Expression.new('lastname', 'equals', 'Smith')
c = AutotaskApi::Condition.new([e1, e2])

AutotaskApi::Contact.where(c)
```

Hash:
```ruby
c = AutotaskApi::Condition.from_hash(
    expressions: [
      { field: 'firstname', operator: 'equals', value: 'Joe' },
      { field: 'lastname', operator: 'equals', value: 'Smith' }
    ]
)

AutotaskApi::Contact.where(c)
```

### Multiple Fields combined with OR

SQL:
```sql
firstname = ‘Joe’ OR lastname = ‘Brown’
```

Objects:
```ruby
e1 = AutotaskApi::Expression.new('firstname', 'equals', 'Joe')
e2 = AutotaskApi::Expression.new('lastname', 'equals', 'Brown')
c = AutotaskApi::Condition.new([e1, e2], 'OR')

AutotaskApi::Contact.where(c)
```

Hash:
```ruby
c = AutotaskApi::Condition.from_hash(
    expressions: [
        { field: 'firstname', operator: 'equals', value: 'Joe' },
        { field: 'lastname', operator: 'equals', value: 'Brown' }
    ],
    operator: 'OR'
)

AutotaskApi::Contact.where(c)
```

### Nested Conditions

SQL:
```sql
(
  firstname = ‘Joe’
  OR
  (
    (firstname = ‘Larry’ and lastname = ‘Brown’)
    OR
    (firstname = ‘Mary’ and lastname = ‘Smith’)
  )
)
# AND city != 'Albany'
```

Objects:
```ruby
e1 = AutotaskApi::Expression.new('firstname', 'equals', 'Larry')
e2 = AutotaskApi::Expression.new('lastname', 'equals', 'Brown')
c1 = AutotaskApi::Condition.new([e1, e2])

e3 = AutotaskApi::Expression.new('firstname', 'equals', 'Mary')
e4 = AutotaskApi::Expression.new('lastname', 'equals', 'Smith')
c2 = AutotaskApi::Condition.new([e3, e4])

c3 = AutotaskApi::Condition.new([c1, c2], 'OR')

e5 = AutotaskApi::Expression.new('firstname', 'equals', 'Joe')
c4 = AutotaskApi::Condition.new([e5, c3], 'OR')

e6 = AutotaskApi::Expression.new('city', 'notequal', 'Albany')
c5 = AutotaskApi::Condition.new([c4, e6])

AutotaskApi::Query.new('contact', c5).fetch
```

Hash:
```
c = AutotaskApi::Condition.from_hash(
    expressions: [
        {
            expressions: [
                { field: 'firstname', operator: 'equals', value: 'Joe' },
                {
                    expressions: [
                        {
                            expressions: [
                                { field: 'firstname', operator: 'equals', value: 'Larry' },
                                { field: 'lastname', operator: 'equals', value: 'Brown' }
                            ]
                        },
                        {
                            expressions: [
                                { field: 'firstname', operator: 'equals', value: 'Marry' },
                                { field: 'lastname', operator: 'equals', value: 'Smith' }
                            ]
                        }
                    ],
                    operator: 'OR'
                }
            ],
            operator: 'OR'
        },
        { field: 'city', operator: 'notequal', value: 'Albany' }
    ]
)

AutotaskApi::Contact.where(c)
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
