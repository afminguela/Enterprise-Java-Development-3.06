# Enterprise Java Development 3.06

An exercise project focusing on Spring Boot JPA modeling and database relationships for Enterprise Java Development.

## Overview

This project is an educational exercise that demonstrates advanced JPA concepts including entity relationships, inheritance strategies, and the differences between JPQL and native SQL. The exercise consists of three main components as outlined in the project requirements.

## Exercise Requirements

Based on `task/instructions.txt`, this project implements the following requirements:

### 1. Task Management System
Model the relationships of a Task Management software using Spring JPA with the following requirements:
- **Tasks** have a title, dueDate and a boolean status
- **Two types of tasks**: BillableTask and InternalTask  
- **BillableTask** have an additional hourlyRate attribute

### 2. PR Company System (To be implemented)
Model the relationships of a PR company using Spring JPA with the following requirements:
- Database consists of **Contacts** with name, title and company
- **Names** are their own object with firstName, lastName, middleName and salutation
- Names should be **embedded** within the Contact entity (not stored in separate table)

### 3. SQL vs JPQL Analysis (To be documented)
List 3 tasks that can be accomplished with native SQL that cannot be done with JPQL, with explanations of why native SQL would be chosen over JPQL for these specific tasks.

## Project Structure

```
task/
├── src/
│   ├── main/
│   │   ├── java/com/taskjava/task/
│   │   │   ├── TaskApplication.java          # Spring Boot main application
│   │   │   └── models/
│   │   │       ├── Task.java                 # Abstract base entity
│   │   │       ├── BillableTask.java         # Billable task implementation
│   │   │       ├── InternalTask.java         # Internal task implementation
│   │   │       └── TaskPriority.java         # Priority enumeration
│   │   └── resources/
│   │       └── application.properties        # Spring configuration
│   └── test/
│       └── java/com/taskjava/task/
│           └── TaskApplicationTests.java     # Basic application tests
├── pom.xml                                   # Maven dependencies and configuration
└── instructions.txt                          # Original exercise requirements
```

## Technologies Used

- **Spring Boot 3.5.4** - Main framework
- **Spring Data JPA** - Data persistence layer  
- **MySQL Connector** - Database connectivity
- **Lombok** - Reducing boilerplate code
- **Jakarta Persistence API** - JPA 3.0 specification
- **Maven** - Build and dependency management
- **Java 17** - Programming language version

## Current Implementation Status

### ✅ Completed Features
- [x] Project structure and Spring Boot setup
- [x] Maven configuration with required dependencies
- [x] Task entity hierarchy with inheritance strategy
- [x] BillableTask with hourly rate functionality
- [x] InternalTask with department and priority
- [x] TaskPriority enumeration
- [x] Basic entity relationships and annotations

### ⚠️ Known Issues (Need fixing)
- [ ] Compilation errors due to mixed javax/jakarta imports
- [ ] Incorrect @Column annotation usage (mixing Spring Data and JPA)
- [ ] Missing proper validation annotations
- [ ] Missing @Inheritance strategy annotation on base Task entity

### ❌ Not Yet Implemented
- [ ] PR Company system (Contact and embedded Name entities)
- [ ] SQL vs JPQL comparison documentation
- [ ] Repository interfaces for data access
- [ ] Service layer implementation
- [ ] REST controllers (if needed)
- [ ] Database schema and data initialization
- [ ] Comprehensive unit tests

## Setup Instructions

### Prerequisites
- Java 17 or higher
- Maven 3.6+ or use included Maven wrapper
- MySQL database (optional for initial development)

### Building the Project

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Enterprise-Java-Development-3.06/task
   ```

2. **Build with Maven wrapper**
   ```bash
   ./mvnw clean compile
   ```

3. **Run tests**
   ```bash
   ./mvnw test
   ```

4. **Run the application**
   ```bash
   ./mvnw spring-boot:run
   ```

### Database Configuration

Currently configured for MySQL. Update `src/main/resources/application.properties` with your database settings:

```properties
spring.application.name=task
# Add database configuration as needed
spring.datasource.url=jdbc:mysql://localhost:3306/task_management
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
```

## Task Completion Checklist

### Phase 1: Fix Current Implementation
- [ ] Resolve compilation errors in existing Task entities
- [ ] Fix import statements (use jakarta.persistence.* consistently)
- [ ] Correct @Column annotations to use JPA instead of Spring Data
- [ ] Add proper @Inheritance strategy to Task entity
- [ ] Add missing validation annotations
- [ ] Ensure project builds successfully

### Phase 2: Complete Task Management System  
- [ ] Create TaskRepository interface
- [ ] Add service layer for business logic
- [ ] Create unit tests for all entities
- [ ] Add integration tests
- [ ] Document the inheritance strategy used

### Phase 3: Implement PR Company System
- [ ] Create Name embeddable entity with firstName, lastName, middleName, salutation
- [ ] Create Contact entity with embedded Name
- [ ] Add title and company fields to Contact
- [ ] Create ContactRepository interface
- [ ] Add service layer for Contact management
- [ ] Create comprehensive tests for embedded entities

### Phase 4: Documentation and Analysis
- [ ] Document 3 native SQL tasks that cannot be done with JPQL
- [ ] Provide concrete examples of each SQL task
- [ ] Explain technical reasons for choosing native SQL
- [ ] Add code examples demonstrating the differences
- [ ] Update this README with final implementation details

### Phase 5: Final Polish
- [ ] Add comprehensive JavaDoc comments
- [ ] Create database initialization scripts
- [ ] Add example data and use cases
- [ ] Performance optimization notes
- [ ] Deployment documentation

## Issue Tracking

This project includes comprehensive issue tracking based on the task completion checklist above:

- **[ISSUES.md](./ISSUES.md)** - Detailed breakdown of all 23 issues with acceptance criteria
- **[ISSUE_SUMMARY.md](./ISSUE_SUMMARY.md)** - Quick reference table of all issues by phase
- **[GITHUB_ISSUE_TEMPLATES.md](./GITHUB_ISSUE_TEMPLATES.md)** - Templates for creating GitHub issues
- **[PROJECT_BOARD_SETUP.md](./PROJECT_BOARD_SETUP.md)** - GitHub Project Board configuration guide

### Quick Start with Issues

1. Review the [ISSUE_SUMMARY.md](./ISSUE_SUMMARY.md) for an overview
2. Start with **Phase 1** (Issues #1-5) - these are critical compilation fixes
3. Use the templates in [GITHUB_ISSUE_TEMPLATES.md](./GITHUB_ISSUE_TEMPLATES.md) to create GitHub issues
4. Set up a project board using [PROJECT_BOARD_SETUP.md](./PROJECT_BOARD_SETUP.md)

## Follow-up Plan

1. **Immediate Priority**: Fix compilation errors to get a working baseline (Issues #1-5)
2. **Short-term**: Complete the Task Management system implementation (Issues #6-10)
3. **Medium-term**: Implement the PR Company system with embedded entities (Issues #11-15)
4. **Long-term**: Add comprehensive documentation and SQL vs JPQL analysis (Issues #16-23)

## Contributing

This is an educational exercise project. Follow the requirements in `task/instructions.txt` and ensure all implementations align with JPA best practices and Spring Boot conventions.

## Learning Objectives

Through this exercise, you will learn:
- JPA entity inheritance strategies
- Embedded entities and their use cases  
- Differences between JPQL and native SQL
- Spring Data JPA repository patterns
- Enterprise application architecture patterns
