postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=yoonjongok -e POSTGRES_PASSWORD=12345 -d postgres:15-alpine
createdb:
	docker exec -it postgres15 createdb --username=yoonjongok --owner=yoonjongok simple_bank

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://yoonjongok:12345@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://yoonjongok:12345@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test

