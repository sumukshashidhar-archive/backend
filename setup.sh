# run ubuntu stuff
sudo apt-get update
sudo apt-get upgrade

# install docker stuff
sudo apt install docker-compose

# init and run submodule
git submodule init
git submodule update

# to generate ENV files and keys and run docker!


# generate public and private RSA keys
cd internal-microservices/authentication-service/src && mkdir keys && cd keys && ssh-keygen -q -N '' -t rsa -b 4096 -m PEM -f private.key && openssl rsa -in private.key -pubout -outform PEM -out public.key && rm private.key.pub && cd ../../../../

# copy public key to the other serivces
## make the hello-service keys folder

mkdir ./internal-microservices/hello-service/src/keys

## copy to the hello service first.
cp ./internal-microservices/authentication-service/src/keys/public.key ./internal-microservices/hello-service/src/keys/public.key


# make the .env files.
## for the auth service
cp ./internal-microservices/authentication-service/src/.env.template ./internal-microservices/authentication-service/src/.env

## for the hello service
cp ./internal-microservices/hello-service/src/.env.template ./internal-microservices/hello-service/src/.env

## for the databases
cp ./databases/mysql/.env.template ./databases/mysql/.env
cp ./databases/mongo/.env.template ./databases/mongo/.env

# for ghost
cp ./external-microservices/ghost/.env.template ./external-microservices/ghost/.env
cp ./external-microservices/mongo-express/.env.template ./external-microservices/mongo-express/.env
cp ./external-microservices/nextcloud/.env.template ./external-microservices/nextcloud/.env
# make data directory locally
mkdir ./data
mkdir ./data/mongod
mkdir ./data/mysqld
mkdir ./data/ghost
mkdir ./data/nextcloud
mkdir ./data/neo4j
mkdir ./data/redis
# nginx certs
cp ./../*.pem ./loadbalancer/certs/


# finally run docker compose lol

docker-compose up