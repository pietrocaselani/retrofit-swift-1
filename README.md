# Retrofit

Currently in development.

## Example

```swift
// sourcery: client = "DefaultClient"
protocol JokesService: Service {
    
    // sourcery: path = "jokes/random"
    // sourcery: method = "GET"
    func fetchRandomJoke() -> AnyPublisher<Joke, Error>

    // sourcery: path = "jokes/random"
    // sourcery: method = "GET"
    func fetchRandomJoke(from category: Query<String>) -> AnyPublisher<Joke, Error>
    
    // sourcery: path = "jokes/random"
    // sourcery: method = "GET"
    func fetchAllJokes() -> AnyPublisher<[Joke], Error>
    
    // sourcery: path = "jokes/categories"
    // sourcery: method = "GET"
    func fetchAllCategories() -> AnyPublisher<[String], Error>
    
    // sourcery: path = "jokes/search"
    // sourcery: method = "GET"
    func fetchJokes(matching query: Query<String>) -> AnyPublisher<[Joke], Error>

    // sourcery: path = "jokes"
    // sourcery: method = "POST"
    func createJoke(newJoke: Body<NewJoke>) -> AnyPublisher<Joke, Error>
    
    // sourcery: path = "jokes/<id>"
    // sourcery: method = "PUT"
    func updateJoke( id: Path<String>, updatedJoke: Body<UpdateJoke>) -> AnyPublisher<Joke, Error>
}
```
