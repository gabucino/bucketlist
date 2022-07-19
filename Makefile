
postgres:
	docker run --name my_postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -d postgres:14-alpine
createdb:
	docker exec -it my_postgres createdb --username=root --owner=root bucketlist

dropdb:
	docker exec -it my_postgres dropdb bucketlist

migrateup:
	migrate -path db/migration/ -database "postgresql://root:root@localhost:5432/bucketlist?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration/ -database "postgresql://root:root@localhost:5432/bucketlist?sslmode=disable" -verbose down

.PHONY: postgres createdb dropdb migrateup migratedown
