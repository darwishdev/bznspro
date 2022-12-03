-- name: CreatedRole :exec
SELECT role_insert($1 , $2);


-- name: GetdRole :one
SELECT * FROM roles
WHERE role_id = $1 AND delete_at IS NULL;

-- name: GetdRoleForUpdate :one
SELECT * FROM roles
WHERE role_id = $1 AND delete_at IS NULL  LIMIT 1
FOR NO KEY UPDATE;

-- name: Listroles :many
SELECT * FROM roles WHERE delete_at IS NULL 
ORDER BY role_id
LIMIT $1
OFFSET $2;

-- name: UpdatedRole :one
UPDATE roles
SET "title" = $2
WHERE role_id = $1
RETURNING *;


-- name: DeletedRole :one
UPDATE roles
SET delete_at = now()
WHERE role_id = $1
RETURNING *;