#!/bin/bash

echo "Testing Eureka Discovery Server..."
curl -s http://localhost:8761/eureka/apps | grep -q "application" && echo "✓ Eureka is up" || echo "✗ Eureka is down"

echo -e "\nTesting API Gateway..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:8081/actuator/health | grep -q "200" && echo "✓ API Gateway is up" || echo "✗ API Gateway is down"

echo -e "\nTesting Authentication Service through API Gateway..."
curl -s -X POST -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","motDePasse":"password123"}' \
  http://localhost:8081/api/auth/login -w "\nStatus: %{http_code}\n"

echo -e "\nTesting Notification Service through API Gateway..."
curl -s -X POST -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","name":"Test User"}' \
  http://localhost:8081/api/notifications/welcome-email -w "\nStatus: %{http_code}\n" 