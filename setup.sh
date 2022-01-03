# to generate ENV files and keys and run docker!


# generate public and private RSA keys
cd internal-microservices/authentication-service/src && mkdir keys && cd keys && ssh-keygen -q -N '' -t rsa -b 4096 -m PEM -f private.key && openssl rsa -in private.key -pubout -outform PEM -out public.key && rm private.key.pub && cd ../../../../

# copy public key to the other serivces
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

# make data directory locally
mkdir ./data
mkdir ./data/mongod
mkdir ./data/mysqld
mkdir ./data/ghost


# finally run docker compose lol

docker-compose up