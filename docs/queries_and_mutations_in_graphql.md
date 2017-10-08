# Using Graphql on the Client Side with Apollo Client and ReactJS

These are the spark notes of how to consume a GraphQL API on the client side using Apollo Client within ReactJS.

## Getting Apollo Into Your App


## Making Queries

Queries are graphql lingo for http get requests to the graphql api.

sample query to send to the api: 
Note that the syntax dictacts the shape of the json object(s) that will be returned.

```javascript
query AllLinks {
  allLinks {
    id
    createdAt
    description
    url
  }
}
```

How to query data in your actual javascript:
There are 2 Ways 

1. Use the query method on the apollo client directly: (don't use this way unless way 2 doesn't work)
This is a more imparitive way and allows to process the responses as a promise
``` javascript
client.query({
  query: gql`
    query AllLinks {
      allLinks {
        id
      }
    }
    `
}).then(response => console.log(response.data.allLinks));
```

2. A more idomatic way is to use Apollo's higher level component, GraphQL, to wrap your component with a query.
-write the graphql query and GraphQL will fetch the data under the hood and make the data available to your component as props.


The Steps:
1. write the query as a JS constant using the GQL parser function.  GQL comes from a node_module called gql-tag.  gql-tag takes a string literal and turns it into a graphql AST
2. use the graphql container component to wrap your component with a query.
3. lastly access the query through the props of the component. 


```javascript
const ALL_LINKS_QUERY = gql`
  query AllLinksQuery { //Operation name
    allLinks {
      id
      createdAt
      url
      description
    }
  }
`;
```

GraphQL container, option is passed to function call will dictate the name of prop to be injected into the component.
```javascript
export default graphql(ALL_LINKS_QUERY, { name: 'allLinksQuery' })(LinkList)
```

Required imports:
```javascript
import { graphql, gql } from 'react-apollo';
```

In general, the process for you to add some data fetching logic will be very similar every time:
1. write the query as a JS constant using the gql parser function
2. use the graphql container to wrap your component with the query
3. access the query results in the component’s props

### How to Make a Query - An Idomatic Example

Starting with a lower-order react component.

```javascript
import React, { Component } from 'react'

class Link extends Component {
  // note that Link expects a link attribute in its props.
  render() {
    return (
      <div>
        <div>{this.props.link.description} ({this.props.link.url})</div>
      </div>
    )
  }

}

export default Link
```

And a lower-order component to display all the links:
```javascript
import React, { Component } from 'react'
import Link from './Link'

class LinkList extends Component {

  render() {
    //note linksToRender are not defined properly here
    //without graphql you would need to pass theses down in your redux container or pass them in directly from a parent component.
    return (
      <div>
        {linksToRender.map(link => (
          <Link key={link.id} link={link}/>
        ))}
      </div>
    )
  }

}

export default LinkList
```

Import the required dependencies:
```javascript
import { graphql, gql } from 'react-apollo'
```

Write the query using gql parsing funciton
```javascript
const ALL_LINKS_QUERY = gql`
  query AllLinksQuery {
    allLinks {
      id
      createdAt
      url
      description
    }
  }
`
```

Wrap the react component with a graphql container:
apollo will do two things: 
1. inject a function into the components props that when executed will make the http request/query.
2. make the results of the query available to the componet in the components props.

```javascript
export default graphql(ALL_LINKS_QUERY, { name: 'allLinksQuery' }) (LinkList)

//annoated
export default graphql(NAME_OF_QUERY, { name: 'nameOfQueryToBeUsedInTheComponent'})(TheComponent)
```

You now have access to the query results and can access them as follows
```javascript
import React, { Component } from 'react'
import Link from './Link'

class LinkList extends Component {

 render() {

  const linksToRender = this.props.allLinksQuery.allLinks //same name as the one in the container wrapper function.

  return (
    <div>
      {linksToRender.map(link => (
        <Link key={link.id} link={link}/>
      ))}
    </div>
  )
}

}

```
Cool things that are also provided are the loading and error attributes on allLinksQuery which can be used like so to show loading and error info:
```javascript
if (this.props.allLinksQuery && this.props.allLinksQuery.loading) {
      return <div>Loading</div>;
}

if (this.props.allLinksQuery && this.props.allLinksQuery.error) {
  return <div>Error</div>;
}
```

All together your React Componet with a graphql container will look like this:

```javascript
import React, { Component } from 'react';
import { graphql, gql } from 'react-apollo';
import Link from './Link';

class LinkList extends Component {

  render() {
    if (this.props.allLinksQuery && this.props.allLinksQuery.loading) {
      return <div>Loading</div>;
    }

    if (this.props.allLinksQuery && this.props.allLinksQuery.error) {
      return <div>Error</div>;
    }

    const linksToRender = this.props.allLinksQuery.allLinks;

    return (
      <div>
        {linksToRender.map(link => (
          <Link key={link.id} link={link}/>
        ))}
      </div>
    );
  }
}

// This can be imported from a queries file.
const ALL_LINKS_QUERY = gql`
  query AllLinksQuery {
    allLinks {
      id
      createdAt
      url
      description
    }
  }
`;

export default graphql(ALL_LINKS_QUERY, { name: 'allLinksQuery' })(LinkList)
```

Note that is is enough to have the query be executed on rendering of the component.

## Mutations

A mutation is graphql lingo for put, patch, delete, and create  requests

### How to Send a Mutation - Simple example

Starting with a lower-order react component:
```javascript
function ExampleComonent() {
  return <h1>I'm an example!</h1>
}
```
0. require your depenencies from react-apollo
```javascript
import { graphql, gql } from 'react-apollo'
```

1. write the mutation as a JS constant using the gql parser function, this will automagically create a network request for you.  It comes with lots of optimizations and performance enhancers.

```javascript
const EXAMPLE_MUTATION = gql`
  mutation example {
    exampleMutation
  }
`
```

2. use the graphql container to wrap your component with the mutation, this will make the mutation function available to the component in the components props.
```
graphql(EXAMPLE_MUTATION)(ExampleComponent);
```

3. use the mutation function that gets injected into the component's props
```javascript
function ExampleComponent({ mutate }) {
  return (
    <div>
      <h1>I'm an example!</h1>
      <button onClick={function () { mutate().then(() => { console.log('HELLO')})}}>Click Me</button>
    </div>
  )
}
```
The onClick callback willnow execute the mutation.

### How to Send Mutation - An Idomatic Example:

#### The Steps:
1. write the mutation as a JS constant using the gql parser function
2. use the graphql container to wrap your component with the mutation
3. use the mutation function that gets injected into the component’s props

required dependencies:
```javascript
import { graphql, gql } from 'react-apollo'
```

The mutation:
```javascript
const CREATE_LINK_MUTATION = gql`
  # 2
  mutation CreateLinkMutation($description: String!, $url: String!) {
    createLink(
      description: $description, // required arguements for function
      url: $url,  // required arguemnts for function
    ) {
      id
      createdAt
      url
      description
    }
  }
`

```

wraping the react component in a graphql container
```javascript
//this combines the CreateLink component with the CREATE_LINK_MUTATION
export default graphql(CREATE_LINK_MUTATION, { name: 'createLinkMutation' })(CreateLink); 

//annotated
export default graphql('NAME_OF_MUTATION', { name: 'name of function that will injected into CreateLink's props'})('TheComponetYouAreWrapping')
```

using the mutation:

all you need to do is pass in the variables that represent the user input into the function injected into the components props by apollo.
```javascript
_createLink = async () => {
  const { description, url } = this.state
  await this.props.createLinkMutation({
    variables: {
      description,
      url
    }
  })
}
```

All together your react create link component with a graphql mutation provided by apollo will look like this:

```javascript
import React, { Component } form 'react';
import { graphql, gql } from 'react-apollo';

class CreateLink extends Component {

  state = {
    description: '',
    url: ''
  }

  render() {
    return (
      <div>
        <div className='flex flex-column mt3'>
          <input
            className='mb2'
            value={this.state.description}
            onChange={(e) => this.setState({ description: e.target.value })}
            type='text'
            placeholder='A description for the link'
          />
          <input
            className='mb2'
            value={this.state.url}
            onChange={(e) => this.setState({ url: e.target.value })}
            type='text'
            placeholder='The URL for the link'
          />
        </div>
        <button
          onClick={() => this._createLink()} // Where the create link mutation is called.
        >
          Submit
        </button>
      </div>
    )
  }

_createLink = async () => {
  //grabing the user input from the component state
  const { description, url } = this.state
  //sending off the mutation asynchronously
  await this.props.createLinkMutation({
    variables: {
      description,
      url
    }
  })
}
}

// The mutation - this can be imported from common mutations file.
// gql is a function provided by react-apollo that will lex and parse your graphql mutation.
const CREATE_LINK_MUTATION = gql`
  mutation CreateLinkMutation($description: String!, $url: String!) {
    createLink(
      description: $description, // required arguements for function
      url: $url,  // required arguemnts for function
    ) {
      id
      createdAt
      url
      description
    }
  }
`

//wraping the react component in a graphql container and making a 'createLinkMutation' function available in the components props.
export default graphql(CREATE_LINK_MUTATION, { name: 'createLinkMutation' })(CreateLink);
```

You can now render <CreateLink /> in App.js or other views as follows:
```javascript
render() {
  return (
    <CreateLink />
  )
}
```

## Routing

### Questions
What is graphcoolbin doing and why does it need authentication?
a: provides starter schema downloaded from online

Is there vscode plugins for graphql?

What does create-react-app actually do i.e. the details?

"Note: The project that was generated by create-react-app uses semicolons and double quotes for strings. All the code that you’re going to add will use no semicolons and single quotes."  -why???

What does registerServiceWorker do?

What is the life cycle flow of components wrapped with queries?
When do the queries get invoked?
How do you dicate when and which queries get invoked?

Learn intimately what javascript async and await do.

Does gql come from react-apollo or graphql-tag?

### Bugs
  {master} graphql_workspace$ open project.graphcool 
  No application knows how to open /Users/johnschoeman/workspace/graphql_workspace/project.graphcool.

  You cannot have queries and mutations in the same playground query.

  ```npm install -g create-react-app```
  Do not forget the -g


### Notes
npm add is an alias for npm install

### Useful commands


```graphcool init --schema https://graphqlbin.com/hn-starter.graphql --name Hackernews```
```graphcool playground```  

```npm install -g create-react-app```