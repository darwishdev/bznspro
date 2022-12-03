createdb:
	docker exec -it pg_container  createdb --username=root --owner=root bznspro

dropdb:
	docker exec -it pg_container  dropdb  bznspro


migrateinit:
	migrate create -ext sql -dir db/migration -seq init_schema


migratetimestamps:
	migrate create -ext sql -dir db/migration -seq add_default_timstamps


migratefunctions:
	migrate create -ext sql -dir db/migration -seq add_functions
migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/bznspro?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/bznspro?sslmode=disable" -verbose down

refreshdb:
	 make  dropdb && make createdb && make migrateup

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

	
.PHONY: createdb dropdb migratup migratdown migrateinit