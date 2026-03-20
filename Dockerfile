FROM golang:1.25.0 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -o parcel-app

FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /app/parcel-app /app/parcel-app
COPY --from=builder /app/tracker.db /app/tracker.db

CMD ["/app/parcel-app"]