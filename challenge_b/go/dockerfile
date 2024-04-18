# Use official Golang image from Docker Hub
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules and source code to the working directory
COPY . .

# Build the Go app
RUN go build -o backend .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./backend"]
