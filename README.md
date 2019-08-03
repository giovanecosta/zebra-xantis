# zebra-xantis
Just a sample project for job application purposes

## Project setup

### Install Docker

#### Automatic (Ubuntu Only!)
```
./install_docker.sh
```
*This script will install Docker and Docker Compose. If you wish to remove them after use, run `./uninstall_docker.sh`

#### Manual

Install Docker and Docker Compose:

https://docs.docker.com/install/

https://docs.docker.com/compose/install/

### Run Docker containers and setup commands

After install docker and docker-compose porperly, you must be ready to execute the following commands

```
docker-compose build
docker-compose run --rm --no-deps --entrypoint "" back mix deps.get
docker-compose run --rm --entrypoint "" back mix ecto.create
docker-compose run --rm --entrypoint "" back mix ecto.migrate
```
(Some warns are expected)

## Run App
```
docker-compose up
```
And in another terminal window:
```
docker-compose exec back phx.server
```
App will be running on http://localhost:4000

## Run Tests
```
docker-compose up
```
And in another terminal window:
```
docker-compose exec back mix test
```
# API Doc

Partner API Documentation can be read here: https://github.com/giovanecosta/zebra-xantis/blob/master/back/docs/api.md

# Performance

I've written a script that generate 5 million partners in a 4.000.000 Km² square for performance tests.
![Brazil square area](https://raw.githubusercontent.com/giovanecosta/zebra-xantis/blob/master/square_area.jpeg)

To run the script (warning: takes ~ 2 hours to run):

```
docker-compose exec back mix run priv/repo/seeds.exs
```
Fortunately, i've already a server running on an AWS t3.micro instance. It can be accessed here:

http://ec2-54-233-183-233.sa-east-1.compute.amazonaws.com:4000/

After that, requests with location had the following results:
![Api response time](https://raw.githubusercontent.com/giovanecosta/zebra-xantis/blob/master/api_response_time.jpeg)
