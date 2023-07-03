import { ApolloClient, InMemoryCache, createHttpLink } from "@apollo/client";
import { setContext } from "@apollo/client/link/context";

const httpLink = createHttpLink({
  uri: "http://localhost:1337/graphql",
//  uri: "http://3.87.96.160:1337/graphql",
});

const authLink = setContext((_, { headers }) => {
  // get the authentication token from local storage if it exists
  const token =
    "2488819c5478a084e2d45c1c7cc695bc467270925b823bf1763b108a0d0aeba840953746f30b5ecc274ffac794ea42fb0cad2b84593812cdb90a863e99dd30032d1533b7c73ea0b0a9fe7fb869a26b47497a2cd026f2e503b20dc8cd7a2014734abe5bc9955db1bc7596d099a1f52fac1452d2bf687ae242ab19729411cad445";
  /* const token = localStorage.getItem("token"); */
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : "",
    },
  };
});

export const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
});
